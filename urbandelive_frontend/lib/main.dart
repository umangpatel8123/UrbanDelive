// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:urbandelive/provider/auth_provider.dart';
import 'package:urbandelive/screens/edit_user_details.dart';
import 'package:urbandelive/screens/home_screen.dart';
import 'package:urbandelive/screens/login_page.dart';
import 'package:urbandelive/screens/searchby_business.dart';
import 'package:urbandelive/screens/welcome_screen.dart';
import 'utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBO4nN0h9A0P5qAxGMOewuQFk5hXcsesm0",
        appId: "1:242640977096:web:5e82f0b05cb2f4a3b3f9fd",
        messagingSenderId: "242640977096",
        projectId: "urbandelive-6c642"),
  );
  runApp(const UrbanDelive());
}

class UrbanDelive extends StatelessWidget {
  const UrbanDelive({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // ChangeNotifierProvider(create: (_) => BusinessProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "UrbanDelive",
        theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        // home: const WelcomeScreen(),
        initialRoute: "/",
        routes: {
          "/": (context) => const WelcomeScreen(),
          MyRoute.searchbyBusinessRoute: (context) => const SearchByBusiness(),
          MyRoute.welcomeScreenRoute: (context) => const WelcomeScreen(),
          MyRoute.editUserDetailRoute: (context) => const UserEditDetail(
                phoneNumber: '',
              ),
        },
      ),
    );
  }
}
