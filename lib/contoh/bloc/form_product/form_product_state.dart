abstract class FormProductState {}

class FormProductInitial extends FormProductState {}

class FormProductSaving extends FormProductState {}

class FormProductError extends FormProductState {
  final String error;

  FormProductError(this.error);
}

class FormProductSuccess extends FormProductState {}
