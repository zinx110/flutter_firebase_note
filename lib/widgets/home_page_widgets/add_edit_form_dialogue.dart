import 'package:flutter/material.dart';
import 'package:flutter_firebase_note/services/note_service.dart';

class AddEditFormDialogue extends StatelessWidget {
  final String? id;

  final TextEditingController textController;
  final NoteService noteService;
  const AddEditFormDialogue({
    super.key,
    required this.id,
    required this.textController,
    required this.noteService,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: textController,
        autofocus: true,
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            //add new note
            try {
              final note = textController.text.trim();
              if (note.isEmpty) {
                throw Exception("Cannot be empty");
              }
              if (id == null) {
                noteService.addNote(note);
              } else {
                noteService.updateNote(id: id as String, note: note);
              }

              textController.clear();
              Navigator.pop(context);
            } catch (e) {
              final errorMessage = e.toString();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              )));
            }
          },
          child: Text(
            id == null ? "Add" : "Save",
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
        ),
      ],
    );
  }
}
