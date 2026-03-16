import 'package:equatable/equatable.dart';

import '../../domain/entities/shop.dart';

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

class ShopLoaded extends ShopState {
  final List<Shop> shops;
  final bool isFiltered;

  const ShopLoaded({required this.shops, this.isFiltered = false});

  @override
  List<Object?> get props => [shops, isFiltered];
}

class ShopError extends ShopState {
  final String message;

  const ShopError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ShopEmpty extends ShopState {
  final String query;

  const ShopEmpty({required this.query});

  @override
  List<Object?> get props => [query];
}
