import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/core/services/image_picker/i_image_picker_repository.dart';
import 'package:service_admin/core/services/image_picker/image_picker_repository.dart';
import 'package:service_admin/injection.dart';

/// This provider is used to access the image picker repository.
/// It provides an instance of [IImagePickerRepository] which is used to pick images
/// from the gallery or camera.
/// It is a regular provider, meaning it will not be disposed of automatically.
final imageRepositoryProvider = Provider<IImagePickerRepository>(
  (ref) => ImagePickerRepository(getIt()),
);
