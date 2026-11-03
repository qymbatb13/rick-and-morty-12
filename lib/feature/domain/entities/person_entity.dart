import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  const PersonEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.origin,
    required this.location,
    required this.episode,
    required this.created,
  });

  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final PersonPlace origin;
  final PersonPlace location;
  final List<String> episode;
  final DateTime created;

  @override
  List<Object?> get props => [
    id,
    name,
    status,
    species,
    type,
    gender,
    image,
    origin,
    location,
    episode,
    created,
  ];
}

class PersonPlace extends Equatable {
  const PersonPlace(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}
