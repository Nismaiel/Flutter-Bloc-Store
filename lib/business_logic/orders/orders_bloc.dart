import 'package:bloc/bloc.dart';
import 'package:bruva/data/models/orders_model.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orders_event.dart';

part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitial()) {
    on<OrdersEvent>((event, emit) async {
      if(event is StartOrders){
        _mapStartOrders();
      }else if (event is AddOrder){
        _mapAddOrder(event, state);
      }
      if(event is RemoveOrder){
        _mapRemoveOrder(event, state);
      }
    });
  }

  _mapStartOrders() async {
    emit(OrdersLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(OrdersLoaded());
    } catch (e) {
      emit(OrdersError(message: e.toString()));
    }
  }

  _mapAddOrder(AddOrder event,OrdersState state)async{
    try{
      emit(OrdersLoaded(orders: Orders(products: event.products,total:event.cartTotal,orderId: event.orderId )));
    }catch(e){
      emit(OrdersError(message: e.toString()));
    }
  }

  _mapRemoveOrder(RemoveOrder event,OrdersState state)async{
    try{
      emit(OrdersLoaded(orders: Orders(total: state.orders.total,orderId: state.orders.orderId,products: state.orders.products)));

    }catch(e){
      emit(OrdersError(message: e.toString()));
    }
  }

}
