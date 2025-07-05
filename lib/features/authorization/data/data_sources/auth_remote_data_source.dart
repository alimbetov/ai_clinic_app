class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // simulate network delay
    return {
      'id': 1,
      'email': email,
      'name': 'Test User',
      'token': 'mock_jwt_token_123'
    };
  }
}
