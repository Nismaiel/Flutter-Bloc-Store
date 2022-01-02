import 'package:bruva/data/models/product_model.dart';
import 'package:geolocator/geolocator.dart';

class CheckoutModel{
  final Position location;
  final String lastName;
  final String phoneNumber;
  final String streetName;
  final String building;
  final String floor;
  final String additionalNotes;
  final List<Product> products;
  final double total;
  final int shipping;
  final String timeStamp;

  CheckoutModel({
    required this.location,
    required this.lastName,
    required this.phoneNumber,
    required this.streetName,
    required this.building,
    required this.floor,
    required this.additionalNotes,
    required this.products,
    required this.total,
    required this.shipping,
    required this.timeStamp,
});

}