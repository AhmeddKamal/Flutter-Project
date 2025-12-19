import 'package:flutter/material.dart';
import '../models/note.dart';
import 'add_edit_note_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> notes = [];

  void addNote(Note note) {
    setState(() {
      notes.add(note);
    });
  }

  void deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Note? newNote = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditNotePage(),
            ),
          );

          if (newNote != null) {
            addNote(newNote);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: notes.isEmpty
          ? const Center(
              child: Text(
                'No Notes Yet',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () => deleteNote(index),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: 1,
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
  title: Text(notes[index].title),
  subtitle: Text(notes[index].content),
  onTap: () async {
    final Note? editedNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditNotePage(
          note: notes[index],
          index: index,
        ),
      ),
    );

    if (editedNote != null) {
      updateNote(index, editedNote);
    }
  },
),
                    ),
                  ),
                );
              },
            ),
    );
  }
  void updateNote(int index, Note newNote) {
  setState(() {
    notes[index] = newNote;
  });
}

}
