import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/shop.dart';
import '../../domain/repositories/shop_repository.dart';
import 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  final ShopRepository repository;

  List<Shop> _allShops = [];
  Timer? _debounce;
  bool _openOnly = false;

  ShopCubit(this.repository) : super(const ShopInitial());

  Future<void> fetchShops() async {
    emit(const ShopLoading());
    final result = await repository.getShops();
    result.fold(
      (failure) => emit(ShopError(message: failure.message)),
      (shops) {
        _allShops = shops;
        emit(ShopLoaded(shops: _applyFilters(shops)));
      },
    );
  }

  void searchShops(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        emit(ShopLoaded(shops: _applyFilters(_allShops)));
        return;
      }
      final lower = query.toLowerCase();
      final filtered = _allShops.where((s) {
        return s.nameEn.toLowerCase().contains(lower) ||
            s.nameAr.toLowerCase().contains(lower) ||
            s.descriptionEn.toLowerCase().contains(lower) ||
            s.descriptionAr.toLowerCase().contains(lower);
      }).toList();

      if (filtered.isEmpty) {
        emit(ShopEmpty(query: query));
      } else {
        emit(ShopLoaded(shops: _applyFilters(filtered), isFiltered: true));
      }
    });
  }

  void sortByEta() {
    final current = _currentShops();
    final sorted = List<Shop>.from(current)
      ..sort((a, b) => _parseMinutes(a.estimatedDeliveryTime)
          .compareTo(_parseMinutes(b.estimatedDeliveryTime)));
    emit(ShopLoaded(shops: sorted, isFiltered: state is ShopLoaded && (state as ShopLoaded).isFiltered));
  }

  void sortByMinimumOrder() {
    final current = _currentShops();
    final sorted = List<Shop>.from(current)
      ..sort((a, b) => a.minimumOrderAmount.compareTo(b.minimumOrderAmount));
    emit(ShopLoaded(shops: sorted, isFiltered: state is ShopLoaded && (state as ShopLoaded).isFiltered));
  }

  void toggleOpenOnly() {
    _openOnly = !_openOnly;
    emit(ShopLoaded(shops: _applyFilters(_allShops)));
  }

  void clearSearch() {
    _debounce?.cancel();
    emit(ShopLoaded(shops: _applyFilters(_allShops)));
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  List<Shop> _applyFilters(List<Shop> shops) {
    if (!_openOnly) return shops;
    return shops.where((s) => s.availability).toList();
  }

  List<Shop> _currentShops() {
    if (state is ShopLoaded) return (state as ShopLoaded).shops;
    return _applyFilters(_allShops);
  }

  int _parseMinutes(String eta) {
    final match = RegExp(r'(\d+)').firstMatch(eta);
    return match != null ? int.parse(match.group(1)!) : 0;
  }
}
