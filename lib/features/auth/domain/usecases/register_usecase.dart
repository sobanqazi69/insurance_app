import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/models/user_model.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, UserModel>> call(RegisterParams params) async {
    try {
      return await repository.register(
        params.email, 
        params.password, 
        params.firstName, 
        params.lastName
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

class RegisterParams {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  RegisterParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}
