import 'dart:io';

import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:dishlocal/data/services/storage_service/interface/storage_service.dart';
import 'package:cloudinary_api/src/request/model/uploader_params.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: StorageService)
class CloudinaryStorageServiceImpl implements StorageService {

  final _log = Logger('CloudinaryStorageServiceImpl');
  final cloudinary = Cloudinary.fromStringUrl(dotenv.env['CLOUDINARY_URL'] as String);
  
  @override
  Future<void> deleteFile({required String path}) {
    // TODO: implement deleteFile
    throw UnimplementedError();
  }

  @override
  Future<String> uploadFile({required String path, required File file, required String publicId}) async {
    cloudinary.config.urlConfig.secure = true;
    var response = await cloudinary.uploader().upload(
          file,
          params: UploadParams(
            folder: 'posts',
            publicId: publicId,
            uniqueFilename: false,
            overwrite: true,
          ),
        );

    String url = cloudinary.image(publicId).toString();
    return url;
  }
}
