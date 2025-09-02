import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:service_admin/core/enums/state_type.dart';

class NewProductImageState extends Equatable {
  final List<String> images;
  final List<File> selectedImages;
  final String productUuid;
  final StateType stateType;

  const NewProductImageState({
    required this.images,
    required this.productUuid,
    required this.selectedImages,
    required this.stateType,
  });

  factory NewProductImageState.initial() {
    return const NewProductImageState(
      images: [],
      productUuid: '',
      selectedImages: [],
      stateType: StateType.initial,
    );
  }

  copyWith({
    List<String>? images,
    String? productUuid,
    List<File>? selectedImages,
    StateType? stateType,
  }) {
    return NewProductImageState(
      images: images ?? this.images,
      productUuid: productUuid ?? this.productUuid,
      selectedImages: selectedImages ?? this.selectedImages,
      stateType: stateType ?? this.stateType,
    );
  }

  @override
  List<Object?> get props => [images, productUuid, selectedImages, stateType];
}
