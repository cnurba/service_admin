import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_admin/core/http/endpoints.dart';
import 'package:service_admin/core/services/image_picker/i_image_picker_repository.dart';

class ImagePickerRepository implements IImagePickerRepository {
  final Dio _dio;
  ImagePickerRepository(this._dio);

  @override
  Future<File?> pickImageFromCamera() async {
    try {
      // Create an instance of ImagePicker
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      // Convert XFile into File
      File file = File(image!.path);

      // print('Image picked');
      return file;
    } catch (e) {
      log('Error picking image: $e');
      return null;
    }
  }

  @override
  Future<(File?, String)> pickImageFromGallery(String catalog) async {
    try {
      // Create an instance of ImagePicker
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      // Convert XFile into File
      File file = File(image!.path);

      final result = await _dio.post(
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'catalog': catalog,
          },
        ),
        Endpoints.files.file,
        data: FormData.fromMap({
          'image1': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
        }),
      );
      if (result.data.isEmpty) {
        return (null, "No data returned from server");
      }
      return (file, result.data[0]['path'] as String);
    } catch (e) {
      log("Error uploading image: $e");
      return (null, "Failed to upload image");
    }
  }
}
