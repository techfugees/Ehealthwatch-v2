import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';
import 'screens/screens.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppState()),
  ], child: MyApp()));
  // ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: SafeArea(child: IntroScreen()),
    );
  }
}
