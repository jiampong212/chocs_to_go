import 'package:chocs_to_go/constants.dart';
import 'package:chocs_to_go/screens/enter_mysql_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: ChocsToGo()));
}

class ChocsToGo extends StatelessWidget {
  const ChocsToGo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(dividerColor: customButtonTextColor),
      debugShowCheckedModeBanner: false,
      home: const EnterMysqlSettingsPage(),
      builder: EasyLoading.init(),
    );
  }
}
