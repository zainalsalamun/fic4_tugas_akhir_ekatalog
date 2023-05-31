import 'package:fic4_tugas_akhir_ekatalog/bloc/profile/profile_event.dart';
import 'package:fic4_tugas_akhir_ekatalog/bloc/profile/profile_state.dart';
import 'package:fic4_tugas_akhir_ekatalog/data/datasources/auth_datasources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(AuthDatasource authDatasource) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
  }
}
