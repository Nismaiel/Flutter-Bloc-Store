part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

get orders=>null;
}

class OrdersInitial extends OrdersState {
  @override
  List<Object> get props => [];
}
class OrdersLoading extends OrdersInitial{}
class OrdersLoaded extends OrdersInitial{
  @override
  final Orders orders;
   OrdersLoaded({this.orders=const Orders()});

   @override
  List<Object>get props=>[orders];
}
class OrdersError extends OrdersInitial{
  final String message;
   OrdersError({required this.message});
}
