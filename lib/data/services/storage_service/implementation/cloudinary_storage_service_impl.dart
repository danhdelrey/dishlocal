import 'dart:io';

import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:dishlocal/data/services/storage_service/interface/storage_service.dart';
import 'package:dishlocal/main.dart';
import 'package:cloudinary_api/src/request/model/uploader_params.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: StorageService)
class CloudinaryStorageServiceImpl implements StorageService {

  final _log = Logger('CloudinaryStorageServiceImpl');
  
  @override
  Future<void> deleteFile({required String path}) {
    // TODO: implement deleteFile
    throw UnimplementedError();
  }

  @override
  Future<String> uploadFile({required String path, required File file, required String publicId}) async {
    var response = await cloudinary.uploader().upload(
          file,
          params: UploadParams(
            publicId: publicId,
            uniqueFilename: false,
            overwrite: true,
          ),
        );

    String url = cloudinary.image(publicId).toString();
    return url;
  }
}
