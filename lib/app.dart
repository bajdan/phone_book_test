import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:phone_book_test/screens/full_info/full_info_screen.dart';
import 'package:phone_book_test/screens/home/home_screen.dart';
import 'package:phone_book_test/screens/splash/splash_screen.dart';
import 'package:phone_book_test/screens/user_add/user_add_screen.dart';
import 'package:phone_book_test/utils/di.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DI(
      child: MaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        routes: {
          '/splash':(context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(),
          '/full_info' : (context) => const FullInfoScreen(),
          '/user_add' : (context) => const UserAddScreen(),
        },
        initialRoute: '/splash',
      ),
    );
  }
}
