import 'package:dio/dio.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> register(String email, String password, String firstName, String lastName);
  Future<UserModel> getProfile(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  static const String baseUrl = 'http://localhost:8080/api/v1/auth'; // Pointing to API Gateway port 8080

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await dio.post(
      '$baseUrl/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> register(
      String email, String password, String firstName, String lastName) async {
    final response = await dio.post(
      '$baseUrl/register',
      data: {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
      },
    );
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<UserModel> getProfile(String token) async {
    final response = await dio.get(
      '$baseUrl/me',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }
}
