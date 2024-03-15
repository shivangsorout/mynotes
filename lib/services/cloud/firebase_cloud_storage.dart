import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynotes/services/cloud/cloud_note.dart';
import 'package:mynotes/services/cloud/cloud_storage_constants.dart';

class FirebaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection('notes');

  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) {
    final allNotes = notes
        .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
        .snapshots()
        .map((event) => event.docs.map((doc) => CloudNote.fromSnapshot(doc)));
    return allNotes;
  }

  Future<void> updateNote({
    required String documentId,
    required String text,
  }) async {
    await notes.doc(documentId).update({
      textFieldName: text,
    });
  }

  Future<void> deleteNote({
    required String documentId,
  }) async {
    await notes.doc(documentId).delete();
  }

  // Singleton
  FirebaseCloudStorage._sharedInstance();
  static final _shared = FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
  ////

  Future<CloudNote> createNewNote({required String ownerUserId}) async {
    final document = await notes.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: '',
    });

    final fetchedData = await document.get();

    return CloudNote(
      documentId: fetchedData.id,
      ownerUserId: ownerUserId,
      text: '',
    );
  }
}
