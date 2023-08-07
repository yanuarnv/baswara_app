import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final String msg;

  ServerFailure(this.msg);
}
class InternalFailure extends Failure {
}
