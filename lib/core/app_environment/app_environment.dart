import 'package:dishlocal/firebase_options_dev.dart' as dev_options;
import 'package:dishlocal/firebase_options_prod.dart' as prod_options;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  static bool get isInDevelopment {
    const String environment = String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: 'dev',
    );
    return environment == 'dev';
  }

  //Cloudinary
  static String get cloudinaryApiKey {
    if (isInDevelopment) {
      return dotenv.env['CLOUDINARY_API_KEY'] ?? '';
    }
    return dotenv.env['CLOUDINARY_API_KEY'] ?? '';
  }

  static String get cloudinaryUrl {
    if (isInDevelopment) {
      return dotenv.env['CLOUDINARY_URL'] ?? '';
    }
    return dotenv.env['CLOUDINARY_URL'] ?? '';
  }

  static String get cloudinaryApiSecret {
    if (isInDevelopment) {
      return dotenv.env['CLOUDINARY_API_SECRET'] ?? '';
    }
    return dotenv.env['CLOUDINARY_API_SECRET'] ?? '';
  }

  //Supabase
  static String get supabaseUrl {
    if (isInDevelopment) {
      return dotenv.env['SUPABASE_URL_DEV'] ?? '';
    }
    return dotenv.env['SUPABASE_URL_PROD'] ?? '';
  }

  static String get supabaseAnonKey {
    if (isInDevelopment) {
      return dotenv.env['SUPABASE_ANON_KEY_DEV'] ?? '';
    }
    return dotenv.env['SUPABASE_ANON_KEY_PROD'] ?? '';
  }

  //Google Service
  static String get googleWebClientId {
    if (isInDevelopment) {
      return dotenv.env['GOOGLE_WEB_CLIENT_ID_DEV'] ?? '';
    }
    return dotenv.env['GOOGLE_WEB_CLIENT_ID_PROD'] ?? '';
  }

  //Sightengine
  static String get sightengineApiUser {
    if (isInDevelopment) {
      return dotenv.env['SIGHTENGINE_API_USER'] ?? '';
    }
    return dotenv.env['SIGHTENGINE_API_USER'] ?? '';
  }

  static String get sightengineApiSecret {
    if (isInDevelopment) {
      return dotenv.env['SIGHTENGINE_API_SECRET'] ?? '';
    }
    return dotenv.env['SIGHTENGINE_API_SECRET'] ?? '';
  }

  //OpenAI
  static String get openAiApiKey {
    if (isInDevelopment) {
      return dotenv.env['OPENAI_API_KEY_DEV'] ?? '';
    }
    return dotenv.env['OPENAI_API_KEY_PROD'] ?? '';
  }

  //Firebase
  static FirebaseOptions get firebaseOption {
    if (isInDevelopment) {
      return dev_options.DefaultFirebaseOptions.currentPlatform;
    }
    return prod_options.DefaultFirebaseOptions.currentPlatform;
  }
}
