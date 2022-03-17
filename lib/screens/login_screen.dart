import 'package:chocs_to_go/chocolates_provider.dart';
import 'package:chocs_to_go/constants.dart';
import 'package:chocs_to_go/data_classes/chocolates_data.dart';
import 'package:chocs_to_go/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final chocolatesProvider = StateNotifierProvider<ChocolatesProvider, List<Chocolates>>((ref) {
  return ChocolatesProvider();
});

final selectedProductProvider = StateProvider<Chocolates>((ref) {
  return Chocolates.empty();
});

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static final TextEditingController _userNamecontroller = TextEditingController();
  static final TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/bg2.jpg'),
          fit: BoxFit.fitWidth,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.90),
            BlendMode.darken,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                'CHOCS TO GO',
                style: GoogleFonts.exo2(
                  textStyle: TextStyle(
                    fontSize: 150,
                    color: customAccentColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Username',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      // autofocus: true,
                      controller: _userNamecontroller,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      onSubmitted: (value) {
                        enter(context, ref);
                      },
                      obscureText: true,
                      controller: _passwordcontroller,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: customButtonShape,
                          primary: customAccentColor,
                        ),
                        onPressed: () {
                          enter(context, ref);
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: customButtonTextColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void enter(BuildContext context, WidgetRef ref) async {
    if (_userNamecontroller.text.isEmpty || _passwordcontroller.text.isEmpty) {
      EasyLoading.showError('Username or password can not be empty');
      return;
    }

    if (_userNamecontroller.text.trim() != 'admin' || _passwordcontroller.text.trim() != 'admin') {
      EasyLoading.showError('Incorrect username or password');
      return;
    }

    ref.read(chocolatesProvider.notifier).init(ref);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      ),
    );
    _userNamecontroller.clear();
    _passwordcontroller.clear();
  }
}
