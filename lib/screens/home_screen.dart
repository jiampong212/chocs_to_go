import 'package:chocs_to_go/constants.dart';
import 'package:chocs_to_go/custom_route.dart';
import 'package:chocs_to_go/data_classes/chocolates_data.dart';
import 'package:chocs_to_go/database_api.dart';
import 'package:chocs_to_go/screens/add_screen.dart';
import 'package:chocs_to_go/screens/edit_screen.dart';
import 'package:chocs_to_go/screens/new_product_screen.dart';
import 'package:chocs_to_go/screens/login_screen.dart';
import 'package:chocs_to_go/screens/remove_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final double _tableHeaderFontSize = 14;
  static final TextEditingController _searchController = TextEditingController();
  static final ScrollController _tableController = ScrollController();
  static final ScrollController _listController = ScrollController();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            _search(context, ref),
            Expanded(
              flex: 10,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 15,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: customButtonTextColor,
                              ),
                            ),
                            child: SingleChildScrollView(
                              controller: _tableController,
                              child: DataTable(
                                showCheckboxColumn: false,
                                showBottomBorder: true,
                                columns: _columns(),
                                rows: _rows(ref),
                              ),
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
                                onPressed: ref.watch(selectedProductProvider) == Chocolates.empty()
                                    ? null
                                    : () {
                                        Navigator.push(
                                          context,
                                          CustomRoute(
                                            builder: (context) {
                                              return const AddScreen();
                                            },
                                          ),
                                        );
                                      },
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
                                onPressed: ref.watch(selectedProductProvider) == Chocolates.empty()
                                    ? null
                                    : () {
                                        Navigator.push(
                                          context,
                                          CustomRoute(
                                            builder: (context) {
                                              return RemoveScreen(
                                                max: ref.read(selectedProductProvider).quantity,
                                              );
                                            },
                                          ),
                                        );
                                      },
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
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: customButtonTextColor,
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'PRODUCTS WITH LOW QUANTITY',
                              style: TextStyle(fontSize: 21),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Divider(
                              color: customButtonTextColor,
                              thickness: 1,
                            ),
                            Builder(
                              builder: (context) {
                                List<Chocolates> _lowQuantity = ref.watch(chocolatesProvider).where((element) {
                                  return element.quantity <= 5;
                                }).toList();

                                _lowQuantity.sort((a, b) {
                                  return a.quantity.compareTo(b.quantity);
                                });

                                return SizedBox(
                                  height: 500,
                                  child: ListView.builder(
                                    controller: _listController,
                                    itemCount: _lowQuantity.length,
                                    itemBuilder: (context, index) {
                                      int _quantityLeft = _lowQuantity[index].quantity;
                                      String _quantityLeftString = '';
                                      String _productID = _lowQuantity[index].productID;

                                      if (_quantityLeft == 1) {
                                        _quantityLeftString = '1 pc';
                                      } else if (_quantityLeft == 0) {
                                        _quantityLeftString = 'None';
                                      } else {
                                        _quantityLeftString = '$_quantityLeft pcs';
                                      }

                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: customButtonTextColor,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            _searchController.text = _productID;
                                            ref.read(chocolatesProvider.notifier).searchForProductID(_productID);
                                          },
                                          leading: SizedBox(
                                            width: 60,
                                            child: Text(
                                              _quantityLeftString,
                                              style: const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          title: Text(_lowQuantity[index].productName),
                                          subtitle: Text(_productID),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
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
    );
  }

  Expanded _search(BuildContext context, WidgetRef ref) {
    Chocolates _selected = ref.watch(selectedProductProvider);

    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
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
                        onChanged: (String input) {
                          if (input.isEmpty) {
                            ref.read(chocolatesProvider.notifier).clearSearch(ref);
                          }
                        },
                        controller: _searchController,
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
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: customButtonShape,
                        primary: customAccentColor,
                      ),
                      onPressed: () {
                        ref.read(chocolatesProvider.notifier).searchForProductName(_searchController.text);
                      },
                      child: Text(
                        'Search using product name',
                        style: TextStyle(color: customButtonTextColor),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: customButtonShape,
                        primary: customAccentColor,
                      ),
                      onPressed: () {
                        ref.read(chocolatesProvider.notifier).searchForProductID(_searchController.text);
                      },
                      child: Text(
                        'Search using product ID',
                        style: TextStyle(color: customButtonTextColor),
                      ),
                    ),
                  ],
                ),
                PopupMenuButton<int>(
                  icon: const Icon(Icons.more_horiz),
                  color: customAccentColor,
                  onSelected: (value) {
                    switch (value) {
                      case 0:
                        Navigator.push(
                          context,
                          CustomRoute(
                            builder: (context) {
                              return const NewProductScreen();
                            },
                          ),
                        );
                        break;
                      case 1:
                        Navigator.push(
                          context,
                          CustomRoute(
                            builder: (context) {
                              return const EditScreen();
                            },
                          ),
                        );
                        break;
                      case 2:
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: customAccentColor,
                              title: Text(
                                'Confirm Delete?',
                                style: TextStyle(color: customButtonTextColor),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'No',
                                    style: TextStyle(color: customButtonTextColor),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    String productID = ref.read(selectedProductProvider).productID;

                                    await DatabaseAPI().deleteProduct(productID);
                                    await ref.read(chocolatesProvider.notifier).reset(ref);

                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: customButtonTextColor),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                        break;
                      case 3:
                        ref.watch(chocolatesProvider.notifier).reset(ref);
                        break;
                      default:
                        break;
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 0,
                        child: Text(
                          'New Product',
                          style: TextStyle(color: customButtonTextColor),
                        ),
                      ),
                      if (_selected != Chocolates.empty())
                        PopupMenuItem(
                          value: 1,
                          child: Text(
                            'Edit Price',
                            style: TextStyle(color: customButtonTextColor),
                          ),
                        ),
                      if (_selected != Chocolates.empty())
                        PopupMenuItem(
                          value: 2,
                          child: Text(
                            'Delete Product',
                            style: TextStyle(color: customButtonTextColor),
                          ),
                        ),
                      PopupMenuItem(
                        value: 3,
                        child: Text(
                          'Refresh',
                          style: TextStyle(color: customButtonTextColor),
                        ),
                      ),
                    ];
                  },
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

  List<DataRow> _rows(WidgetRef ref) {
    List<DataRow> _temp = [];

    String selectedID = ref.watch(selectedProductProvider).productID;

    ref.watch(chocolatesProvider).forEach(
      (element) {
        _temp.add(
          DataRow(
            selected: element.productID == selectedID,
            onSelectChanged: (selected) {
              ref.watch(selectedProductProvider.state).state = element;
            },
            cells: [
              DataCell(SelectableText(element.productID)),
              DataCell(Text(element.productName)),
              DataCell(Text(element.netWeightString)),
              DataCell(Text(element.quantity.toString())),
              DataCell(Text(element.priceStringPHP)),
              DataCell(Text(element.flavor)),
              DataCell(Text(element.lastDateReleasedString)),
              DataCell(Text(element.lastDateReceivedString)),
            ],
          ),
        );
      },
    );

    return _temp;
  }

  List<DataColumn> _columns() {
    return <DataColumn>[
      DataColumn(
        label: Text(
          'PRODUCT ID',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: _tableHeaderFontSize),
        ),
      ),
      DataColumn(
        label: Text(
          'PRODUCT NAME',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: _tableHeaderFontSize),
        ),
      ),
      DataColumn(
        label: Text(
          'NET WEIGHT',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: _tableHeaderFontSize),
        ),
      ),
      DataColumn(
        label: Text(
          'QUANTITY',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: _tableHeaderFontSize),
        ),
      ),
      DataColumn(
        label: Text(
          'PRICE',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: _tableHeaderFontSize),
        ),
      ),
      DataColumn(
        label: Text(
          'FLAVOR',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: _tableHeaderFontSize),
        ),
      ),
      DataColumn(
        label: Text(
          'LAST RELEASE DATE',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: _tableHeaderFontSize),
        ),
      ),
      DataColumn(
        label: Text(
          'LAST RECEIVE DATE',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: _tableHeaderFontSize),
        ),
      ),
    ];
  }
}
