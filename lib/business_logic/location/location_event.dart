part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class GetLocation extends LocationEvent{}