// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import "package:power_sync_b0w5r9/backend/schema/structs/index.dart"
    as power_sync_b0w5r9_data_schema;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// DO NOT REMOVE OR MODIFY THE CODE
Future<void> debugPowerSyncAuth() async {
  print('=== PowerSync Debug ===');

  // Check Supabase session
  final session = Supabase.instance.client.auth.currentSession;
  print('Supabase Session exists: ${session != null}');
  print('Access Token exists: ${session?.accessToken != null}');

  if (session?.accessToken != null) {
    print('Token first 50 chars: ${session!.accessToken.substring(0, 50)}...');
  }

  // Check if you have a PowerSync database instance
  // Replace 'yourPowerSyncDatabase' with your actual variable name
  try {
    // You need to find how you access your PowerSync database
    // It might be a global variable or in a service class
    print('Checking PowerSync connection...');

    // This is where you'd check your PowerSync instance
    // The exact code depends on how you set it up
  } catch (e) {
    print('PowerSync access error: $e');
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
