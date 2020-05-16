import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:glassapp/app/home/home_scaffold.dart';
import 'package:glassapp/app/home/splash.dart';

class App extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      locale: Locale('zh'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home:SplashPage(),
    );
  }

  // Widget findDefaultRoute(String route) {
  //   switch (route) {
  //     case main_home_cache_id:
  //       return HomePage();
  //     case audio_room_cache_id:
  //       return RoomListPage();
  //     case default_home_cache_id:
  //       return HomeScaffold();
  //     default:
  //       return HomeScaffold();
  //   }
  // }
}

// class DefaultRoutePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text("i'm default route page"),
//       ),
//     );
//   }
// }
