import 'package:chocs_to_go/constants.dart';
import 'package:chocs_to_go/screens/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBGColor,
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
            icon: Icon(
              Icons.logout,
              color: customButtonTextColor,
            ),
            label: Text(
              'Logout',
              style: TextStyle(color: customButtonTextColor),
            ),
          ),
        ],
        backgroundColor: customAccentColor,
        title: Text(
          'Chocs To Go Inventory',
          style: TextStyle(color: customButtonTextColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            _search(),
            Expanded(
              flex: 10,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 15,
                          child: Container(
                            color: Colors.red,
                            child: const Center(
                              child: Text('table'),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: customButtonShape,
                                  primary: customAccentColor,
                                ),
                                onPressed: () {},
                                child: Text(
                                  '+',
                                  style: TextStyle(color: customButtonTextColor),
                                ),
                              ),
                              const SizedBox(
                                width: 32,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: customButtonShape,
                                  primary: customAccentColor,
                                ),
                                onPressed: () {},
                                child: Text(
                                  '-',
                                  style: TextStyle(color: customButtonTextColor),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Container(
                        height: 500,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _search() {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Search:',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        cursorColor: Colors.white,
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
                        onChanged: (String input) {
                          if (input.isEmpty) {}
                        },
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: customButtonShape,
                    primary: customAccentColor,
                  ),
                  onPressed: () {},
                  child: Icon(
                    Icons.more_horiz,
                    color: customButtonTextColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
