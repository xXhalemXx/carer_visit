import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ff_commons/flutter_flow/lat_lng.dart';
import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_commons/flutter_flow/uploaded_file.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';
import "package:power_sync_b0w5r9/backend/schema/structs/index.dart"
    as power_sync_b0w5r9_data_schema;

List<VisitsRow> supabaseRowsToVistors(List<dynamic> supabaseRows) {
  return supabaseRows.map((r) => VisitsRow(r)).toList();
}

List<VisitNotesRow>? supabaseRowsToNotes(List<dynamic> supabaseRows) {
  return supabaseRows.map((r) => VisitNotesRow(r)).toList();
}

String? testauth() {
// Check Supabase authentication
  final user = Supabase.instance.client.auth.currentUser;
  print('=== FlutterFlow Auth Check ===');
  print('User ID: ${user?.id}');
  print('User Email: ${user?.email}');
  print('User Role: ${user?.role}');
  print('Session Valid: ${user != null}');
  print(
      'Access Token: ${Supabase.instance.client.auth.currentSession?.accessToken != null}');
  return user?.id ?? '';
}
