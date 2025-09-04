import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'auth/supabase_auth/supabase_user_provider.dart';
import 'auth/supabase_auth/auth_util.dart';

import '/backend/supabase/supabase.dart';
import 'flutter_flow/flutter_flow_util.dart';

import 'package:power_sync_b0w5r9/app_state.dart'
    as power_sync_b0w5r9_app_state;

import 'package:power_sync_b0w5r9/library_values.dart'
    as power_sync_b0w5r9_library_values;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  power_sync_b0w5r9_library_values.FFLibraryValues().PowerSyncUrl =
      'https://68b963282dfde049b4c22346.powersync.journeyapps.com';
  power_sync_b0w5r9_library_values.FFLibraryValues().PowerSyncSchema =
      '{\"tables\":[{\"name\":\"visits\",\"view_name\":null,\"local_only\":false,\"insert_only\":false,\"columns\":[{\"name\":\"created_at\",\"type\":\"text\"},{\"name\":\"scheduled_at\",\"type\":\"text\"},{\"name\":\"visit_type\",\"type\":\"text\"},{\"name\":\"client_name\",\"type\":\"text\"},{\"name\":\"location\",\"type\":\"text\"},{\"name\":\"assigned_carer_id\",\"type\":\"text\"},{\"name\":\"status\",\"type\":\"text\"},{\"name\":\"completed_at\",\"type\":\"text\"}],\"indexes\":[]},{\"name\":\"visit_notes\",\"view_name\":null,\"local_only\":false,\"insert_only\":false,\"columns\":[{\"name\":\"visit_id\",\"type\":\"text\"},{\"name\":\"author_id\",\"type\":\"text\"},{\"name\":\"note_text\",\"type\":\"text\"},{\"name\":\"created_at\",\"type\":\"text\"},{\"name\":\"author_name\",\"type\":\"text\"}],\"indexes\":[]},{\"name\":\"attachments_queue\",\"view_name\":null,\"local_only\":true,\"insert_only\":false,\"columns\":[{\"name\":\"filename\",\"type\":\"text\"},{\"name\":\"local_uri\",\"type\":\"text\"},{\"name\":\"timestamp\",\"type\":\"integer\"},{\"name\":\"size\",\"type\":\"integer\"},{\"name\":\"media_type\",\"type\":\"text\"},{\"name\":\"state\",\"type\":\"integer\"}],\"indexes\":[]}]}';

  await SupaFlow.initialize();

  final power_sync_b0w5r9AppState = power_sync_b0w5r9_app_state.FFAppState();
  await power_sync_b0w5r9AppState.initializePersistedState();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => power_sync_b0w5r9AppState,
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class MyAppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();
  late Stream<BaseAuthUser> userStream;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = carerVisitsSupabaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Carer Visits',
      scrollBehavior: MyAppScrollBehavior(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}
