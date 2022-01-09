
class MyOrdersModel{
    late String orderId;
    late String dateTime;
    late bool onlinePayment;
    late List products;
    late String retailPrice;
    late String shippingFee;
    late Map shippingInfo;
    late String subtotal;
    late String total;
    late String userId;

    MyOrdersModel.fromJson(Map<String,dynamic>json){
       orderId=json['orderId'];
       dateTime=json['dateTime'];
       onlinePayment=json['onlinePayment'];
       products=json['products'];
       retailPrice=json['retailPrice'];
       shippingFee=json['shippingFee'];
       shippingInfo=json['shippingInfo'];
       subtotal=json['subtotal'];
       total=json['total'];
       userId=json['userId'];
    }



}