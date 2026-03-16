import '../entities/shop.dart';
import '../entities/sort_type.dart';

/// Sorts a copy of [shops] according to [sortType].
/// Pass [locale] ('en' or 'ar') for alphabetical sort.
class SortShopsUseCase {
  const SortShopsUseCase();

  List<Shop> call(List<Shop> shops, SortType sortType, {String locale = 'en'}) {
    if (sortType == SortType.none) return shops;

    final sorted = List<Shop>.from(shops);
    switch (sortType) {
      case SortType.eta:
        sorted.sort((a, b) => _parseMinutes(a.estimatedDeliveryTime)
            .compareTo(_parseMinutes(b.estimatedDeliveryTime)));
      case SortType.minimumOrder:
        sorted.sort((a, b) => a.minimumOrderAmount.compareTo(b.minimumOrderAmount));
      case SortType.alphabetical:
        if (locale == 'ar') {
          sorted.sort((a, b) => a.nameAr.compareTo(b.nameAr));
        } else {
          sorted.sort((a, b) => a.nameEn.compareTo(b.nameEn));
        }
      case SortType.deliveryFeeAsc:
        sorted.sort((a, b) => a.deliveryFee.compareTo(b.deliveryFee));
      case SortType.deliveryFeeDesc:
        sorted.sort((a, b) => b.deliveryFee.compareTo(a.deliveryFee));
      case SortType.none:
        break;
    }
    return sorted;
  }

  int _parseMinutes(String eta) {
    final match = RegExp(r'(\d+)').firstMatch(eta);
    return match != null ? int.parse(match.group(1)!) : 0;
  }
}