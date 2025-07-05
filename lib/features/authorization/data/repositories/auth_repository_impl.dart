import 'package:ai_clinic_app/features/authorization/domain/entities/user.dart';

import '../../domain/repositories/auth_repository.dart' show AuthRepository;
import '../data_sources/auth_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<User> login(String email, String password) async {
    final response = await remote.login(email, password);

    final token = response['token'] as String;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    return User(
      id: response['id'],
      email: response['email'],
      name: response['name'],
      token: token,
    );
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  @override
  Future<String?> getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
