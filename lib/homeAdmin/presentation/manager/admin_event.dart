part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetProduct extends AdminEvent {}

class GetAllCategory extends AdminEvent {}

class AddProduct extends AdminEvent {
  final String name;
  final int category;

  AddProduct({required this.name, required this.category});
}

class DeleteProduct extends AdminEvent {
  final String idProduct;

  DeleteProduct(this.idProduct);
}

class EditProduct extends AdminEvent {
  final String productId;
  final String name;
  final String categoryId;

  EditProduct(this.productId, this.name, this.categoryId);
}

class GetAlluser extends AdminEvent {}

class PostCheckOut extends AdminEvent {
  final int userId;
  final List<Map<String, dynamic>> items;

  PostCheckOut(this.items, this.userId);
}

class UpdateHargaSampah extends AdminEvent {
  final List<Map<String, dynamic>> items;

  UpdateHargaSampah(this.items);
}

class GetCatalogAdmin extends AdminEvent {}

class EditCatalogAdmin extends AdminEvent {
  final String id;
  final String name;
  final String tautan;
  final File? img;

  EditCatalogAdmin(this.id, this.name, this.tautan, this.img);
}

class AddCatalogAdmin extends AdminEvent {
  final String name;
  final String tautan;
  final File img;

  AddCatalogAdmin(this.name, this.tautan, this.img);
}

class DeleteCatalogAdmin extends AdminEvent {
  final String id;

  DeleteCatalogAdmin(this.id);
}

class TarikSaldoUser extends AdminEvent {
  final int userID;
  final int totalPrice;

  TarikSaldoUser(this.userID, this.totalPrice);
}

class GetReport extends AdminEvent {}
