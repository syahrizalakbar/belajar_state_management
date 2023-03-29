import 'package:belajar_state_management/contoh/cubit/form_product/form_product_state.dart';
import 'package:belajar_state_management/model/produk.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormProductBloc extends Cubit<FormProductState> {
  Produk? product;
  bool get isAddProduct => product == null;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  ProductRepository productRepo = ProductRepository();

  FormProductBloc(this.product) : super(FormProductInitial()) {
    if (product != null) {
      nameController.text = product?.nama ?? "-";
      priceController.text = product?.harga ?? "-";
    }
  }

  Future<void> addProduct() async {
    emit(FormProductSaving());
    Produk? produk =
        await productRepo.addProduk(nameController.text, priceController.text);
    if (produk != null) {
      emit(FormProductSuccess());
      // Navigator.pop(context, "refresh");
    } else {
      emit(FormProductError("Gagal Add"));
      // log("Gagal Add");
    }
  }

  Future<void> updateProduct() async {
    emit(FormProductSaving());
    Produk? produk = await productRepo.updateProduk(
        product!.id, nameController.text, priceController.text);
    if (produk != null) {
      emit(FormProductSuccess());
      // Navigator.pop(context, "refresh");
    } else {
      emit(FormProductError("Gagal Edit"));
      // log("Gagal Update");
    }
  }
}
