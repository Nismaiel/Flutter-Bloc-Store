part of 'checkOut_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

get orders=>null;
}

class CheckOutState extends CheckoutState {
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
