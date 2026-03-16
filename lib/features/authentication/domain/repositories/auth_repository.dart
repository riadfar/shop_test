import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(String email, String password, String name);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User?>> getCurrentUser();
  Future<Either<Failure, String>> refreshToken();
  Future<Either<Failure, void>> forgotPassword(String email);
  Future<Either<Failure, User>> updateProfile({String? name, String? avatarUrl});
}