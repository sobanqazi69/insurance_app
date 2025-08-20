import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> login(String email, String password);
  Future<Either<Failure, UserModel>> register(String email, String password, String firstName, String lastName);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserModel>> checkAuthStatus();
}
