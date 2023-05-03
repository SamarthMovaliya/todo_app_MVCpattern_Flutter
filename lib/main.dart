import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_flutter/controller/theme_Controller.dart';
import 'package:todo_app_flutter/controller/time_controller.dart';
import 'package:todo_app_flutter/views/screens/HomePage.dart';
import 'package:todo_app_flutter/views/screens/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => TimeController()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          theme: ThemeData.light(
            useMaterial3: true,
          ),
          themeMode:
              (Provider.of<ThemeProvider>(context).themeModal.isDark == false)
                  ? ThemeMode.light
                  : ThemeMode.dark,
          initialRoute: 'SplashScreen',
          routes: {
            'HomePage': (context) => HomePage(),
            'SplashScreen': (context) => SplashScreen(),
          },
        );
      },
    );
  }
}
