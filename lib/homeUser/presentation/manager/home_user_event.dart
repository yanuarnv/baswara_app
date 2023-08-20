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

  UpdateUserProfile(this.name, this.email, this.noHp, this.image);
}

class GetCatalogUser extends HomeUserEvent{

}
