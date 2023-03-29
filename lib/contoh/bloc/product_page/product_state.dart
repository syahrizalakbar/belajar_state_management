import 'package:belajar_state_management/model/produk.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductEmpty extends ProductState {}

class ProductSuccess extends ProductState {
  final List<Produk> products;

  ProductSuccess(this.products);
}

class ProductError extends ProductState {
  final String error;
  ProductError(this.error);
}
