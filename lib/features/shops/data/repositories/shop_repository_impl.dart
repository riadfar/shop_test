import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/shop.dart';
import '../../domain/repositories/shop_repository.dart';
import '../data_sources/shop_remote_data_source.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopRemoteDataSource remoteDataSource;

  const ShopRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Shop>>> getShops() async {
    try {
      final shops = await remoteDataSource.getShops();
      return Right(shops);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
