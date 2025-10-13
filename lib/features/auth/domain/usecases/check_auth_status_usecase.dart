import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/models/user_model.dart';
import '../repositories/auth_repository.dart';
import 'logout_usecase.dart';

class CheckAuthStatusUseCase {
  final AuthRepository repository;

  CheckAuthStatusUseCase(this.repository);

  Future<Either<Failure, UserModel>> call(NoParams params) async {
    try {
      return await repository.checkAuthStatus();
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
