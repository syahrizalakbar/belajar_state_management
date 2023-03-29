import 'dart:developer';

import 'package:belajar_state_management/model/produk.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter/material.dart';

class FormProductProvider extends ChangeNotifier {
  bool get isAddProduct => product == null;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  ProductRepository productRepo = ProductRepository();

  bool loading = false;

  Produk? product;

  FormProductProvider(this.product) {
    if (product != null) {
      nameController.text = product?.nama ?? "-";
      priceController.text = product?.harga ?? "-";
    }
  }

  Future<void> addProduct(context) async {
    loading = true;
    notifyListeners();
    Produk? produk =
        await productRepo.addProduk(nameController.text, priceController.text);
    loading = false;
    notifyListeners();
    if (produk != null) {
      Navigator.pop(context, "refresh");
    } else {
      log("Gagal Add");
    }
  }

  Future<void> updateProduct(context) async {
    loading = true;
    notifyListeners();
    Produk? produk = await productRepo.updateProduk(
        product!.id, nameController.text, priceController.text);
    loading = true;
    notifyListeners();
    if (produk != null) {
      Navigator.pop(context, "refresh");
    } else {
      log("Gagal Update");
    }
  }
}
