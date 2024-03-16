# sq_flite_database

A Flutter project based on SQFLITE

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Documentation For this app

** main.dart
await SystemChrome.setPreferredOrientations([...]): This line sets the preferred screen orientations for the application.
It uses SystemChrome.setPreferredOrientations() method to specify which orientations are allowed. 
In this case, it allows only portrait-up and portrait-down orientations. 
This means the app will only be displayed in portrait mode (vertical orientation), 
and rotation to landscape mode (horizontal orientation) will be prevented.


** note_page.dart
The purpose of using late here is to indicate that the notes list will be initialized later in the initState() method
or any other method before it's accessed in the build method or anywhere else in the clas

refreshNotes() =>method is a function that asynchronously updates the list of notes displayed in the widget.

the dispose()=> method in this context ensures that the database connection is properly closed and any associated 
resources are released when the NotesPage widget is removed from the widget tree, preventing memory leaks 
and ensuring the proper functioning of the application.






