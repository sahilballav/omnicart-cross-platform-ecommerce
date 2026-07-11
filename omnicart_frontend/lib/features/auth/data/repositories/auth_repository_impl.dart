import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<User> login(String email, String password) async {
    final responseData = await remoteDataSource.login(email, password);
    final String token = responseData['token'] as String;
    final userModel = UserModel.fromJson(responseData['user'] as Map<String, dynamic>);
    
    await localDataSource.cacheToken(token);
    return userModel;
  }

  @override
  Future<User> register(String email, String password, String firstName, String lastName) async {
    final responseData = await remoteDataSource.register(email, password, firstName, lastName);
    final String token = responseData['token'] as String;
    final userModel = UserModel.fromJson(responseData['user'] as Map<String, dynamic>);
    
    await localDataSource.cacheToken(token);
    return userModel;
  }

  @override
  Future<User?> getProfile() async {
    final token = await localDataSource.getToken();
    if (token == null) return null;
    try {
      return await remoteDataSource.getProfile(token);
    } catch (e) {
      await localDataSource.clearCache();
      return null;
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await localDataSource.getToken();
    return token != null;
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearCache();
  }
}
