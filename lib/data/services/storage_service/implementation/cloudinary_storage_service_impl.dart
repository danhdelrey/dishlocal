import 'dart:io';

import 'package:dishlocal/data/services/storage_service/interface/storage_service.dart';

class CloudinaryStorageServiceImpl implements StorageService {
  @override
  Future<void> deleteFile({required String path}) {
    // TODO: implement deleteFile
    throw UnimplementedError();
  }

  @override
  Future<String> uploadFile({required String path, required File file}) {
    // TODO: implement uploadFile
    throw UnimplementedError();
  }
}