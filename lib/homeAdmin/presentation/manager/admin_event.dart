part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetProduct extends AdminEvent {}

class AddProduct extends AdminEvent {
  final String name;
  final int category;

  AddProduct({required this.name,required this.category});
}

class DeleteProduct extends AdminEvent {}

class EditProduct extends AdminEvent {}