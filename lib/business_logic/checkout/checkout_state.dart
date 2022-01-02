part of 'checkout_cubit.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class LocationAdded extends CheckoutState {
  final Position location;
  LocationAdded({required this.location});

}

class AddShippingData extends CheckoutState {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String streetName;
  final String building;
  final String floor;
  final String additionalNotes;

  AddShippingData(
      {required this.phoneNumber,
      required this.lastName,
      required this.firstName,
      required this.additionalNotes,
      required this.building,
      required this.floor,
      required this.streetName});
}
