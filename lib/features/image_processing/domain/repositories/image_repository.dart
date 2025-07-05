import 'dart:io';

abstract class ImageRepository {
  Future<Map<String, dynamic>> uploadImage(File file, String token);
}
