import 'dart:io';

import '../../domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final String baseUrl;
  final bool useMock;

  ImageRepositoryImpl({
    required this.baseUrl,
    this.useMock = true, // по умолчанию — мок
  });

  @override
  Future<Map<String, dynamic>> uploadImage(File file, String token) async {
    if (useMock) {
      await Future.delayed(const Duration(seconds: 1)); // Имитируем загрузку

      final filename = file.path.split('/').last.toLowerCase();

      // Простейшее определение категории
      String category = 'classification';
      if (filename.contains('seg')) category = 'segmentation';
      if (filename.contains('det')) category = 'detection';

      return {
        'status': 'success',
        'message': 'Mock response for $category',
        'category': category,
        'confidence':
            (0.7 + (filename.length % 30) / 100.0), // псевдо случайность
        'fileName': filename,
      };
    }

    // Закомментированная реальная реализация
    /*
  final uri = Uri.parse('$baseUrl/upload');
  final request = http.MultipartRequest('POST', uri)
    ..headers['Authorization'] = 'Bearer $token'
    ..files.add(await http.MultipartFile.fromPath('file', file.path));

  final response = await request.send();

  if (response.statusCode == 200) {
    final body = await response.stream.bytesToString();
    return jsonDecode(body);
  } else {
    throw Exception('Failed to upload image: ${response.statusCode}');
  }
  */

    throw UnimplementedError(
        'uploadImage is not implemented for non-mock mode.');
  }
}
