import 'package:ai_clinic_app/features/image_processing/presentation/blocs/image_event.dart';
import 'package:ai_clinic_app/features/image_processing/presentation/blocs/image_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/upload_record.dart';
import '../../domain/use_cases/upload_image.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final UploadImage uploadImageUseCase;

  ImageBloc(this.uploadImageUseCase) : super(const ImageState()) {
    on<UploadImageRequested>((event, emit) async {
      emit(state.copyWith(isUploading: true));

      try {
        final result = await uploadImageUseCase(
            event.file, 'Category ${state.selectedCategoryIndex}');

        final newRecord = UploadRecord(
          filePath: event.file.path,
          category: 'Category ${state.selectedCategoryIndex}',
          timestamp: DateTime.now(),
          status: UploadStatus.success,
          resultJson: result.toString(),
        );

        emit(state.copyWith(
          history: [newRecord, ...state.history],
          isUploading: false,
        ));
      } catch (e) {
        final errorRecord = UploadRecord(
          filePath: event.file.path,
          category: 'Category ${state.selectedCategoryIndex}',
          timestamp: DateTime.now(),
          status: UploadStatus.error,
          errorMessage: e.toString(),
        );

        emit(state.copyWith(
          history: [errorRecord, ...state.history],
          isUploading: false,
        ));
      }
    });

    on<CategoryChanged>((event, emit) {
      emit(state.copyWith(selectedCategoryIndex: event.index));
    });

    on<ImagePicked>(_onImagePicked);
  }

  Future<void> _onImagePicked(
      ImagePicked event, Emitter<ImageState> emit) async {
    // Просто пробрасываем в UploadImageRequested
    add(UploadImageRequested(event.file));
  }
}
