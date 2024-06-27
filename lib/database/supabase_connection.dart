import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_do/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  // TODO: Create DB Structure
  // TODO: Create Consent screen

  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  String url = dotenv.env['url']!;
  String anonKey = dotenv.env['anonKey']!;

  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
  );
  // runApp(MyApp());
}
