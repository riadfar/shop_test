import '../entities/shop.dart';

/// Filters [shops] by keyword and/or open-only availability.
/// Pure function — no side effects, no I/O.
class FilterShopsUseCase {
  const FilterShopsUseCase();

  List<Shop> call({
    required List<Shop> shops,
    required String query,
    required bool openOnly,
  }) {
    var result = shops;

    if (query.isNotEmpty) {
      final lower = query.toLowerCase();
      result = result.where((s) {
        return s.nameEn.toLowerCase().contains(lower) ||
            s.nameAr.toLowerCase().contains(lower) ||
            s.descriptionEn.toLowerCase().contains(lower) ||
            s.descriptionAr.toLowerCase().contains(lower);
      }).toList();
    }

    if (openOnly) {
      result = result.where((s) => s.availability).toList();
    }

    return result;
  }
}
