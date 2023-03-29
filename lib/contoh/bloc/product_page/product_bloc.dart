import 'package:belajar_state_management/contoh/bloc/product_page/product_event.dart';
import 'package:belajar_state_management/contoh/bloc/product_page/product_state.dart';
import 'package:belajar_state_management/model/produk.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository productRepo = ProductRepository();

  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is GetProduct) {
        await getProduct(emit);
      }
    });
  }

  Future<void> getProduct(Emitter<ProductState> emit) async {
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
