import 'package:belajar_state_management/contoh/bloc/form_product/form_product_event.dart';
import 'package:belajar_state_management/contoh/bloc/form_product/form_product_state.dart';
import 'package:belajar_state_management/model/produk.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormProductBloc extends Bloc<FormProductEvent, FormProductState> {
  ProductRepository productRepo = ProductRepository();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  Produk? produk;

  FormProductBloc(this.produk) : super(FormProductInitial()) {
    if (produk != null) {
      nameController.text = produk?.nama ?? "-";
      priceController.text = produk?.harga ?? "-";
    }
    on<FormProductEvent>((event, emit) async {
      if (event is AddProduct) {
        await _addProduct(event, emit);
      }
    });
  }

  Future<void> _addProduct(
      AddProduct event, Emitter<FormProductState> emit) async {
    emit(FormProductUpdating());
    Produk? produk = await productRepo.addProduk(event.nama, event.harga);
    if (produk != null) {
      emit(FormProductUpdateSuccess());
    } else {
      emit(FormProductUpdateError("Gagal Add Product"));
    }
  }

  Future<void> updateProduct(
      AddProduct event, Emitter<FormProductState> emit) async {
    emit(FormProductUpdating());
    Produk? savedProduk = await productRepo.updateProduk(
        produk!.id, nameController.text, priceController.text);

    if (savedProduk != null) {
      emit(FormProductUpdateSuccess());
    } else {
      emit(FormProductUpdateError("Gagal Edit Product"));
    }
  }
}
