import 'package:equatable/equatable.dart';
import 'package:testExample1/src/models/BannerQuick.dart';

abstract class BanneState extends Equatable {
  const BanneState();

  @override
  List<Object> get props => [];
}

class BanneInitial extends BanneState {}

class BanneLoading extends BanneState {}

class BanneSuccess extends BanneState {
  final List<BannerQuick> banners;

  BanneSuccess({this.banners});

  @override
  List<Object> get props => [banners];

  @override
  String toString() => ' $banners';
}

class BanneFailure extends BanneState {
  final String error;

  BanneFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => error;
}
