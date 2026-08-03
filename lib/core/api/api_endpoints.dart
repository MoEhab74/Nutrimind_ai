import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  // Gemini API base url
  static const String baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/${ApiKeys.geminiFlashLite}:generateContent?key=';
  // Supabase API url
  static const String supabaseUrl = 'https://hxmrjzicbpvzpjsbazwc.supabase.co';
}

class ApiKeys {
  // Gemini API key
  static String? apiKey = dotenv.env['GEMINI_API_KEY'];

  // Supabase API anon key
  static String? supabaseAnonKey = dotenv.env['SUPABSAE_API_ANON_KEY'];
  // Models
  static const String geminiPro = "gemini-3-pro";
  static const String geminiFlash = "gemini-1.5-flash";
  static const String geminiFlashLite = "gemini-3.1-flash-lite";
  static const String gemini2Flash = "gemini-2.5-flash";
}
