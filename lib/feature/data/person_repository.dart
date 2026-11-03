import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/feature/domain/entities/person_entity.dart';

class PersonRepository {
  PersonRepository({http.Client? client}) : _client = client ?? http.Client();
  final http.Client _client;
  static const _baseUrl = 'https://rickandmortyapi.com/api/character';

  Future<Either<Failure, List<PersonEntity>>> getPage(int page) =>
      _fetch('$_baseUrl?page=$page');

  Future<Either<Failure, List<PersonEntity>>> search(String query) =>
      _fetch('$_baseUrl?name=${Uri.encodeQueryComponent(query)}');

  Future<Either<Failure, List<PersonEntity>>> _fetch(String url) async {
    try {
      final response = await _client.get(Uri.parse(url));
      if (response.statusCode != 200) return Left(ServerFailure());
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>? ?? const [];
      return Right(
        results.map((item) => _person(item as Map<String, dynamic>)).toList(),
      );
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  PersonEntity _person(Map<String, dynamic> json) => PersonEntity(
    id: json['id'] as int,
    name: json['name'] as String? ?? 'Unknown',
    status: json['status'] as String? ?? 'unknown',
    species: json['species'] as String? ?? 'Unknown',
    type: json['type'] as String? ?? '',
    gender: json['gender'] as String? ?? 'unknown',
    image: json['image'] as String? ?? '',
    origin: PersonPlace(
      (json['origin'] as Map<String, dynamic>?)?['name'] as String? ??
          'Unknown',
    ),
    location: PersonPlace(
      (json['location'] as Map<String, dynamic>?)?['name'] as String? ??
          'Unknown',
    ),
    episode: (json['episode'] as List<dynamic>? ?? const []).cast<String>(),
    created:
        DateTime.tryParse(json['created'] as String? ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0),
  );
}
