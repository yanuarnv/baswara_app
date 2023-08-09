part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AdminInitial extends AdminState {}
class LoadingGetProduct  extends AdminState{

}
class SuccesGetProduct extends AdminState{
  final List<Product> data;

  SuccesGetProduct(this.data);
}

class FailureAdminState extends AdminState{
  final String msg;

  FailureAdminState(this.msg);
}

class NoConnection extends AdminState{

}