import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_note/services/firestore.dart';
import 'package:flutter_firebase_note/widgets/add_edit_form_dialogue.dart';
import 'package:flutter_firebase_note/widgets/add_note_button.dart';

import 'package:flutter_firebase_note/widgets/note_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService firestoreService =
      FirestoreService(FirebaseFirestore.instance.collection("notes"));

  void openNoteBox([String? id, String? note]) {
    final TextEditingController textController =
        TextEditingController(text: note ?? "");
    showDialog(
      context: context,
      builder: (context) => AddEditFormDialogue(
          id: id,
          textController: textController,
          firestoreService: firestoreService),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Notes"),
        ),
        floatingActionButton: AddNoteButton(
          openNoteBox: openNoteBox,
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: StreamBuilder<QuerySnapshot>(
            stream: firestoreService.getNotesStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return const Text("No Notes created");
              }
              List notes = snapshot.data!.docs;
              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = notes[index];

                  return NoteTile(
                    document: document,
                    openNoteBox: openNoteBox,
                    firestoreService: firestoreService,
                  );
                },
              );
            },
          ),
        ));
  }
}
