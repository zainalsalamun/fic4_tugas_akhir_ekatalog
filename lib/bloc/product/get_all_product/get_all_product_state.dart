import '../../../data/models/response/product_response_model.dart';

abstract class GetAllProductState {}

class GetAllProductInitial extends GetAllProductState {}

class GetAllProductLoading extends GetAllProductState {}

class GetAllProductLoaded extends GetAllProductState {
  final List<ProductResponseModel> listProducts;
  GetAllProductLoaded({required this.listProducts});
}
