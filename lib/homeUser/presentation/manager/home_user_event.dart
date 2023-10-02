part of 'home_user_bloc.dart';

abstract class HomeUserEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetUserProfile extends HomeUserEvent {}

class UpdateUserProfile extends HomeUserEvent {
  final String name;
  final String email;
  final String noHp;
  final File? image;
  final String rt;
  final String rw;

  UpdateUserProfile(
      this.name, this.email, this.noHp, this.image, this.rt, this.rw);
}

class GetCatalogUser extends HomeUserEvent {}

class GetRiwayatUser extends HomeUserEvent {
  final String status;

  GetRiwayatUser(this.status);
}
