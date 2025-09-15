import 'package:equatable/equatable.dart';

class FailureModel extends Equatable {
  final String message;
  final bool hasError;
  const FailureModel({required this.message, this.hasError = false});
  @override
  List<Object?> get props => [message, hasError];
  factory FailureModel.empty() => FailureModel(message: '', hasError: false);

  factory FailureModel.fromJson(Map<String, dynamic> json) {
    return FailureModel(
      message: json['message'] ?? '',
      hasError: json['error'] ?? false,
    );
  }

  factory FailureModel.error(String message) => FailureModel(message: message, hasError: true);
}
