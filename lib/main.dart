import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_checklist/pages/category_page.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Notes SQLite';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,

    themeMode: ThemeMode.dark,
    theme: ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white10,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.pink,
        elevation: 0,
      ),
    ),
    home: NotesPage(),
  );
}