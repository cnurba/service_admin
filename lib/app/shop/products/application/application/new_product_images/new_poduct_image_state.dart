import 'package:equatable/equatable.dart';

class NewProductImageState extends Equatable{
  final List<String> images;
  final String productUuid;

  const NewProductImageState({
    required this.images,
    required this.productUuid,
  });

  factory NewProductImageState.initial() {
    return const NewProductImageState(
      images: [],
      productUuid: '',
    );
  }

  NewProductImageState copyWith({
    List<String>? images,
    String? productUuid,
  }) {
    return NewProductImageState(
      images: images ?? this.images,
      productUuid: productUuid ?? this.productUuid,
    );
  }

  @override
  List<Object?> get props => [images, productUuid];

}