import 'package:fic4_tugas_akhir_ekatalog/data/models/response/profile_response_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileResponseModel profile;

  ProfileLoaded({required this.profile});
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError({required this.message});
}
