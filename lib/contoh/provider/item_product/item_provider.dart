import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter/material.dart';

class ItemProvider extends ChangeNotifier {
  bool loadingDelete = false;

  Future<void> deleteProduct(id, void Function() onRefresh) async {
    loadingDelete = true;
    notifyListeners();
    bool deleted = await ProductRepository().deleteProduk(id);
    loadingDelete = false;
    notifyListeners();
    if (deleted) {
      onRefresh();
    }
  }
}
