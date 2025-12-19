import 'package:flutter/material.dart';
import '../models/note.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;
  final int? index;

  const AddEditNotePage({super.key, this.note, this.index});

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController =
        TextEditingController(text: widget.note?.title ?? '');
    contentController =
        TextEditingController(text: widget.note?.content ?? '');
  }

  void saveNote() {
    if (titleController.text.isEmpty ||
        contentController.text.isEmpty) {
      return;
    }

    final updatedNote = Note(
      title: titleController.text,
      content: contentController.text,
    );

    Navigator.pop(context, updatedNote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.note == null ? 'Add Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration:
                        const InputDecoration(labelText: 'Title'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: contentController,
                    maxLines: 4,
                    decoration:
                        const InputDecoration(labelText: 'Content'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveNote,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
