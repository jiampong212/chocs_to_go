import 'package:chocs_to_go/utilites.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mysql1/mysql1.dart';

class DatabaseAPI {
  final String dbName = 'cpe_211';
  final String tableName = 'chocs_to_go_inventory';

  late final ConnectionSettings settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'angelo',
    password: 'krystelle12',
    db: dbName,
  );

  Future<Iterable> queryTable() async {
    EasyLoading.show();
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      Iterable results = await conn.query(
        '''SELECT 
        `${TableFieldsEnum.product_id.name}`,
        `${TableFieldsEnum.product_name.name}`.
        `${TableFieldsEnum.net_weight.name}`, 
        `${TableFieldsEnum.quantity.name}`,
        `${TableFieldsEnum.price.name}`, 
        `${TableFieldsEnum.flavor.name}`, 
        `${TableFieldsEnum.quantity.name}`,
        `${TableFieldsEnum.last_date_release.name}`,
        `${TableFieldsEnum.last_date_receive.name}`
        FROM `$tableName` WHERE 1''',
        [],
      );
      await conn.close();

      EasyLoading.dismiss();

      return results;
    } catch (e) {
      EasyLoading.showError(e.toString());

      return const Iterable.empty();
    }
  }

  Future newProduct({
    required String productID,
    required String productName,
    required double netWeight,
    required int quantity,
    required double price,
    required String flavor,
    required DateTime expiryDate,
  }) async {
    EasyLoading.show();

    DateTime? _lastDateRelease;
    DateTime? _lastDateReceive = DateTime.now().toUtc();

    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);

      await conn.query(
        '''INSERT INTO `$tableName` (
        `${TableFieldsEnum.product_id.name}`,
        `${TableFieldsEnum.product_name.name}`.
        `${TableFieldsEnum.net_weight.name}`, 
        `${TableFieldsEnum.quantity.name}`,
        `${TableFieldsEnum.price.name}`, 
        `${TableFieldsEnum.flavor.name}`, 
        `${TableFieldsEnum.quantity.name}`,
        `${TableFieldsEnum.last_date_release.name}`,
        `${TableFieldsEnum.last_date_receive.name}`
          ) 
          VALUES (?,?,?,?,?,?,?,?,?)''',
        [
          productID,
          productName,
          netWeight,
          quantity,
          price,
          flavor,
          expiryDate,
          _lastDateRelease,
          _lastDateReceive,
        ],
      );

      conn.close();
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  Future addChocolates({
    required int quantity,
    required String productID,
    required DateTime expiryDate,
  }) async {
    EasyLoading.show();

    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);

      await conn.query(
          'UPDATE `$tableName` SET `quantity`=?, `${TableFieldsEnum.last_date_receive.name}`=?, `${TableFieldsEnum.expiry_date.name}`=? WHERE `product_id`=?', [
        quantity,
        DateTime.now().toUtc(),
        expiryDate,
        productID,
      ]);

      conn.close();
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  Future removeChocolates({
    required int quantity,
    required String productID,
  }) async {
    EasyLoading.show();

    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);


      await conn.query('UPDATE `$tableName` SET `${TableFieldsEnum.last_date_release.name}`=? , `quantity`=? WHERE `product_id` = ?', [
        DateTime.now().toUtc(),
        quantity,
        productID,
      ]);

      conn.close();
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  Future deleteProduct(String productID) async {
    EasyLoading.show();

    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);

      await conn.query('DELETE FROM `$tableName` WHERE `product_id` = ?', [productID]);
      await conn.close();
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  Future editPrice({
    required double price,
    required String productID,
  }) async {
    EasyLoading.show();

    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);

      await conn.query('UPDATE `$tableName` SET `price`=? WHERE `product_id`=?', [
        price,
        productID,
      ]);

      conn.close();
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  Future<bool?> checkForDuplicates(String productID) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);

      Iterable results = await conn.query('SELECT * FROM `tshirt_inventory` WHERE `product_id`=?', [productID]);

      conn.close();

      if (results.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return null;
    }
  }
}
