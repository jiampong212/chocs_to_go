import 'package:chocs_to_go/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const ChocsToGo());
}

class ChocsToGo extends StatelessWidget {
  const ChocsToGo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}
