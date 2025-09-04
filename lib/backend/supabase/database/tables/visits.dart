import '../database.dart';

class VisitsTable extends SupabaseTable<VisitsRow> {
  @override
  String get tableName => 'visits';

  @override
  VisitsRow createRow(Map<String, dynamic> data) => VisitsRow(data);
}

class VisitsRow extends SupabaseDataRow {
  VisitsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VisitsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  DateTime get scheduledAt => getField<DateTime>('scheduled_at')!;
  set scheduledAt(DateTime value) => setField<DateTime>('scheduled_at', value);

  String get visitType => getField<String>('visit_type')!;
  set visitType(String value) => setField<String>('visit_type', value);

  String get clientName => getField<String>('client_name')!;
  set clientName(String value) => setField<String>('client_name', value);

  String? get location => getField<String>('location');
  set location(String? value) => setField<String>('location', value);

  String? get assignedCarerId => getField<String>('assigned_carer_id');
  set assignedCarerId(String? value) =>
      setField<String>('assigned_carer_id', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  DateTime? get completedAt => getField<DateTime>('completed_at');
  set completedAt(DateTime? value) => setField<DateTime>('completed_at', value);
}
