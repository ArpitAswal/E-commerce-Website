import 'package:ecommerce_shopping_website/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'GlobalColors/colors.dart';
import 'Screens/flash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter 3.0.4 ',
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldColor,
          primaryColor: cardColor,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: iconsColor,
            ),
            shadowColor: iconsColor,
            backgroundColor: scaffoldColor,
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: textColor, fontSize: 22, fontWeight: FontWeight.bold),
            elevation: 5,
          ),
          iconTheme: IconThemeData(
            color: iconsColor,
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.black,
            selectionColor: Colors.blue,
          ),
          cardColor: cardColor,
          brightness: Brightness.light,
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(
            secondary: iconsColor,
            brightness: Brightness.light,
          )
              .copyWith(background: backgroundColor),
        ),
        home: const LogInScreen()
      //const FlashScreen()
    );
  }
}