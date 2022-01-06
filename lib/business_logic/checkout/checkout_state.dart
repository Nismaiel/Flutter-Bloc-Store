part of 'checkout_cubit.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class LocationAdded extends CheckoutState {
  final Position location;

  LocationAdded({required this.location});
}

class AddedShippingData extends CheckoutState {
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String streetName;
  final String building;
  final String floor;
  final String apartment;
  final String additionalNotes;
  final String lat;
  final String long;

  AddedShippingData(
      {required this.mobileNumber,
      required this.lastName,
      required this.firstName,
      required this.additionalNotes,
      required this.building,
      required this.floor,
      required this.apartment,
      required this.streetName,
      required this.lat,
        required this.long,
      });
}
class OrderPlaced extends CheckoutState{
  final String orderNumber;
  final String userName;
  OrderPlaced({required this.orderNumber,required this.userName});

}
class CheckOutLoading extends CheckoutState{}
