import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_note/services/note_service.dart';

import 'package:flutter_firebase_note/widgets/home_page_widgets/delete_confirmation_dialogue.dart';

class NoteTile extends StatelessWidget {
  final NoteService noteService;
  final DocumentSnapshot document;
  final String docId;
  final Map<String, dynamic> data;
  final Function([String? id, String? note]) openNoteBox;
  late String noteText;
  NoteTile(
      {super.key,
      required this.document,
      required this.openNoteBox,
      required this.noteService})
      : docId = document.id,
        data = document.data() as Map<String, dynamic> {
    noteText = data['note'];
  }
  @override
  Widget build(BuildContext context) {
    void deleteNote() {
      showDialog(
        context: context,
        builder: (context) => DeleteConfirmationDialogue(
          id: docId,
          noteService: noteService,
        ),
      );
    }

    return ListTile(
      title: Text(noteText),
      trailing: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  openNoteBox(docId, noteText);
                },
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: deleteNote,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ],
        ),
      ),
    );
  }
}
