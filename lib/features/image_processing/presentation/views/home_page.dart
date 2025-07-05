import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/image_picker_helper.dart';
import '../../domain/entities/upload_record.dart';
import '../blocs/image_bloc.dart';
import '../blocs/image_event.dart';
import '../blocs/image_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final categories = const ['Classification', 'Segmentation', 'Detection'];

  Future<void> _pickImage(BuildContext context) async {
    final file = await ImagePickerHelper.pickImage();
    if (file != null) {
      context.read<ImageBloc>().add(UploadImageRequested(file));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Clinic')),
      body: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          return Column(
            children: [
              // 🔄 Показываем прогресс загрузки
              if (state.isUploading)
                const LinearProgressIndicator(minHeight: 4),

              // ✅ Последний успешный результат
              if (state.history.isNotEmpty &&
                  state.history.first.status == UploadStatus.success)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Результат:\n${state.history.first.resultJson}",
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

              // ❌ Последняя ошибка
              if (state.history.isNotEmpty &&
                  state.history.first.status == UploadStatus.error)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Ошибка: ${state.history.first.errorMessage}",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              // Карусель категорий
              SizedBox(
                height: 120,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.6),
                  onPageChanged: (index) =>
                      context.read<ImageBloc>().add(CategoryChanged(index)),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == state.selectedCategoryIndex;
                    return Transform.scale(
                      scale: isSelected ? 1.1 : 0.9,
                      child: Card(
                        color: isSelected ? Colors.blue[200] : Colors.grey[300],
                        child: Center(child: Text(categories[index])),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),

              // Кнопка выбора изображения
              ElevatedButton.icon(
                onPressed: () => _pickImage(context),
                icon: const Icon(Icons.photo),
                label: const Text('Выбрать изображение'),
              ),

              const SizedBox(height: 8),

              if (state.isUploading)
                const LinearProgressIndicator(minHeight: 4),

              const SizedBox(height: 8),

              // История отправок
              Expanded(
                child: ListView.builder(
                  itemCount: state.history.length,
                  itemBuilder: (context, index) {
                    final record = state.history[index];
                    return Card(
                      child: ListTile(
                        leading: Image.file(
                          File(record.filePath),
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image_not_supported),
                        ),
                        title: Text(record.category),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${record.timestamp.toLocal()} (${record.status.name})'),
                            if (record.resultJson != null)
                              Text(record.resultJson!,
                                  maxLines: 2, overflow: TextOverflow.ellipsis),
                            if (record.errorMessage != null)
                              Text(record.errorMessage!,
                                  style: const TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
