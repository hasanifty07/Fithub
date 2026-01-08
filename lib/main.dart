import 'login_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// Note: 'fithub_by_ifty' must match your pubspec.yaml name

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Replace these with your actual keys from Supabase Dashboard
/*  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
  );*/
  await Supabase.initialize(
    url: 'https://ysonzkinkqfmjafcrlxm.supabase.co', // Paste your real URL here
    anonKey:
        'sb_publishable_eNip9SHVVlQlTQsGagU5LA_A7mTCzUF', // Paste your real Key here
  );
  runApp(const FitHubApp());
}

class FitHubApp extends StatelessWidget {
  const FitHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
      ),
      home: const LoginPage(),
    );
  }
}
