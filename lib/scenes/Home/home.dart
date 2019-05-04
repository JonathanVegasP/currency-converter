import 'package:currency_converter/CurrencyData/currency_data.dart';
import 'package:currency_converter/components/text_input.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _dollar;
  double _eur;
  final _brl = TextEditingController();
  final _dollarControl = TextEditingController();
  final _eurControl = TextEditingController();
  final _dollarFocus = FocusNode();
  final _eurFocus = FocusNode();
  final test = TextInput();

  void _brlChanged(String s) {
    double brl;
    if (s.isEmpty)
      brl = 0;
    else
      brl = double.parse(s);
    _dollarControl.text = (brl / _dollar).toStringAsFixed(2);
    _eurControl.text = (brl / _eur).toStringAsFixed(2);
  }

  void _dollarChanged(String s) {
    double dollar;
    if (s.isEmpty)
      dollar = 0;
    else
      dollar = double.parse(s);
    _brl.text = (dollar * _dollar).toStringAsFixed(2);
    _eurControl.text = (dollar * _dollar / _eur).toStringAsFixed(2);
  }

  void _eurChanged(String s) {
    double eur;
    if (s.isEmpty)
      eur = 0;
    else
      eur = double.parse(s);
    _brl.text = (eur * _eur).toStringAsFixed(2);
    _dollarControl.text = (eur * _eur / _dollar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Currency Converter"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Loading...",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "An error has occurred :(",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  _dollar =
                      snapshot.data["results"]["currencies"]["USD"]["buy"];
                  _eur = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(
                          Icons.monetization_on,
                          size: 150.0,
                          color: Colors.amber,
                        ),
                        TextInput(
                          onChanged: _brlChanged,
                          controller: _brl,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (s) =>
                              FocusScope.of(context).requestFocus(_dollarFocus),
                          labelText: "BRL",
                          prefixText: "R\$ ",
                        ),
                        Divider(),
                        TextInput(
                          onChanged: _dollarChanged,
                          controller: _dollarControl,
                          focusNode: _dollarFocus,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (s) =>
                              FocusScope.of(context).requestFocus(_eurFocus),
                          labelText: "Dollar",
                          prefixText: "\$ ",
                        ),
                        Divider(),
                        TextInput(
                          onChanged: _eurChanged,
                          controller: _eurControl,
                          focusNode: _eurFocus,
                          textInputAction: TextInputAction.done,
                          labelText: "EUR",
                          prefixText: "€ ",
                        ),
                      ],
                    ),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
