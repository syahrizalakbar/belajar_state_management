abstract class FormProductState {}

class FormProductInitial extends FormProductState {}

class FormProductUpdating extends FormProductState {}

class FormProductUpdateSuccess extends FormProductState {}

class FormProductUpdateError extends FormProductState {
  final String message;

  FormProductUpdateError(this.message);
}
