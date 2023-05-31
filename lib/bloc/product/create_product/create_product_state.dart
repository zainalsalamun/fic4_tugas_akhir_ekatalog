import '../../../data/models/response/product_response_model.dart';

abstract class CreateProductState {}

class CreateProductInitial extends CreateProductState {}

class CreateProductLoading extends CreateProductState {}

class CreateProductLoaded extends CreateProductState {
  final ProductResponseModel productResponseModel;

  CreateProductLoaded({required this.productResponseModel});
}
