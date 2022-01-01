import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  final String? name;
  final String? email;
  final String? uid;
  final String? phoneNumber;
  const UserModel({this.name,this.uid,this.email,this.phoneNumber});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}