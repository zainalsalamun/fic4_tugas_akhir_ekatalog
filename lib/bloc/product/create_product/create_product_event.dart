import '../../../data/models/request/product_model.dart';

abstract class CreateProductEvent {}

class DoCreateProductEvent extends CreateProductEvent {
  final ProductModel productModel;
  DoCreateProductEvent({required this.productModel});
}
