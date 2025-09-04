import '/auth/supabase_auth/auth_util.dart';
import '/components/visits_component/visits_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:power_sync_b0w5r9/components/power_sync_connectivity_widget.dart'
    as power_sync_b0w5r9;
import 'package:power_sync_b0w5r9/components/power_sync_query_widget.dart'
    as power_sync_b0w5r9;
import 'package:power_sync_b0w5r9/flutter_flow/flutter_flow_util.dart'
    as power_sync_b0w5r9_util
    show wrapWithModel, createModel, FlutterFlowDynamicModels;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'main_page_model.dart';
export 'main_page_model.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({super.key});

  static String routeName = 'mainPage';
  static String routePath = '/mainPage';

  @override
  State<MainPageWidget> createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget>
    with TickerProviderStateMixin {
  late MainPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainPageModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Align(
                alignment: Alignment(0.0, 0),
                child: TabBar(
                  labelColor: FlutterFlowTheme.of(context).primary,
                  unselectedLabelColor:
                      FlutterFlowTheme.of(context).secondaryText,
                  labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                  unselectedLabelStyle: TextStyle(),
                  indicatorColor: FlutterFlowTheme.of(context).primary,
                  indicatorWeight: 3.0,
                  tabs: [
                    Tab(
                      text: 'Upcoming',
                    ),
                    Tab(
                      text: 'History',
                    ),
                    Tab(
                      text: 'Uncovered',
                    ),
                  ],
                  controller: _model.tabBarController,
                  onTap: (i) async {
                    [() async {}, () async {}, () async {}][i]();
                  },
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _model.tabBarController,
                  children: [
                    KeepAliveWidgetWrapper(
                      builder: (context) =>
                          power_sync_b0w5r9_util.wrapWithModel(
                        model: _model.powerSyncQueryModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: power_sync_b0w5r9.PowerSyncQueryWidget(
                          sql: 'SELECT * FROM visits;',
                          watch: true,
                          parameters: <String, dynamic>{
                            'assigned_carer_id': currentUserUid,
                          },
                          child: (List<dynamic> rows) => VisitsComponentWidget(
                            upcmingData:
                                functions.supabaseRowsToVistors(rows.toList()),
                            isUncoverd: false,
                            onTap: () async {},
                          ),
                        ),
                      ),
                    ),
                    KeepAliveWidgetWrapper(
                      builder: (context) =>
                          power_sync_b0w5r9_util.wrapWithModel(
                        model: _model.powerSyncConnectivityModel,
                        updateCallback: () => safeSetState(() {}),
                        child: power_sync_b0w5r9.PowerSyncConnectivityWidget(),
                      ),
                    ),
                    KeepAliveWidgetWrapper(
                      builder: (context) =>
                          power_sync_b0w5r9_util.wrapWithModel(
                        model: _model.powerSyncQueryModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: power_sync_b0w5r9.PowerSyncQueryWidget(
                          sql:
                              'SELECT *\nFROM visits\nWHERE assigned_carer_id IS NULL\n  AND scheduled_at BETWEEN dateTime(\'now\') AND dateTime(\'now\', \'+14 days\')\nORDER BY scheduled_at ASC;',
                          watch: true,
                          parameters: <String, dynamic>{},
                          child: (List<dynamic> rows) => VisitsComponentWidget(
                            upcmingData:
                                functions.supabaseRowsToVistors(rows.toList()),
                            isUncoverd: true,
                            onTap: () async {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
