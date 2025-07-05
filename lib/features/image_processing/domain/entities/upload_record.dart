enum UploadStatus { pending, success, error }

class UploadRecord {
  final String category;
  final DateTime timestamp;
  final UploadStatus status;
  final String? resultJson;
  final String? errorMessage;
  final String filePath;

  UploadRecord({
    required this.category,
    required this.timestamp,
    required this.status,
    required this.filePath,
    this.resultJson,
    this.errorMessage,
  });

  UploadRecord copyWith({
    UploadStatus? status,
    String? resultJson,
    String? errorMessage,
  }) {
    return UploadRecord(
      category: category,
      timestamp: timestamp,
      status: status ?? this.status,
      filePath: filePath,
      resultJson: resultJson ?? this.resultJson,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
