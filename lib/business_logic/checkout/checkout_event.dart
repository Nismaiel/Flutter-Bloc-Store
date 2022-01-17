part of 'checkOut_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();
  @override
  List<Object>get props=>[];
}
class StartOrders extends CheckoutEvent{}

class AddOrder extends CheckoutEvent{
  final int orderId;
  final String cartTotal;
  final List<CartItems> products;
  const AddOrder({required this.products,required this.cartTotal,required this.orderId});
@override
  List<Object>get props=>[products];
}


class RemoveOrder extends CheckoutEvent{
  final Orders orders;
  const RemoveOrder({required this.orders});

  @override
  List<Object>get props=>[orders];
}