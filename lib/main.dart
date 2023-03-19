import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt/screen/chatgpt.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ThemeData.light().colorScheme.copyWith(
              primary: Colors.white,
              onPrimary: Colors.black,
              secondary: Colors.deepOrange,
              onSecondary: Colors.white),
        ),
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: Colors.blueGrey,
              onPrimary: Colors.white,
              secondary: Colors.blueGrey,
              onSecondary: Colors.white),
        ),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        home: ChatGPT());
  }
}
