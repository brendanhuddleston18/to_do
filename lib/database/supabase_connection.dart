import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {

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
