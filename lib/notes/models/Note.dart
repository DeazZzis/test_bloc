import 'NoteEntity.dart';

class Note {
  final String id;
  final String note;
  final String title;

  Note(this.title, {String note = '', String id})
      : this.note = note ?? '',
        this.id = id;

  Note copyWith({String note, String title}) {
    return Note(
      title ?? this.title,
      id: id ?? this.id,
      note: note ?? this.note,
    );
  }

  NoteEntity toEntity() {
    return NoteEntity(title, id, note);
  }

  static Note fromEntity(NoteEntity entity) {
    return Note(
      entity.title,
      note: entity.note,
      id: entity.id,
    );
  }
}


