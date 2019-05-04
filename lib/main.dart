import 'package:currency_converter/scenes/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CurrencyConverter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Currency Converter",
      color: Colors.amber,
      home: Home(),
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      localeResolutionCallback: (l, i) => l,
    );
  }
}

void main() => runApp(CurrencyConverter());
