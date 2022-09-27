import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:multiple_localization_test/l10n/l10n.dart';
import 'package:multiple_localization_test/provider/locale_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LocalProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocalProvider>(context);
          return MaterialApp(
            supportedLocales: L10N.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ], // AppLocalizations.delegates will also work
            locale: provider.locale,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyHomePage(),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appbar_title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(AppLocalizations.of(context)!.home_text),
            Text(
              NumberFormat("0",
                      provider.locale?.toString() ?? L10N.all[0].toString())
                  .format(_counter),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(AppLocalizations.of(context)!.times),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Provider.of<LocalProvider>(context, listen: false)
                    .setLocale(L10N.all[1]);
              },
              child: Text("বাংলা"),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<LocalProvider>(context, listen: false)
                    .setLocale(L10N.all[0]);
              },
              child: Text("English"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
