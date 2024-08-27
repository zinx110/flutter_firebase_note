import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_note/bloc/auth_bloc.dart';
import 'package:flutter_firebase_note/services/note_service.dart';

import 'package:flutter_firebase_note/widgets/home_page_widgets/add_edit_form_dialogue.dart';
import 'package:flutter_firebase_note/widgets/home_page_widgets/add_note_button.dart';

import 'package:flutter_firebase_note/widgets/home_page_widgets/note_tile.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    final NoteService noteService = NoteService(
        notes: FirebaseFirestore.instance.collection("notes"),
        userId: (context.read<AuthBloc>().state as AuthSuccess).uid);
    void openNoteBox([String? id, String? note]) {
      final TextEditingController textController =
          TextEditingController(text: note ?? "");
      showDialog(
        context: context,
        builder: (context) => AddEditFormDialogue(
            id: id, textController: textController, noteService: noteService),
      );
    }

    return Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //       "Notes of ${(context.read<AuthBloc>().state as AuthSuccess).displayName}"),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.only(right: 8.0),
        //       child: GestureDetector(
        //         child: const Text("Logout"),
        //         onTap: () {
        //           context.read<AuthBloc>().add(AuthLogoutRequested());
        //         },
        //       ),
        //     )
        //   ],
        // ),
        floatingActionButton: AddNoteButton(
          openNoteBox: openNoteBox,
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: StreamBuilder<QuerySnapshot>(
            stream: noteService.getNotesStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                print(snapshot.error);
                return const Center(child: Text("Error loading notes"));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No Notes created"));
              }
              List notes = snapshot.data!.docs;
              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = notes[index];

                  return NoteTile(
                    document: document,
                    openNoteBox: openNoteBox,
                    noteService: noteService,
                  );
                },
              );
            },
          ),
        ));
  }
}
