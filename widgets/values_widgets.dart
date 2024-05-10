import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../bloc/values_bloc.dart';

class ShowValuesWidget extends StatefulWidget {
  const ShowValuesWidget({super.key});

  State<ShowValuesWidget> createState() => _ShowValuesWidgetState();
}

class _ShowValuesWidgetState extends State<ShowValuesWidget> {

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocBuilder<ValuesBloc, ValuesState>(
        bloc: BlocProvider.of<ValuesBloc>(context)..add(RequestToLoadAllValues()),
        builder: (context, state) {
          return switch (state) {
            LoadingValues() => const Center(child: CircularProgressIndicator()),
            ValuesLoaded() => ListView.builder(
              itemCount: state.values.length,
              prototypeItem: ListTile(
                title: Text(state.values.first.name),
                subtitle: Text("${state.values.first.value}"),
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.values[index].name),
                  subtitle: Text("${state.values[index].value}"),
                );
              },
            ),
            _ => const Placeholder(),
          };
        });
  }
}