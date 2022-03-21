import 'package:chocs_to_go/constants.dart';
import 'package:chocs_to_go/database_api.dart';
import 'package:chocs_to_go/screens/login_screen.dart';
import 'package:chocs_to_go/utilites.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewProductScreen extends ConsumerWidget {
  const NewProductScreen({Key? key}) : super(key: key);

  static String _flavor = ChocolateFlavorsEnum.Dark.name;

  static final TextEditingController _nameController = TextEditingController();
  static final TextEditingController _quantityController = TextEditingController();
  static final TextEditingController _priceController = TextEditingController();
  static final TextEditingController _netWeightController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SizedBox(
        height: 400,
        width: 1000,
        child: Card(
          color: customBGColor,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'NEW PRODUCT',
                  style: TextStyle(
                    fontSize: 40,
                    color: customButtonTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PRODUCT NAME',
                          style: TextStyle(
                            color: customButtonTextColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: TextField(
                            controller: _nameController,
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
                          width: 250,
                        ),
                      ],
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
                            inputFormatters: [FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true)],
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
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NET WEIGHT',
                          style: TextStyle(
                            color: customButtonTextColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: TextField(
                            controller: _netWeightController,
                            inputFormatters: [FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true)],
                            cursorColor: Colors.white,
                            decoration: const InputDecoration(
                              suffixIcon: Text('grams'),
                              suffixIconConstraints: BoxConstraints(minWidth: 50, minHeight: 15),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FLAVOR',
                          style: TextStyle(
                            color: customButtonTextColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonFormField<ChocolateFlavorsEnum>(
                              dropdownColor: customBGColor,
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
                                contentPadding: EdgeInsets.all(4),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                ),
                              ),
                              isDense: true,
                              value: ChocolateFlavorsEnum.Dark,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: ChocolateFlavorsEnum.values.map<DropdownMenuItem<ChocolateFlavorsEnum>>(
                                (ChocolateFlavorsEnum value) {
                                  return DropdownMenuItem<ChocolateFlavorsEnum>(
                                    value: value,
                                    child: Text(
                                      value.name,
                                    ),
                                  );
                                },
                              ).toList(),
                              onChanged: (ChocolateFlavorsEnum? newValue) {
                                _flavor = newValue?.name ?? _flavor;
                              },
                            ),
                          ),
                          width: 150,
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _clear();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'EXIT',
                        style: TextStyle(
                          color: customButtonTextColor,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: customButtonShape,
                        primary: customAccentColor,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        double? _price = double.tryParse(_priceController.text.trim());
                        int? _quantity = int.tryParse(_quantityController.text.trim());
                        double? _netWeight = double.tryParse(_netWeightController.text.trim());

                        if (_quantity == null || _price == null) {
                          EasyLoading.showError('Invalid price, quantity, or net weight');
                          return;
                        }

                        String _productName = _nameController.text.trim();
                        String _productID = Utils.generateProductID(_productName + _netWeight.toString() + _flavor);
                        bool? _duplicatesCheck = await DatabaseAPI(settings: ref.read(mysqlConnectionProvider)).checkForDuplicates(_productID);

                        if (_duplicatesCheck == null) {
                          return;
                        }

                        if (_duplicatesCheck == true) {
                          EasyLoading.showError('Product with ID of $_productID already exists');
                          return;
                        }

                        await DatabaseAPI(settings: ref.read(mysqlConnectionProvider)).newProduct(
                          productID: _productID,
                          productName: _productName,
                          netWeight: _netWeight!,
                          quantity: _quantity,
                          price: _price,
                          flavor: _flavor,
                        );

                        ref.read(chocolatesProvider.notifier).reset(ref);

                        _clear();

                        Navigator.pop(context);
                      },
                      child: Text(
                        'ENTER',
                        style: TextStyle(
                          color: customButtonTextColor,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: customButtonShape,
                        primary: customAccentColor,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
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
    _nameController.clear();
    _priceController.clear();
    _quantityController.clear();
    _flavor = ChocolateFlavorsEnum.Dark.name;
    _netWeightController.clear();
  }
}
