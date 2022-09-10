import 'package:flutter_modular/flutter_modular.dart';
import 'package:library_flutter/repository/PublishersRepository/publishers_repository.dart';
import 'package:library_flutter/store/PublisherStore/publisher_store.dart';
import 'package:library_flutter/views/Publishers/components/form_publisher.dart';
import 'package:library_flutter/views/Publishers/publishers_page.dart';

class PublishersModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => PublisherStore(i())),
        Bind.factory((i) => PublishersRepository()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const PublishersPage(),
        ),
        ChildRoute(
          '/form/:id',
          child: (context, args) => FormPublisher(
            id: args.params["id"],
            name: args.queryParams["name"],
            city: args.queryParams["city"],
          ),
          transition: TransitionType.downToUp,
          duration: const Duration(milliseconds: 700),
        ),
      ];
}
