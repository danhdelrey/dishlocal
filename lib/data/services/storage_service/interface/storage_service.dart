import 'dart:io';

abstract class StorageService {

  Future<String> uploadFile({
    required String folder,
    required File file,
    required String publicId,
  });

  Future<void> deleteFile({
    required String folder,
    required String publicId,
  });
}
