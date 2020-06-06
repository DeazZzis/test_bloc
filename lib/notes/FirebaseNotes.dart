import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'models/Note.dart';
import 'models/NoteEntity.dart';

class FirebaseNote {
  static FirebaseAuth auth = FirebaseAuth.instance;
  final noteCollection = Firestore.instance.collection('notes');

  Future<void> addNewNote(Note note) {
    return noteCollection.add(note.toEntity().toDocument());
  }

  Future<void> deleteNote(Note note) async {
    return noteCollection.document(note.id).delete();
  }

  Stream<List<Note>> notes() {
    return noteCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Note.fromEntity(NoteEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  Future<void> updateNote(Note update) {
    return noteCollection
        .document(update.id)
        .updateData(update.toEntity().toDocument());
  }
}