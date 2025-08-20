import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, dynamic>> call(RegisterParams params) async {
    // Placeholder implementation
    return const Right(null);
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
