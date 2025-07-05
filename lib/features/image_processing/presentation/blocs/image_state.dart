import 'package:equatable/equatable.dart';
import '../../domain/entities/upload_record.dart';

class ImageState extends Equatable {
  final List<UploadRecord> history;
  final int selectedCategoryIndex;
  final bool isUploading;

  const ImageState({
    this.history = const [],
    this.selectedCategoryIndex = 0,
    this.isUploading = false,
  });

  ImageState copyWith({
    List<UploadRecord>? history,
    int? selectedCategoryIndex,
    bool? isUploading,
  }) {
    return ImageState(
      history: history ?? this.history,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      isUploading: isUploading ?? this.isUploading,
    );
  }

  @override
  List<Object?> get props => [history, selectedCategoryIndex, isUploading];
}
