import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kivusoft_test/navigation.dart';
import 'package:kivusoft_test/pages/login.dart';
import 'package:kivusoft_test/root.dart';
import 'package:lottie/lottie.dart';

void main() async {
  await init().then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KIVUSOFT Techonologies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          textTheme: GoogleFonts.montserratTextTheme()),
      home: const LoginPage(),
      builder: EasyLoading.init(),
    );
  }
}
