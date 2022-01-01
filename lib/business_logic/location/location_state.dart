part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {
}
class LocationLoaded extends LocationInitial{
  final Position location;
     LocationLoaded({required this.location});
}
class LocationLoading extends LocationInitial{}
