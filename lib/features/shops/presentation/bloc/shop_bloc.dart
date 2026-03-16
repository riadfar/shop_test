import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/event_transformers.dart';
import '../../domain/entities/shop.dart';
import '../../domain/repositories/shop_repository.dart';
import '../../domain/use_cases/compute_featured_shops.dart';
import '../../domain/use_cases/filter_shops.dart';
import '../../domain/use_cases/sort_shops.dart';
import 'shop_event.dart';
import 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopRepository _repository;
  final FilterShopsUseCase _filterShops;
  final SortShopsUseCase _sortShops;

  List<Shop> _originalShops = [];
  List<Shop> _featuredShops = [];
  String _locale = 'en';

  ShopBloc({
    required ShopRepository repository,
    required FilterShopsUseCase filterShops,
    required SortShopsUseCase sortShops,
  })  : _repository = repository,
        _filterShops = filterShops,
        _sortShops = sortShops,
        super(const ShopInitial()) {
    on<FetchShops>(_onFetchShops);
    on<SearchShops>(_onSearchShops,
        transformer: debounceTransformer(const Duration(milliseconds: 500)));
    on<SortShops>(_onSortShops);
    on<ToggleOpenOnly>(_onToggleOpenOnly);
    on<ClearFilters>(_onClearFilters);
  }

  Future<void> _onFetchShops(FetchShops event, Emitter<ShopState> emit) async {
    emit(const ShopLoading());
    final result = await _repository.getShops();
    result.fold(
      (failure) => emit(ShopError(message: failure.message)),
      (shops) {
        _originalShops = shops;
        _featuredShops = computeFeaturedShops(shops);
        emit(ShopLoaded(displayedShops: shops, featuredShops: _featuredShops));
      },
    );
  }

  void _onSearchShops(SearchShops event, Emitter<ShopState> emit) {
    final current = _loaded;
    final filtered = _filterShops(
      shops: _originalShops,
      query: event.query,
      openOnly: current?.isOpenOnly ?? false,
    );
    final sorted = _sortShops(
      filtered,
      current?.activeSort ?? SortType.none,
      locale: _locale,
    );
    if (sorted.isEmpty) {
      emit(ShopEmpty(query: event.query));
    } else {
      emit((current ?? const ShopLoaded(displayedShops: []))
          .copyWith(displayedShops: sorted, activeQuery: event.query));
    }
  }

  void _onSortShops(SortShops event, Emitter<ShopState> emit) {
    if (_loaded == null) return;
    _locale = event.locale;
    final current = _loaded!;
    final sorted = _sortShops(current.displayedShops, event.sortType,
        locale: _locale);
    emit(current.copyWith(displayedShops: sorted, activeSort: event.sortType));
  }

  void _onToggleOpenOnly(ToggleOpenOnly event, Emitter<ShopState> emit) {
    if (_loaded == null) return;
    final current = _loaded!;
    final newOpenOnly = !current.isOpenOnly;
    final filtered = _filterShops(
      shops: _originalShops,
      query: current.activeQuery,
      openOnly: newOpenOnly,
    );
    final sorted = _sortShops(filtered, current.activeSort, locale: _locale);
    if (sorted.isEmpty) {
      emit(ShopEmpty(query: current.activeQuery));
    } else {
      emit(current.copyWith(displayedShops: sorted, isOpenOnly: newOpenOnly));
    }
  }

  void _onClearFilters(ClearFilters event, Emitter<ShopState> emit) =>
      emit(ShopLoaded(
          displayedShops: _originalShops, featuredShops: _featuredShops));

  ShopLoaded? get _loaded => state is ShopLoaded ? state as ShopLoaded : null;
}