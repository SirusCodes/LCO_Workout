import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lco_workout/animation_locator.dart';
import 'package:lco_workout/get_it/animation_getit.dart';
import 'package:lco_workout/screen/landing_page.dart';
import 'package:provider/provider.dart';

void main() {
  setup();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(),
    ),
  );
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => locator<AnimationGetIt>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xFFf4f4f4),
          buttonColor: Color(0xFF798ba6),
          primaryTextTheme: TextTheme(
            display1: TextStyle(
              color: Color(0xFF6983aa),
              fontSize: 35,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: LandingPage(),
      ),
    );
  }
}
