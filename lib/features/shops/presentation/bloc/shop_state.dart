import 'package:equatable/equatable.dart';

import '../../domain/entities/shop.dart';
import '../../domain/entities/sort_type.dart';

export '../../domain/entities/sort_type.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object?> get props => [];
}

class ShopInitial extends ShopState {
  const ShopInitial();
}

class ShopLoading extends ShopState {
  const ShopLoading();
}

/// Success state — carries the full UI configuration so the UI never has to
/// guess what filters are currently active.
class ShopLoaded extends ShopState {
  final List<Shop> displayedShops;
  final List<Shop> featuredShops;
  final bool isOpenOnly;
  final SortType activeSort;
  final String activeQuery;

  const ShopLoaded({
    required this.displayedShops,
    this.featuredShops = const [],
    this.isOpenOnly = false,
    this.activeSort = SortType.none,
    this.activeQuery = '',
  });

  ShopLoaded copyWith({
    List<Shop>? displayedShops,
    List<Shop>? featuredShops,
    bool? isOpenOnly,
    SortType? activeSort,
    String? activeQuery,
  }) =>
      ShopLoaded(
        displayedShops: displayedShops ?? this.displayedShops,
        featuredShops: featuredShops ?? this.featuredShops,
        isOpenOnly: isOpenOnly ?? this.isOpenOnly,
        activeSort: activeSort ?? this.activeSort,
        activeQuery: activeQuery ?? this.activeQuery,
      );

  @override
  List<Object?> get props =>
      [displayedShops, featuredShops, isOpenOnly, activeSort, activeQuery];
}

/// A local filter/search returned zero results — distinct from an API error.
class ShopEmpty extends ShopState {
  final String query;

  const ShopEmpty({this.query = ''});

  @override
  List<Object?> get props => [query];
}

/// The network call failed.
class ShopError extends ShopState {
  final String message;

  const ShopError({required this.message});

  @override
  List<Object?> get props => [message];
}
