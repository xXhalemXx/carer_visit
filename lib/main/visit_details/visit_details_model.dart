import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/note_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:power_sync_b0w5r9/components/power_sync_query_widget.dart'
    as power_sync_b0w5r9;
import 'package:power_sync_b0w5r9/custom_code/actions/index.dart'
    as power_sync_b0w5r9_actions;
import 'package:power_sync_b0w5r9/flutter_flow/flutter_flow_util.dart'
    as power_sync_b0w5r9_util
    show wrapWithModel, createModel, FlutterFlowDynamicModels;
import 'visit_details_widget.dart' show VisitDetailsWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VisitDetailsModel extends FlutterFlowModel<VisitDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PowerSyncQuery component.
  late power_sync_b0w5r9.PowerSyncQueryModel powerSyncQueryModel;

  @override
  void initState(BuildContext context) {
    powerSyncQueryModel = power_sync_b0w5r9_util.createModel(
        context, () => power_sync_b0w5r9.PowerSyncQueryModel());
  }

  @override
  void dispose() {
    powerSyncQueryModel.dispose();
  }
}
