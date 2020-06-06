import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final String id;
  final String note;
  final String title;

  const NoteEntity(this.title, this.id, this.note);

  Map<String, Object> toJson() {
    return {
      "title": title,
      "note": note,
      "id": id,
    };
  }

  @override
  List<Object> get props => [id, note, title];

  static NoteEntity fromJson(Map<String, Object> json) {
    return NoteEntity(
      json["title"] as String,
      json["id"] as String,
      json["note"] as String,
    );
  }

  static NoteEntity fromSnapshot(DocumentSnapshot snap) {
    return NoteEntity(
      snap.data['title'],
      snap.documentID,
      snap.data['note'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "title": title,
      "note": note,
    };
  }
}