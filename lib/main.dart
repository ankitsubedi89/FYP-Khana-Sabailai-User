import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_user/controllers/login_controller.dart';
import 'package:khana_sabailai_user/controllers/signup_controller.dart';
import 'package:khana_sabailai_user/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    Get.put(SignupController());
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xffffffff),
              elevation: 0,
              foregroundColor: Colors.black),
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
          backgroundColor: Colors.white),
      initialRoute: GetRoutes.splash,
      getPages: GetRoutes.routes,
    );
  }
}
