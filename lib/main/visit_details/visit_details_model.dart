import '/flutter_flow/flutter_flow_util.dart';
import 'package:power_sync_b0w5r9/components/power_sync_query_widget.dart'
    as power_sync_b0w5r9;
import 'package:power_sync_b0w5r9/flutter_flow/flutter_flow_util.dart'
    as power_sync_b0w5r9_util
    show wrapWithModel, createModel, FlutterFlowDynamicModels;
import 'visit_details_widget.dart' show VisitDetailsWidget;
import 'package:flutter/material.dart';

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
