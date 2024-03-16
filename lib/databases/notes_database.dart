import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sq_flite_database/model/note.dart';

class NotesDatabase{
  static final NotesDatabase instance = NotesDatabase._init();

  //Database to send sql commands, created during openDatabase
  static Database? _database;


  NotesDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database!;

    //This is where the database will be store

    _database = await _initDB('notes.db');
    return _database;
  }

  // If a database doesn't exist then it will create one
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // This method is called when the database is created for the first time
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const boolType = "BOOLEAN NOT NULL";
    const textType = "TEXT NOT NULL";
    const integerType = 'INTEGER NOT NULL';


    await db.execute('''
    CREATE TABLE $tableNotes (
     ${NoteFields.id} $idType,
     ${NoteFields.isImportant} $boolType,
     ${NoteFields.number} $integerType,
     ${NoteFields.title} $textType,
     ${NoteFields.description} $textType,
     ${NoteFields.createdTime} $textType,
     ${NoteFields.selection} $textType,
    )
    ''');
  }

    Future <Note> create(Note note) async {
      final db = await  instance.database;

      final id = await db?.insert(tableNotes, note.toJson());
      return note.copy(id: id);

    }

    Future <Note> readNote (int id) async {
      final db = await instance.database;

      final maps = await db?.query(
        tableNotes,
        columns:  NoteFields.values,
        where: '${NoteFields.id} = ?',
        whereArgs: [id],
      );

      if (maps!.isNotEmpty){
        return Note.fromJson(maps.first);
      } else {
        throw Exception('ID $id not found');
      }
    }


    Future <List <Note>> readALLNotes() async {
      final db  = await instance.database;

      final orderBy = '${NoteFields.createdTime} ASC';
      final result = await db?.query(tableNotes, orderBy:  orderBy);

      return result!.map((json) => Note.fromJson(json)).toList();
    }


    //SQL Injection Prevention: Use parameterized queries
    //(using whereArgs in query and delete methods) to prevent SQL injection attacks.
    Future<int> update(Note note) async {
      final db = await instance.database;

      return db!.update(
        tableNotes,
        note.toJson(),
        where: '${NoteFields.id} = ?',
        whereArgs: [note.id],
      );
    }

    Future<int> delete (int id) async {
      final db = await instance.database;

      return await db!.delete(
        tableNotes,
        where: '${NoteFields.id} = ?',
        whereArgs: [id],
      );
    }


  Future close() async {
    final db = await instance.database;
    db?.close();
  }
}


