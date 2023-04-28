import 'package:equatable/equatable.dart';

class UserRepository extends Equatable {
  final String name;

  const UserRepository({
    required this.name,
  });

  @override
  List<Object?> get props => [name];
}
