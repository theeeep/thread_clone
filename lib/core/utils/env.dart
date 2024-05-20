import 'package:flutter_dotenv/flutter_dotenv.dart';

class ENV {
  static final String supabaseUrl = dotenv.env["SUPABASE_URL"]!;
  static final String supabaseKey = dotenv.env["SUPABASE_KEY"]!;
}
