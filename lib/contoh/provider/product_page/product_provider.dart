import 'package:belajar_state_management/model/produk.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  ProductRepository productRepo = ProductRepository();
  bool loading = true;
  List<Produk> listProduct = [];

  ProductProvider() {
    getProduct();
  }

  Future<void> getProduct() async {
    loading = true;
    notifyListeners();
    List<Produk>? products = await productRepo.getProduk();
    loading = false;
    listProduct = products ?? [];
    notifyListeners();
  }
}
