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
    // Mock implementation for testing
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    return UserModel(
      id: '1',
      email: email,
      firstName: 'John',
      lastName: 'Doe',
      phoneNumber: '+1234567890',
      isEmailVerified: true,
      isPhoneVerified: false,
      role: 'user',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<UserModel> register(String email, String password, String firstName, String lastName) async {
    // Mock implementation for testing
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    return UserModel(
      id: '1',
      email: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: null,
      isEmailVerified: false,
      isPhoneVerified: false,
      role: 'user',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<void> logout() async {
    // Mock implementation for testing
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<UserModel> checkAuthStatus() async {
    // Mock implementation for testing
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Return null to indicate no authenticated user
    throw Exception('No authenticated user');
  }
}
