import 'package:chocs_to_go/data_classes/chocolates_data.dart';
import 'package:chocs_to_go/database_api.dart';
import 'package:chocs_to_go/screens/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChocolatesProvider extends StateNotifier<List<Chocolates>> {
  ChocolatesProvider() : super([]);

  List<Chocolates> _fullList = [];

  Future init(WidgetRef ref) async {
    await DatabaseAPI().queryTable().then(
      (value) {
        List<Chocolates> _temp = [];

        for (var row in value) {
          DateTime? _lastDateReleasedUTC = row[6];
          DateTime? _lastDateReceivedUTC = row[7];

          _temp.add(
            Chocolates(
              productID: row[0],
              productName: row[1],
              netWeight: row[2],
              quantity: row[3],
              price: row[4],
              flavor: row[5],
              lastDateRelease: _lastDateReleasedUTC?.toLocal(),
              lastDateReceive: _lastDateReceivedUTC?.toLocal(),
            ),
          );
        }
        state = _temp;
        _resetSelectedRow(ref);
        _fullList = state;
      },
    );
  }

  Future reset(WidgetRef ref) async {
    await init(ref);
    _fullList = [];
  }

  _resetSelectedRow(WidgetRef ref) {
    if (state.isNotEmpty) {
      ref.read(selectedProductProvider.state).state = state.first;
    } else {
      ref.read(selectedProductProvider.state).state = Chocolates.empty();
    }
  }

  searchForProductID(String query) {
    state = _fullList.where((element) {
      return element.productID.toLowerCase().contains(query.trim().toLowerCase());
    }).toList();
  }

  searchForProductName(String query) {
    state = _fullList.where((element) {
      return element.productName.toLowerCase().contains(query.trim().toLowerCase());
    }).toList();
  }

  clearSearch(WidgetRef ref) {
    state = _fullList.toList();
    _resetSelectedRow(ref);
  }
}
