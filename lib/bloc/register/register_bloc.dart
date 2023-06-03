import 'package:fic4_tugas_akhir_ekatalog/bloc/register/register_event.dart';
import 'package:fic4_tugas_akhir_ekatalog/bloc/register/register_state.dart';
import 'package:fic4_tugas_akhir_ekatalog/data/datasources/auth_datasources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthDatasource datasource;
  RegisterBloc(this.datasource) : super(RegisterInitial()) {
    on<SaveRegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      final result = await datasource.register(event.request);
      emit(RegisterLoaded(model: result));
    });
  }
}
