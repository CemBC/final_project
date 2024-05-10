part of 'values_bloc.dart';

@immutable
sealed class ValuesEvent {}

final class RequestToLoadAllValues extends ValuesEvent {}