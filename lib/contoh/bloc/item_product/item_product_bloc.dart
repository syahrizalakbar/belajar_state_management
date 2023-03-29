import 'package:belajar_state_management/contoh/bloc/item_product/item_product_event.dart';
import 'package:belajar_state_management/contoh/bloc/item_product/item_product_state.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemProductBloc extends Bloc<ItemProductEvent, ItemProductState> {
  ItemProductBloc() : super(ItemProductInitial()) {
    on<ItemProductEvent>((event, emit) async {
      if (event is DeleteProduct) {
        await deleteProduct(event.id, emit);
      }
    });
  }

  Future<void> deleteProduct(id, Emitter<ItemProductState> emit) async {
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
