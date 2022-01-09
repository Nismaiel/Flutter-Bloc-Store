import 'package:bloc/bloc.dart';
import 'package:bruva/data/models/myOrdersModel.dart';
import 'package:bruva/data/web_services/orders_service.dart';
import 'package:flutter/material.dart';
part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit() : super(MyOrdersInitial());

  getAllOrders()async{
    try{
      emit(MyOrdersLoading());
      List<MyOrdersModel>myOrders=await OrdersService().getMyOrders();

      emit(MyOrdersLoaded(myOrders: myOrders));
    }catch(e){
      debugPrint(e.toString());
    }
  }

}
