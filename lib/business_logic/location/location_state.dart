part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}
class LocationLoaded extends LocationState{
  Position location;
  LocationLoaded({required this.location});
}
class LocationLoading extends LocationState{}
