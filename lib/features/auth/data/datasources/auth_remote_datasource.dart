import '../../../../shared/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String firstName, String lastName);
  Future<void> logout();
  Future<UserModel> checkAuthStatus();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    // Placeholder implementation
    throw UnimplementedError();
  }

  @override
  Future<UserModel> register(String email, String password, String firstName, String lastName) async {
    // Placeholder implementation
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    // Placeholder implementation
    throw UnimplementedError();
  }

  @override
  Future<UserModel> checkAuthStatus() async {
    // Placeholder implementation
    throw UnimplementedError();
  }
}
