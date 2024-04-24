part of 'sweet_chores_notes_bloc.dart';

sealed class SweetChoresNotesEvent extends Equatable {
  const SweetChoresNotesEvent({this.status = NotesStatus.loading});
  final NotesStatus status;
  @override
  List<Object> get props => [];
}

class StartedChoresEvent extends SweetChoresNotesEvent {}

class RestoreChoresEvent extends SweetChoresNotesEvent {
  final List<Todo> todos;
  final List<Categories> categories;
  const RestoreChoresEvent(this.todos, this.categories);
}

// * ChoresEvents

class AddChoresEvent extends SweetChoresNotesEvent {
  final Todo todo;
  const AddChoresEvent(this.todo);

  @override
  List<Object> get props => [todo];
}

class DateChoresEvent extends SweetChoresNotesEvent {
  final bool hasTime;
  const DateChoresEvent(this.hasTime);

  @override
  List<Object> get props => [hasTime];
}

class RemoveChoresEvent extends SweetChoresNotesEvent {
  final Todo todo;
  const RemoveChoresEvent(this.todo);

  @override
  List<Object> get props => [todo];
}

class AlterChoresEvent extends SweetChoresNotesEvent {
  final Todo index;
  const AlterChoresEvent(this.index);

  @override
  List<Object> get props => [index];
}

class EditChoresEvent extends SweetChoresNotesEvent {
  final Todo todo;
  const EditChoresEvent(this.todo);

  @override
  List<Object> get props => [todo];
}

// * CATEGORIES

class AddCategoryEvent extends SweetChoresNotesEvent {
  final Categories category;
  const AddCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}

class RemoveCategoryEvent extends SweetChoresNotesEvent {
  final Categories category;
  const RemoveCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}

class EditCategoryEvent extends SweetChoresNotesEvent {
  final Categories category;
  const EditCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}

class AlterCategoryEvent extends SweetChoresNotesEvent {
  final Categories category;
  const AlterCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}

// * filter time

class FilterTimeEvent extends SweetChoresNotesEvent {
  final FilterTime time;
  const FilterTimeEvent([this.time = FilterTime.all]);

  @override
  List<Object> get props => [time];
}
