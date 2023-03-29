abstract class FormProductEvent {}

class AddProduct extends FormProductEvent {
  final String nama;
  final String harga;

  AddProduct(this.nama, this.harga);
}

class EditProduct extends FormProductEvent {
  final dynamic id;
  final String nama;
  final String harga;

  EditProduct(this.id, this.nama, this.harga);
}
