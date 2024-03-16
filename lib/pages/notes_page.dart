import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../databases/notes_database.dart';
import '../model/note.dart';
import '../pages/note_detail_page.dart';
import '../pages/edit_note_page.dart';
import '../widgets/note_card_widget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  //a list variable for storing notes, but it's not immediately initialized
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future<void> refreshNotes() async {
    setState(() => isLoading = true);

    //asynchronously retrieves all notes from the database
    //await keyword is used here to pause the execution of the method
    //until the notes are fetched from the database.
    notes = await NotesDatabase.instance.readALLNotes();

    //After the notes are fetched and assigned to the notes variable,
    //this line sets the isLoading flag back to false
    setState(() => isLoading = false);
  }

  //doc!
  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(

    //This is Appbar
    appBar: AppBar(
      title: const Text(
        "All Notes",
        style: TextStyle(fontSize: 20,
        color: Colors.amberAccent,
        ),
      ),
      actions: const [
        Icon(Icons.search,
        color: Colors.amberAccent,
        ),
        SizedBox(width: 12),
      ],
    ),

    //This Sets the location where the notes will present at the note_page
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 0.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: isLoading
              ? const CircularProgressIndicator()
              : notes.isEmpty
              ? const Text(
            "No Notes are added yet",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          )
              : buildNotes(),
        ),
      ),
    ),

    //This allows add notes and direct user to add note page
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.amberAccent,
      child: const Icon(Icons.add, color: Colors.black,),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddEditNotePage()),
        );

        //After Directing to Note page the page will be refreshed
        refreshNotes();
      },
    ),
  );

  Widget buildNotes() => StaggeredGrid.count(
    crossAxisCount: 2,
    mainAxisSpacing: 2,
    crossAxisSpacing: 2,
    children: List.generate(
      notes.length,
          (index) {
        final note = notes[index];

        return StaggeredGridTile.fit(
          crossAxisCellCount: 1,
          child: GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NoteDetailPage(noteId: note.id!),
                ),
              );

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          ),
        );
      },
    ),
  );
}
