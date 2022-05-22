import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:posts/app_routes.dart';
import 'package:posts/constants/colors.dart';
import 'package:posts/constants/functions.dart';
import 'package:posts/constants/variables.dart';
import 'package:posts/data_layer/providers/language_provider.dart';
import 'package:posts/localization/localization.dart';
import 'package:posts/presentation_layer/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(context, newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  setLocale(BuildContext context, Locale locale) {
    LanguageProvider provider =
        Provider.of<LanguageProvider>(context, listen: false);
    provider.updateLanguage(locale);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Functions.getProviders(),
      child: Consumer<LanguageProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Posts',
            theme: ThemeData(fontFamily: "Almarai"),
            debugShowCheckedModeBanner: false,
            locale: provider.locale,
            supportedLocales: const [
              Locale(Variables.englishLangCode, Variables.englishCountryCode),
              Locale(Variables.arabicLangCode, Variables.arabicCountryCode),
            ],
            localizationsDelegates: const [
              Localization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale!.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            onGenerateRoute: AppRoutes().generateRoute,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
