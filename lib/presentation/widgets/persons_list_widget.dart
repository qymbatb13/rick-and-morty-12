import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/feature/domain/entities/person_entity.dart';
import 'package:flutter_application_1/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:flutter_application_1/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:flutter_application_1/presentation/widgets/person_card_widget.dart';

class PersonsList extends StatefulWidget {
  const PersonsList({super.key});

  @override
  State<PersonsList> createState() => _PersonsListState();
}

class _PersonsListState extends State<PersonsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadNextPage);
  }

  void _loadNextPage() {
    if (_scrollController.position.extentAfter < 300) {
      context.read<PersonListCubit>().loadPerson();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<PersonListCubit, PersonState>(
        builder: (context, state) {
          if (state is PersonLoading && state.isFirstFetch) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PersonError) return Center(child: Text(state.message));

          final List<PersonEntity> persons = switch (state) {
            PersonLoading(:final oldPersonsList) => oldPersonsList,
            PersonLoaded(:final personsList) => personsList,
            _ => const <PersonEntity>[],
          };
          final isLoading = state is PersonLoading;
          return ListView.separated(
            controller: _scrollController,
            itemCount: persons.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) => index < persons.length
                ? PersonCard(person: persons[index])
                : const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
            separatorBuilder: (context, index) => Divider(color: Colors.grey[400]),
          );
        },
      );
}
