import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/feature/data/person_repository.dart';
import 'package:flutter_application_1/feature/domain/usecases/get_all_persons.dart';
import 'package:flutter_application_1/feature/domain/usecases/search_person.dart';
import 'package:flutter_application_1/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:flutter_application_1/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:flutter_application_1/presentation/pages/person_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = PersonRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              PersonListCubit(getAllPersons: GetAllPersons(repository))
                ..loadPerson(),
        ),
        BlocProvider(
          create: (_) =>
              PersonSearchBloc(searchPerson: SearchPerson(repository)),
        ),
      ],
      child: MaterialApp(
        title: 'Rick and Morty',
        theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.dark,
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
