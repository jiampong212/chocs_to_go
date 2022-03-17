import 'package:chocs_to_go/constants.dart';
import 'package:chocs_to_go/custom_numeric_formatter.dart';
import 'package:chocs_to_go/data_classes/chocolates_data.dart';
import 'package:chocs_to_go/database_api.dart';
import 'package:chocs_to_go/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemoveScreen extends ConsumerWidget {
  const RemoveScreen({Key? key, required this.max}) : super(key: key);

  static final TextEditingController _quantityController = TextEditingController();

  final int max;
  final int min = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SizedBox(
        width: 450,
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
                    'REMOVE PRODUCT',
                    style: TextStyle(
                      fontSize: 30,
                      color: customButtonTextColor,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'QUANTITY',
                          style: TextStyle(
                            color: customButtonTextColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: TextField(
                            controller: _quantityController,
                            inputFormatters: [
                              FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                              CustomNumericFormatter(min, max),
                            ],
                            cursorColor: Colors.white,
                            decoration: const InputDecoration(
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
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CURRENT QUANTITY: $max',
                          style: TextStyle(
                            overflow: TextOverflow.clip,
                            color: customButtonTextColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _quantityController.text = max.toString();
                          },
                          child: Text(
                            'MAX',
                            style: TextStyle(color: customButtonTextColor),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: customButtonShape,
                            primary: customAccentColor,
                          ),
                        )
                      ],
                    )
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
                        if (_quantityController.text.isEmpty) {
                          EasyLoading.showError('Invalid quantity');
                          return;
                        }

                        Chocolates _chocolates = ref.read(selectedProductProvider);

                        int _originalQuantity = _chocolates.quantity;
                        int _removeQuantity = int.parse(_quantityController.text);

                        await DatabaseAPI().removeChocolates(
                          quantity: _originalQuantity - _removeQuantity,
                          productID: _chocolates.productID,
                        );

                        ref.read(chocolatesProvider.notifier).reset(ref);

                        _clear();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Remove',
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
    _quantityController.clear();
  }
}
