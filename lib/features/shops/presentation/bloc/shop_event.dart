import 'package:equatable/equatable.dart';

import '../../domain/entities/sort_type.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object?> get props => [];
}

class FetchShops extends ShopEvent {
  const FetchShops();
}

class SearchShops extends ShopEvent {
  final String query;
  const SearchShops(this.query);

  @override
  List<Object?> get props => [query];
}

/// [locale] is the current language code ('en' or 'ar') — used for
/// alphabetical sort so the BLoC can re-apply the same sort on filter/search.
class SortShops extends ShopEvent {
  final SortType sortType;
  final String locale;
  const SortShops(this.sortType, {this.locale = 'en'});

  @override
  List<Object?> get props => [sortType, locale];
}

class ToggleOpenOnly extends ShopEvent {
  const ToggleOpenOnly();
}

class ClearFilters extends ShopEvent {
  const ClearFilters();
}