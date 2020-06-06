import 'package:equatable/equatable.dart';
import 'package:testblocapp/notes/models/Note.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class LoadNotes extends NotesEvent {}

class AddNote extends NotesEvent {
  final Note note;

  const AddNote(this.note);

  @override
  List<Object> get props => [note];
}

class UpdateNote extends NotesEvent {
  final Note updatedNote;

  const UpdateNote(this.updatedNote);

  @override
  List<Object> get props => [updatedNote];
}

class DeleteNote extends NotesEvent {
  final Note note;

  const DeleteNote(this.note);
}

class NotesUpdated extends NotesEvent {
  final List<Note> notes;

  const NotesUpdated(this.notes);

  @override
  List<Object> get props => [notes];
}