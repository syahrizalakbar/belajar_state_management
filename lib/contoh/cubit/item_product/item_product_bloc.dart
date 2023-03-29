import 'package:belajar_state_management/contoh/cubit/item_product/item_product_state.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemProductBloc extends Cubit<ItemProductState> {
  ItemProductBloc() : super(ItemProductInitial());

  Future<void> deleteProduct(id) async {
    emit(ItemProductDeleting());
    try {
      bool deleted = await ProductRepository().deleteProduk(id);
      if (deleted) {
        emit(ItemProductDeleted());
      } else {
        emit(ItemProductFailed("Gagal Hapus Product"));
      }
    } catch (e) {
      emit(ItemProductError(e.toString()));
    }
  }
}
