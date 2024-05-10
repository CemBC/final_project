import 'dart:typed_data';

import 'package:final_project/final_project/screens/values_list_item.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../models/value_model.dart';

class ValuesListViewer extends StatelessWidget{
  List<Value> values;

  User? user;
  ValuesListViewer({required this.values , required this.user});

  Widget build (BuildContext context) {
    return ListView.builder(
      itemCount: values.length,
        itemBuilder: (context , index)  {
          return ValuesListItem(value: values[index], user: user);
        }
    );
  }
}