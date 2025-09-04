import '/flutter_flow/flutter_flow_util.dart';
import 'main_page_widget.dart' show MainPageWidget;
import 'package:power_sync_b0w5r9/components/power_sync_query_widget.dart'
    as power_sync_b0w5r9;
import 'package:power_sync_b0w5r9/flutter_flow/flutter_flow_util.dart'
    as power_sync_b0w5r9_util
    show wrapWithModel, createModel, FlutterFlowDynamicModels;
import 'package:flutter/material.dart';

class MainPageModel extends FlutterFlowModel<MainPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Model for PowerSyncQuery component.
  late power_sync_b0w5r9.PowerSyncQueryModel powerSyncQueryModel1;
  // Model for PowerSyncQuery component.
  late power_sync_b0w5r9.PowerSyncQueryModel powerSyncQueryModel2;

  @override
  void initState(BuildContext context) {
    powerSyncQueryModel1 = power_sync_b0w5r9_util.createModel(
        context, () => power_sync_b0w5r9.PowerSyncQueryModel());
    powerSyncQueryModel2 = power_sync_b0w5r9_util.createModel(
        context, () => power_sync_b0w5r9.PowerSyncQueryModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    powerSyncQueryModel1.dispose();
    powerSyncQueryModel2.dispose();
  }
}
