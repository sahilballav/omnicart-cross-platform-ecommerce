import '../../domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String firstName, String lastName);
  Future<User?> getProfile();
  Future<bool> isAuthenticated();
  Future<void> logout();
}
