part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
  @override
  List<Object>get props=>[];
}
class StartOrders extends OrdersEvent{}

class AddOrder extends OrdersEvent{
  final int orderId;
  final double cartTotal;
  final List<Product> products;
  const AddOrder({required this.products,required this.cartTotal,required this.orderId});
@override
  List<Object>get props=>[products];
}


class RemoveOrder extends OrdersEvent{
  final Orders orders;
  const RemoveOrder({required this.orders});

  @override
  List<Object>get props=>[orders];
}