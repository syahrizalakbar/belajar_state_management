abstract class ItemProductEvent {}

class DeleteProduct extends ItemProductEvent {
  final int id;

  DeleteProduct(this.id);
}
