import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Global/colors.dart';
import 'ProvidersClass/category_provider.dart';
import 'ProvidersClass/login_provider.dart';
import 'ProvidersClass/products_provider.dart';
import 'Screens/flash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBVDKEf-BwcClL_LXTKsT11RBryuUq7byc",
          authDomain: "first-web-app-88191.firebaseapp.com",
          projectId: "first-web-app-88191",
          storageBucket: "first-web-app-88191.appspot.com",
          messagingSenderId: "790512872465",
          appId: "1:790512872465:web:d508df6d7c593d11f215b0"));
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LoginProvider()),
    ChangeNotifierProvider(create: (context) => ProductsProvider()),
    ChangeNotifierProvider(create: (_) => CategoryProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<FirebaseApp> initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AA Shopping Mart',
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
            .copyWith(surface: backgroundColor),
      ),
      home: const FlashScreen(),
    );
  }
}
