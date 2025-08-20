import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, void>> call(NoParams params) async {
    // Placeholder implementation
    return const Right(null);
  }
}

class NoParams {
  const NoParams();
}
