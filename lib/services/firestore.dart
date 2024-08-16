import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreService {
  // get collection of notes
  final CollectionReference notes;
  FirestoreService(this.notes);
  // FirestoreService(this.notes);

  // CREATE: add a new note
  Future<void> addNote(String note) {
    try {
      return notes.add({
        'note': note,
        'timestamp': Timestamp.now(),
      });
    } on FirebaseException catch (e) {
      throw Exception("error adding doc : ${e.message}");
    }
  }

  // READ: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final noteStream = notes.orderBy('timestamp', descending: true).snapshots();
    return noteStream;
  }

  // UPDATE: update notes in database with doc id
  Future<void> updateNote({required String id, required String note}) async {
    try {
      return notes.doc(id).update({
        'note': note,
      });
    } on FirebaseException catch (e) {
      throw Exception("error updating data: ${e.message}");
    }
  }

  // DELETE: delte notes with doc id
  Future<void> deleteNote(String id) {
    return notes.doc(id).delete();
  }
}
