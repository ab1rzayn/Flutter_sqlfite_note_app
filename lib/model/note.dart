final String tableNotes = 'notes';

class NoteFields{


  static final List<String> values = [
    id, isImportant, number, title, description, createdTime, selection,
  ];

  static final String id ="_id";
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String createdTime = 'createdTime';
  static final String selection = 'createdTime';
}



class Note{
  final int ? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;
  final String selection;

  const Note({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
    required this.selection,
  });

  Map<String, Object?> toJson() => {
    NoteFields.id : id,
    NoteFields.isImportant : isImportant ? 1 : 0,
    NoteFields.number : number,
    NoteFields.title : title,
    NoteFields.description : description,
    NoteFields.createdTime : createdTime.toIso8601String(),
    NoteFields.selection : selection,
  };

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
    String ? selection,
  }) => Note(
    id: id ?? this.id,
    isImportant: isImportant ?? this.isImportant,
    number: number ?? this.number,
    title: title ?? this.title,
    description: description ?? this.description,
    createdTime: createdTime ?? this.createdTime,
    selection: selection ?? this.selection,
  );

  static Note fromJson(Map<String, Object?>json) => Note(
    id : json[NoteFields.id] as int?,
    number: json[NoteFields.number] as int,
    title: json[NoteFields.title] as String,
    description: json[NoteFields.description] as String,
    isImportant: json[NoteFields.isImportant] == 1,
    createdTime: DateTime.parse(json[NoteFields.createdTime] as String),
    selection: json[NoteFields.selection] as String,

  );
}