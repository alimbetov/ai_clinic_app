import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();
}

class CategoryChanged extends ImageEvent {
  final int index;

  const CategoryChanged(this.index);

  @override
  List<Object?> get props => [index];
}

class ImagePicked extends ImageEvent {
  final File file;

  const ImagePicked(this.file);

  @override
  List<Object?> get props => [file];
}

class UploadImageRequested extends ImageEvent {
  final File file;

  UploadImageRequested(this.file);

  @override
  List<Object?> get props => [file];
}
