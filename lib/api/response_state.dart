import 'package:equatable/equatable.dart';

abstract class ResponseState extends Equatable {
  @override
  List<Object> get props => [];
}

class ResponseInitState extends ResponseState {}

class ResponseLoading extends ResponseState {}

class ResponseLoaded<T> extends ResponseState {
  final List<T> items;

  ResponseLoaded({this.items});
}

class ResponseError extends ResponseState {
  final error;
  ResponseError({this.error});
}

