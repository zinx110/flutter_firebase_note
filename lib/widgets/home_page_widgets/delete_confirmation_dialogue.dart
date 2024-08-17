import 'package:flutter/material.dart';
import 'package:flutter_firebase_note/services/firestore.dart';

class DeleteConfirmationDialogue extends StatelessWidget {
  final String id;
  final FirestoreService firestoreService;
  const DeleteConfirmationDialogue(
      {super.key, required this.id, required this.firestoreService});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text("Are you sure you want to delete?"),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            try {
              firestoreService.deleteNote(id);
              Navigator.pop(context);
            } catch (e) {
              final errorText = e.toString();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                errorText,
                style: const TextStyle(color: Colors.red),
              )));
            }
          },
          label: const Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          label: const Text(
            "Cancel",
          ),
          icon: const Icon(
            Icons.cancel,
          ),
        )
      ],
    );
  }
}
