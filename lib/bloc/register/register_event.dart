import 'package:fic4_tugas_akhir_ekatalog/data/models/request/register_model.dart';

abstract class RegisterEvent {}

class SaveRegisterEvent extends RegisterEvent {
  final RegisterModel request;

  SaveRegisterEvent({required this.request});
}
