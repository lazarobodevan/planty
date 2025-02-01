import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
     return '.env';
  }

  static String get apiUrl{
    if(!kReleaseMode){
      return dotenv.env['API_BASE_URL_PRD']!;
    }
    return dotenv.env['API_BASE_URL_DEV']!;

  }
}