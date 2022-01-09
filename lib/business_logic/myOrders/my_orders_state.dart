part of 'my_orders_cubit.dart';

@immutable
abstract class MyOrdersState {}

class MyOrdersInitial extends MyOrdersState {}
class MyOrdersLoading extends MyOrdersState{}
class MyOrdersLoaded extends MyOrdersState{
 final List<MyOrdersModel>myOrders;
 MyOrdersLoaded({required this.myOrders});
}
