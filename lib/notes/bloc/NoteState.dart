import 'package:equatable/equatable.dart';
import 'package:testblocapp/notes/models/Note.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Note> note;

  const NotesLoaded([this.note = const []]);

  @override
  List<Object> get props => [note];
}

class NotesNotLoaded extends NotesState {}