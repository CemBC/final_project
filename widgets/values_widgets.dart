import 'package:final_project/final_project/screens/values_list_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../bloc/values_bloc.dart';
import '../models/user_model.dart';

class ShowValuesWidget extends StatefulWidget {
  User? user;
  ShowValuesWidget({required this.user});

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
            ValuesLoaded() => ValuesListViewer(values: state.values , user: widget.user),
            _ => const Placeholder(),
          };
        });
  }
}
