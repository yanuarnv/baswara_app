import 'package:equatable/equatable.dart';

class ProductChartEntity extends Equatable{
  final String date;
  final double weight;


  const ProductChartEntity(this.date, this.weight);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
