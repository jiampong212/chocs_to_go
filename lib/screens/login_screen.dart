import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static final TextEditingController _userNamecontroller = TextEditingController();
  static final TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  textStyle: const TextStyle(
                    fontSize: 150,
                    color: Color.fromARGB(255, 219, 192, 172),
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
                      cursorColor: Colors.blue,
                      // autofocus: true,
                      controller: _userNamecontroller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(8.0),
                        isDense: true,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
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
                      cursorColor: Colors.blue,
                      onSubmitted: (value) {
                        enter(context);
                      },
                      obscureText: true,
                      controller: _passwordcontroller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(8.0),
                        isDense: true,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          enter(context);
                        },
                        child: const Text('Log in'),
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

  void enter(BuildContext context) async {
    if (_userNamecontroller.text.isEmpty || _passwordcontroller.text.isEmpty) {
      EasyLoading.showError('Username or password can not be empty');
      return;
    }

    if (_userNamecontroller.text.trim() != 'admin' || _passwordcontroller.text.trim() != 'admin') {
      EasyLoading.showError('Incorrect username or password');
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Container();
        },
      ),
    );
    _userNamecontroller.clear();
    _passwordcontroller.clear();
  }
}
