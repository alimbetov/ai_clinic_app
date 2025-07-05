import 'dart:io';

class ImageRemoteDataSource {
  Future<Map<String, dynamic>> uploadImage(
      File file, String category, String token) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate network delay
    return {
      'status': 'success',
      'category': category,
      'detected': ['pneumonia', 'nodule'],
      'confidence': 0.92,
    };
  }
}
