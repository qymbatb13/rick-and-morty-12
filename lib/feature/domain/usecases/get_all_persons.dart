import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/feature/domain/entities/person_entity.dart';
import 'package:flutter_application_1/feature/data/person_repository.dart';
import 'package:dartz/dartz.dart';

class PagePersonParams {
  const PagePersonParams({required this.page});
  final int page;
}

class GetAllPersons {
  GetAllPersons(this.repository);
  final PersonRepository repository;

  Future<Either<Failure, List<PersonEntity>>> call(PagePersonParams params) =>
      repository.getPage(params.page);
}
