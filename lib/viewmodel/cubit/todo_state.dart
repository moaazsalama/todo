part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}
class TodoLoading extends TodoState {}
class TodoLoaded extends TodoState{}
class TodoAdded extends TodoLoaded{}
class TodoUpdated extends TodoLoaded{}
class TodoDelete extends TodoLoaded{}
class TodoCompleted extends TodoLoaded{}
class TodoUnCompleted extends TodoLoaded{}
