import '../database.dart';

class VisitNotesTable extends SupabaseTable<VisitNotesRow> {
  @override
  String get tableName => 'visit_notes';

  @override
  VisitNotesRow createRow(Map<String, dynamic> data) => VisitNotesRow(data);
}

class VisitNotesRow extends SupabaseDataRow {
  VisitNotesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VisitNotesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get visitId => getField<String>('visit_id')!;
  set visitId(String value) => setField<String>('visit_id', value);

  String get authorId => getField<String>('author_id')!;
  set authorId(String value) => setField<String>('author_id', value);

  String get noteText => getField<String>('note_text')!;
  set noteText(String value) => setField<String>('note_text', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get authorName => getField<String>('author_name');
  set authorName(String? value) => setField<String>('author_name', value);
}
