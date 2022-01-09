part of 'checkOut_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

get orders=>null;
}

class CheckOutState extends OrdersState {
  @override
  List<Object> get props => [];
}
class CheckOutLoading extends CheckOutState{}
class CheckOutLoaded extends CheckOutState{
  @override
  final Orders orders;
   CheckOutLoaded({this.orders=const Orders()});

   @override
  List<Object>get props=>[orders];
}
class CheckoutError extends CheckOutState{
  final String message;
   CheckoutError({required this.message});
}
