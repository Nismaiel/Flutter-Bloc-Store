import 'package:bloc/bloc.dart';
import 'package:bruva/business_logic/Order/checkout_cubit.dart';
import 'package:bruva/data/models/orders_model.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_event.dart';

part 'check_outState.dart';

class CheckOutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckOutBloc() : super(CheckOutState()) {
    on<CheckoutEvent>((event, emit) async {
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
    emit(CheckOutLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(CheckOutLoaded());
    } catch (e) {
      emit(CheckoutError(message: e.toString()));
    }
  }

  _mapAddOrder(AddOrder event,CheckoutState state)async{
    try{
      emit(CheckOutLoaded(orders: Orders(products: event.products,total:event.cartTotal,orderId: event.orderId )));
    }catch(e){
      emit(CheckoutError(message: e.toString()));
    }
  }

  _mapRemoveOrder(RemoveOrder event,CheckoutState state)async{
    try{
      emit(CheckOutLoaded(orders: Orders(total: state.orders.total,orderId: state.orders.orderId,products: state.orders.products)));

    }catch(e){
      emit(CheckoutError(message: e.toString()));
    }
  }

}
