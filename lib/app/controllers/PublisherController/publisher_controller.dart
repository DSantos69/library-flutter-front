import 'package:flutter_modular/flutter_modular.dart';
import 'package:library_flutter/app/utils/custom_snackbars.dart';
import 'package:library_flutter/app/utils/global_scaffold.dart';
import 'package:library_flutter/data/repository/PublishersRepository/publishers_repository.dart';
import 'package:library_flutter/domain/models/Publisher/publisher.dart';
import 'package:mobx/mobx.dart';

part 'publisher_controller.g.dart';

class PublisherController = PublisherControllerBase with _$PublisherController;

abstract class PublisherControllerBase with Store {
  final PublishersRepository repository;

  PublisherControllerBase(this.repository) {
    getAllPublishers();
  }

  @observable
  bool isLoading = false;

  @observable
  List<Publisher> publishers = [];

  @observable
  List<Publisher> cachedPublishers = [];

  @action
  getAllPublishers() async {
    isLoading = true;

    try {
      publishers = await repository.getAll();
      cachedPublishers = publishers;

      isLoading = false;
    } catch (e) {
      showSnackbar(
        CustomSnackBar().error('Houve um problema ao listar editoras'),
      );
    }
  }

  @action
  filter(String value) async {
    isLoading = true;
    if (value.isEmpty) {
      publishers = cachedPublishers;
    }

    List<Publisher> list = publishers
        .where(
          (e) =>
              e.id.toString().toLowerCase().contains(
                    value.toString(),
                  ) ||
              e.name.toString().toLowerCase().contains(
                    (value.toLowerCase()),
                  ) ||
              e.city.toString().toLowerCase().contains(
                    (value.toLowerCase()),
                  ),
        )
        .toList();

    publishers = list;
    isLoading = false;
  }

  @action
  createPublisher(Publisher publisher) async {
    try {
      await repository.post(publisher).then(
            (res) => {
              showSnackbar(
                CustomSnackBar().success('Editora cadastrada com sucesso!'),
              )
            },
          );
      Modular.to.navigate('/publishers/');
    } catch (err) {
      showSnackbar(
        CustomSnackBar().error('Erro ao tentar cadastrar editora'),
      );
    } finally {
      await getAllPublishers();
    }
  }

  @action
  updatePublisher(Publisher publisher) async {
    try {
      await repository.put(publisher).then(
            (res) => showSnackbar(
              CustomSnackBar().success('Editora editada com sucesso!'),
            ),
          );
      Modular.to.navigate('/publishers/');
    } catch (err) {
      showSnackbar(
        CustomSnackBar().error('Erro ao tentar editar a editora'),
      );
    } finally {
      await getAllPublishers();
    }
  }

  @action
  deletePublisher(Publisher publisher) async {
    {
      try {
        await repository.delete(publisher).then(
              (res) => {
                showSnackbar(
                  CustomSnackBar().success('Editora apagada com sucesso!'),
                ),
                Modular.to.pop()
              },
            );
      } catch (err) {
        showSnackbar(
          CustomSnackBar().error('Erro ao tentar apagar a editora'),
        );
      } finally {
        await getAllPublishers();
      }
    }
  }
}
