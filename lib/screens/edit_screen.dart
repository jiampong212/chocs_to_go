import 'package:chocs_to_go/constants.dart';
import 'package:chocs_to_go/database_api.dart';
import 'package:chocs_to_go/screens/login_screen.dart';
import 'package:chocs_to_go/utilites.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditScreen extends ConsumerWidget {
  const EditScreen({Key? key}) : super(key: key);

  static final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _priceController.text = Utils.formatToString(ref.watch(selectedProductProvider).price);

    return Center(
      child: SizedBox(
        width: 400,
        height: 400,
        child: Card(
          color: customBGColor,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Edit Price',
                    style: TextStyle(
                      fontSize: 30,
                      color: customButtonTextColor,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PRICE',
                      style: TextStyle(
                        color: customButtonTextColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: TextField(
                        controller: _priceController,
                        inputFormatters: [FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true)],
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          icon: Text(
                            '₱',
                            style: TextStyle(fontSize: 20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                      ),
                      width: 150,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        _clear();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: customButtonTextColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: customButtonShape,
                        primary: customAccentColor,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_priceController.text.isEmpty) {
                          EasyLoading.showError('Invalid Price');
                          return;
                        }

                        await DatabaseAPI().editPrice(
                          price: double.parse(_priceController.text),
                          productID: ref.read(selectedProductProvider).productID,
                        );

                        ref.read(chocolatesProvider.notifier).reset(ref);
                        _clear();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Edit',
                        style: TextStyle(color: customButtonTextColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: customButtonShape,
                        primary: customAccentColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _clear() {
    _priceController.clear();
  }
}
