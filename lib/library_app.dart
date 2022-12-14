import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:library_flutter/app/controllers/ThemeController/theme_controller.dart';
import 'package:library_flutter/app/utils/global_scaffold.dart';

class LibraryApp extends StatefulWidget {
  const LibraryApp({Key? key}) : super(key: key);

  @override
  State<LibraryApp> createState() => _LibraryAppState();
}

class _LibraryAppState extends State<LibraryApp> {
  @override
  Widget build(BuildContext context) {
    var store = Modular.get<ThemeController>();

    return Observer(
      builder: (_) => MaterialApp.router(
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          brightness: store.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        scaffoldMessengerKey: snackbarKey,
        debugShowCheckedModeBanner: false,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}
