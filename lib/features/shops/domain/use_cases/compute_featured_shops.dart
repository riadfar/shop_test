import '../entities/shop.dart';

/// Returns ≤ 3 featured shops: open first, closed as fill.
List<Shop> computeFeaturedShops(List<Shop> shops) {
  final open = shops.where((s) => s.availability).take(3).toList();
  if (open.length >= 3) return open;
  final closed = shops.where((s) => !s.availability);
  return [...open, ...closed.take(3 - open.length)];
}
