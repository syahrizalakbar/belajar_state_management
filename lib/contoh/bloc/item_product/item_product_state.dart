abstract class ItemProductState {}

class ItemProductInitial extends ItemProductState {}

class ItemProductDeleting extends ItemProductState {}

class ItemProductDeleted extends ItemProductState {}

class ItemProductError extends ItemProductState {
  final String error;

  ItemProductError(this.error);
}

class ItemProductFailed extends ItemProductState {
  final String message;

  ItemProductFailed(this.message);
}
