import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/feature/data/person_repository.dart';
import 'package:flutter_application_1/feature/domain/entities/person_entity.dart';

class SearchPersonParams {
  const SearchPersonParams({required this.query});
  final String query;
}

class SearchPerson {
  SearchPerson(this.repository);
  final PersonRepository repository;

  Future<Either<Failure, List<PersonEntity>>> call(SearchPersonParams params) =>
      repository.search(params.query);
}
