import 'package:flutter_modular/flutter_modular.dart';
import 'package:library_flutter/controllers/RoutesController/routes_controller.dart';

import 'package:library_flutter/controllers/ThemeController/theme_controller.dart';
import 'package:library_flutter/modules/RoutesModule/routes_module.dart';
import 'package:library_flutter/views/Home/home_page.dart';

class MainModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => ThemeController()),
        Bind.singleton((i) => RoutesController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const HomePage(),
        ),
        ModuleRoute(
          '/',
          module: RoutesModule(),
        )
      ];
}
