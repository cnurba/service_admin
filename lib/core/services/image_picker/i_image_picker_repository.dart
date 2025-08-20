import 'dart:io';

abstract class IImagePickerRepository {
  Future<(File?,String)> pickImageFromGallery(String catalog);
  Future<File?> pickImageFromCamera();
}