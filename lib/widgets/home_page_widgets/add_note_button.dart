import 'package:flutter/material.dart';

class AddNoteButton extends StatefulWidget {
  final void Function([String id]) openNoteBox;
  const AddNoteButton({super.key, required this.openNoteBox});

  @override
  State<AddNoteButton> createState() => _AddNoteButtonState();
}

class _AddNoteButtonState extends State<AddNoteButton> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: widget.openNoteBox,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ));
  }
}
