part of 'values_bloc.dart';


@immutable
sealed class ValuesState {}

final class ValuesInitial extends ValuesState {}

final class LoadingValues extends ValuesState {}

final class ValuesLoaded extends ValuesState {
  final List<Value> values;

  ValuesLoaded(this.values);
}