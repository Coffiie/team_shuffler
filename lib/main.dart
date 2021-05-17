import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:team_shuffler/global/di/locator.dart';
import 'package:team_shuffler/global/routes/router.dart';
import 'package:team_shuffler/global/routes/routes.dart';
import 'package:team_shuffler/global/services/database_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  setupSnackbarUi();

  //db
  final DatabaseManager _service = locator<DatabaseManager>();
  await _service.openDb();
  runApp(MyApp());
}

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  //#cccccc
  // This widget is the root of your application.
  final Color primaryColor = const Color(0xFFF5F5F5);
  final MaterialColor kPrimaryColor = const MaterialColor(
    0xFFF5F5F5,
    <int, Color>{
      50: Color(0xFFF5F5F5),
      100: Color(0xFFF5F5F5),
      200: Color(0xFFF5F5F5),
      300: Color(0xFFF5F5F5),
      400: Color(0xFFF5F5F5),
      500: Color(0xFFF5F5F5),
      600: Color(0xFFF5F5F5),
      700: Color(0xFFF5F5F5),
      800: Color(0xFFF5F5F5),
      900: Color(0xFFF5F5F5),
    },
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      navigatorKey: StackedService.navigatorKey,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        primarySwatch: kPrimaryColor,
        primaryColor: primaryColor,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: kPrimaryColor),
        brightness: Brightness.dark,
        textTheme: GoogleFonts.sourceSansProTextTheme(
                Theme.of(context).textTheme)
            .copyWith(
                headline4: TextStyle(color: primaryColor),
                headline5: TextStyle(color: primaryColor)
                // body1: GoogleFonts.oswald(textStyle: Theme.of(context).textTheme.body1),
                ),
      ),
      onGenerateRoute: generateRoute,
      initialRoute: shuffleView,
    );
  }
}
