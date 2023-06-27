import 'package:ecommerce_shopping_website/Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Global/colors.dart';
import 'Screens/flash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: const FirebaseOptions(
    apiKey: "AIzaSyBVDKEf-BwcClL_LXTKsT11RBryuUq7byc",
    authDomain: "first-web-app-88191.firebaseapp.com",
    projectId: "first-web-app-88191",
    storageBucket: "first-web-app-88191.appspot.com",
    messagingSenderId: "790512872465",
    appId: "1:790512872465:web:d508df6d7c593d11f215b0"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final Future<FirebaseApp> initialization = Firebase.initializeApp();

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
        home: const LogInScreen());
        /*StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context,snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text('Error 404')
            );
          }
          if (snapshot.hasData) {
              return const FlashScreen(title:'Home');
            }
            else {
              return const FlashScreen(title:'LogIn');
            }
        })
    );*/
  }
}