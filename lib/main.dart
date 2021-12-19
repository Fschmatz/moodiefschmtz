import 'package:flutter/material.dart';
import 'package:moodiefschmtz/app.dart';
import 'package:moodiefschmtz/util/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(ChangeNotifierProvider(
    create: (_) => ThemeNotifier(),
    child: Consumer<ThemeNotifier>(
      builder:(context, ThemeNotifier notifier, child){
        return MaterialApp(
          theme: notifier.darkTheme ? dark : light,
          debugShowCheckedModeBanner: false,
          home: App(),
        );
      },
    ),
  )
  );
}

