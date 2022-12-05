import 'package:all_you_can_eat/responsive_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAf8mdO3-DxOaYFeGmUP3lG3zn0i4YUk6A",
            authDomain: "all-you-can-eat-42b69.firebaseapp.com",
            projectId: "all-you-can-eat-42b69",
            storageBucket: "all-you-can-eat-42b69.appspot.com",
            messagingSenderId: "296214016227",
            appId: "1:296214016227:web:22cb47c302f1f6025995d6",
            measurementId: "G-7PQN7QGJHH"));
  } else {
    GoogleFonts.config.allowRuntimeFetching = false;
    await Firebase.initializeApp();
  }

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      /*onGenerateRoute: (settings) =>
          PageRoutes.generateRoute(settings, context),*/
      home: ResponsiveHandler(),
    );
  }
}
