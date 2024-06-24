import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gnut_identifier/library/screens/ai/AIHomeScreen.dart';
// import 'package:gnut_identifier/library/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AppTheme.init();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: AppTheme.theme,
      onInit: () {},
      builder: EasyLoading.init(),
      home: AIHomeScreen(),
      routes: {
        '/OnBoardingScreen': (context) => AIHomeScreen(),
        // AppConfig.FullApp: (context) => FullApp(),
      },
    );
  }
}

class GlobalMaterialLocalizations {}
