import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/feature/domain/entities/person_entity.dart';
import 'package:flutter_application_1/feature/domain/usecases/get_all_persons.dart';
import 'package:flutter_application_1/presentation/bloc/person_list_cubit/person_list_state.dart';

const serverFailureMessage = 'Server Failure';
const cachedFailureMessage = 'Cache Failure';

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;

  PersonListCubit({required this.getAllPersons}) : super(const PersonEmpty());

  int page = 1;

  Future<void> loadPerson() async {
    if (state is PersonLoading) return;

    final currentState = state;

    var oldPerson = <PersonEntity>[];
    if (currentState is PersonLoaded) {
      oldPerson = currentState.personsList;
    }

    emit(PersonLoading(oldPerson, isFirstFetch: page == 1));

    final failureOrPerson = await getAllPersons(PagePersonParams(page: page));

    failureOrPerson.fold(
      (error) => emit(PersonError(message: _mapFailureToMessage(error))),
      (character) {
        page++;
        var persons = (state as PersonLoading).oldPersonsList;
        persons = [...persons, ...character];
        emit(PersonLoaded(persons));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return serverFailureMessage;
    if (failure is CacheFailure) return cachedFailureMessage;
    return 'Unexpected Error';
  }
}
