import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/shop.dart';

abstract class ShopRepository {
  Future<Either<Failure, List<Shop>>> getShops();
}
