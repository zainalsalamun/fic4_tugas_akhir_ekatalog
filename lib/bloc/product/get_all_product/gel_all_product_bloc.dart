import 'package:fic4_tugas_akhir_ekatalog/bloc/product/get_all_product/get_all_product_state.dart';
import 'package:fic4_tugas_akhir_ekatalog/data/datasources/product_datasources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'get_all_product_event.dart';

class GetAllProductBloc extends Bloc<GetAllProductEvent, GetAllProductState> {
  final ProductDatasources productDatasources;

  GetAllProductBloc(this.productDatasources) : super(GetAllProductInitial()) {
    on<DoGetAllProductEvent>((event, emit) async {
      emit(GetAllProductLoading());
    });
  }
}
