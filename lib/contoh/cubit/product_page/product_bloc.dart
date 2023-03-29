import 'package:belajar_state_management/contoh/cubit/product_page/product_state.dart';
import 'package:belajar_state_management/model/produk.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Cubit<ProductState> {
  ProductRepository productRepo = ProductRepository();

  ProductBloc() : super(ProductInitial());

  Future<void> getProduct() async {
    await Future.delayed(const Duration(milliseconds: 100));
    emit(ProductLoading());
    try {
      List<Produk>? products = await productRepo.getProduk();
      if (products?.isNotEmpty == true) {
        emit(ProductSuccess(products!));
      } else {
        emit(ProductEmpty());
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
