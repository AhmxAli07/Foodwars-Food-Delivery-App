// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:foodwars/Screens/Bottombar.dart';
import 'package:foodwars/Screens/Search.dart';
import 'package:foodwars/Screens/splash.dart';
import 'package:foodwars/Screens/view/home.dart';
import 'package:foodwars/Services/Goodmenu/fries.dart';
import 'package:foodwars/Services/HealthMenu/beef.dart';
import 'package:foodwars/Services/HealthMenu/fish.dart';
import 'package:foodwars/Services/SmartMenu/corn.dart';
import 'package:foodwars/Services/VeganMenu/pie.dart';
import 'package:foodwars/Services/healthy.dart';
import 'package:foodwars/Theme/theme.dart';
import 'package:foodwars/auth/login.dart';
import 'package:foodwars/auth/register.dart';
import 'package:foodwars/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/notification.dart';
import 'Services/Good.dart';
import 'Services/Goodmenu/Tea.dart';
import 'Services/Goodmenu/cake.dart';
import 'Services/Goodmenu/sandwitch.dart';
import 'Services/HealthMenu/Dount.dart';
import 'Services/HealthMenu/bread.dart';
import 'Services/SmartMenu/buffet.dart';
import 'Services/SmartMenu/ice.dart';
import 'Services/SmartMenu/pizza.dart';
import 'Services/VeganMenu/Avocado.dart';
import 'Services/VeganMenu/Russian.dart';
import 'Services/VeganMenu/mashroom.dart';
import 'Services/smart.dart';
import 'Services/vegan.dart';
import 'auth/forget.dart';
import 'auth/profileSEE.dart';
import 'auth/upload.dart';
import 'image/photos.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, value, child) {
            Color scaffoldColor = value.isDarkTheme
                ? Colors.black // Set your dark theme color
                : Color(0xFFF9F9F9); // Set your light theme color
            Color appbarColor = value.isDarkTheme ? Colors.black : Colors.white;
            Color elevatedColor =
                value.isDarkTheme ? Color(0xFF252525) : Colors.white;
            return MaterialApp(
              title: 'Foodwars',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                    surfaceTintColor:
                        WidgetStateProperty.all<Color>(elevatedColor),
                    overlayColor:
                        WidgetStateProperty.all<Color>(elevatedColor),
                    shadowColor:
                        WidgetStateProperty.all<Color>(elevatedColor),
                    backgroundColor:
                        WidgetStateProperty.all<Color>(elevatedColor),
                  ),
                ),
                appBarTheme: AppBarTheme(color: appbarColor),
                scaffoldBackgroundColor: scaffoldColor,
                textTheme: const TextTheme(
                    displayLarge: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4EE489)),
                    bodyLarge: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                    titleSmall: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                    ),
                    titleMedium:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.normal)),
                colorScheme: value.currentColorScheme,
              ),
              initialRoute: '/',
              routes: {
                '/': (context) => const splash(),
                '/nav': (context) => Navbar(),
                '/home': (context) => const Home(),
                '/login': (context) => login(),
                '/reg': (context) => register(),
                '/search': (context) => search(),
                '/good': (context) => GoodResto(),
                '/photo': (context) => photos(),
                '/fri': (context) => fries(),
                '/t': (context) => Tea(),
                '/sand': (context) => sandwitch(),
                '/cake': (context) => cake(),
                '/for': (context) => Forget(),
                '/upl': (context) => upload(),
                '/vegan': (context) => VeganResto(),
                '/avo': (context) => Avocado(),
                '/rus': (context) => russian(),
                '/mash': (context) => mashroom(),
                '/pie': (context) => pie(),
                '/smart': (context) => SmartResto(),
                '/healthy': (context) => HealthResto.HealthyResto(),
                '/dount': (context) => Dount(),
                '/bread': (context) => Bread(),
                '/fish': (context) => fish(),
                '/beef': (context) => beef(),
                '/ic': (context) => ice(),
                '/p': (context) => pizza(),
                '/buf': (context) => bufet(),
                '/co': (context) => corn(),
                '/see': (context) => profilsee(),
                '/not': (context) => NOTIFY()
              },
            );
          },
        ));
  }
}
//-------------------------------------New_Row----------------------------------