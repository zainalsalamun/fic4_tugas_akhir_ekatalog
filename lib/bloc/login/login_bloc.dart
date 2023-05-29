import 'package:fic4_tugas_akhir_ekatalog/bloc/login/login_event.dart';
import 'package:fic4_tugas_akhir_ekatalog/bloc/login/login_state.dart';
import 'package:fic4_tugas_akhir_ekatalog/data/datasources/auth_datasources.dart';
import 'package:fic4_tugas_akhir_ekatalog/data/localsources/auth_local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthDatasource authDataSource;

  LoginBloc(this.authDataSource) : super(LoginInitial()) {
    on<DoLoginEvent>((event, emit) async {
      try {
        emit(LoginLoading());
        final result = await authDataSource.login(event.loginModel);
        await AuthLocalStorage().saveToken(result.accessToken);
        emit(LoginLoaded(loginResponseModel: result));
      } catch (e) {
        emit(LoginError(message: e.toString()));
      }
    });
  }
}
