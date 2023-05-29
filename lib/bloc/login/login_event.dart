import 'package:fic4_tugas_akhir_ekatalog/data/models/request/login_model.dart';

abstract class LoginEvent {}

class DoLoginEvent extends LoginEvent {
  final LoginModel loginModel;
  DoLoginEvent({required this.loginModel});
}
