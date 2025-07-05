import 'dart:io';
import '../repositories/image_repository.dart';

class UploadImage {
  final ImageRepository repository;

  UploadImage(this.repository);

  Future<Map<String, dynamic>> call(File file, String category) {
    return repository.uploadImage(file, category);
  }
}
