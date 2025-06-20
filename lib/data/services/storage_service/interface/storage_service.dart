import 'dart:io';

abstract class StorageService {

  Future<String> uploadFile({
    required String path,
    required File file,
    required String publicId,
  });

  Future<void> deleteFile({
    required String path,
  });
}
