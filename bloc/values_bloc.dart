import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../models/value_model.dart';
part 'values_event.dart';
part 'values_state.dart';

class ValuesBloc extends Bloc<ValuesEvent , ValuesState> {

  final String valueAssetPath = "assets/data/exchange_rates.json";



  ValuesBloc() : super(ValuesInitial()) {
    on<ValuesEvent>((event, emit) async {
      emit(LoadingValues());
      await _loadValues().then((values) => emit(ValuesLoaded(values)));
    });
  }

  Future<List<Value>> _loadValues() async {
    await Future.delayed(const Duration(seconds: 3));
    final jsonString = await rootBundle.loadString(valueAssetPath);
    final List<dynamic> jsonList = jsonDecode(jsonString);

    final List<Value> values = jsonList
        .map((dynamic json) => Value.fromJson(json as Map<String, dynamic>))
        .toList();

    return values;
  }
}

