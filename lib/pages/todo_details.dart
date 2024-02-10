import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kivusoft_test/componnents/color.dart';
import 'package:kivusoft_test/componnents/widget.dart';
import 'package:kivusoft_test/model/todo.dart';
import 'package:kivusoft_test/pages/new_todo.dart';
import 'package:kivusoft_test/root.dart';

class TodoDetails extends GetxController {
  showDialog(TodoModel todo) {
    return Get.bottomSheet(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const MyLine(width: 100),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Description du Todoo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                width: 50,
                child: Divider(),
              ),
              Text(
                'Titre',
                style: TextStyle(color: PrimaryColor.whiteDark),
              ),
              Text(
                todo.title.maj,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Description',
                style: TextStyle(color: PrimaryColor.whiteDark),
              ),
              Text(
                todo.description.maj,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const MyDivider(text: 'Actions'),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                            final show = Get.put(NewTodoController());
                            show.showTodo(todo);
                          },
                          icon: const Icon(Icons.edit))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: PrimaryColor.pink,
                        borderRadius: BorderRadius.circular(20)),
                    child: IconButton(
                        color: PrimaryColor.white,
                        onPressed: () => questionAction(
                              action: 'Supprimer le todo ?',
                              confirmAction: () async {
                                await EasyLoading.show(status: 'Loading....');
                                await todo.delete().then((value) async {
                                  if (value) {
                                    await EasyLoading.dismiss();
                                    Get.back();
                                    confirmAction(action: 'Supprimé');
                                  }
                                });
                              },
                            ),
                        icon: const Icon(Icons.delete)),
                  )),
                  Visibility(
                    visible: todo.getStatus == TodoStatus.en_cours,
                    child: Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PopupMenuButton(
                            icon: Row(
                              children: [
                                Text(
                                  'Action',
                                  style:
                                      TextStyle(color: PrimaryColor.whiteDark),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: PrimaryColor.whiteDark,
                                )
                              ],
                            ),
                            itemBuilder: (_) => [
                                  PopupMenuItem(
                                      enabled:
                                          todo.getStatus == TodoStatus.en_cours,
                                      onTap: () => questionAction(
                                            action:
                                                'Marquer le todoo comme terminer ?',
                                            confirmAction: () async {
                                              Get.back();
                                              await EasyLoading.show(
                                                  status: 'Patienter...');
                                              final t = TodoModel.build(
                                                  id: todo.id,
                                                  title: todo.title,
                                                  description: todo.description,
                                                  date: todo.date,
                                                  status:
                                                      TodoStatus.terminer.name);
                                              await t.add().then((value) {
                                                if (value) {
                                                  EasyLoading.dismiss();
                                                  confirmAction(
                                                      action:
                                                          'Le todo est terminer');
                                                }
                                              });
                                            },
                                          ),
                                      child: Chip(
                                          side: BorderSide.none,
                                          avatar: CircleAvatar(
                                            backgroundColor: PrimaryColor.green,
                                            radius: 10,
                                            child: Icon(
                                              Icons.check,
                                              color: PrimaryColor.white,
                                              size: 15,
                                            ),
                                          ),
                                          padding: EdgeInsets.zero,
                                          label: const Text('Terminer'))),
                                  PopupMenuItem(
                                      onTap: () => questionAction(
                                            action:
                                                'Marquer le todoo comme annuler ?',
                                            confirmAction: () async {
                                              Get.back();
                                              await EasyLoading.show(
                                                  status: 'Patienter...');
                                              final t = TodoModel.build(
                                                  id: todo.id,
                                                  title: todo.title,
                                                  description: todo.description,
                                                  date: todo.date,
                                                  status:
                                                      TodoStatus.annuler.name);
                                              await t.add().then((value) {
                                                if (value) {
                                                  EasyLoading.dismiss();
                                                  confirmAction(
                                                      action:
                                                          'Le todo est annuler');
                                                }
                                              });
                                            },
                                          ),
                                      child: Chip(
                                          side: BorderSide.none,
                                          avatar: CircleAvatar(
                                            backgroundColor: PrimaryColor.pink,
                                            radius: 10,
                                            child: Icon(
                                              Icons.close,
                                              color: PrimaryColor.white,
                                              size: 15,
                                            ),
                                          ),
                                          padding: EdgeInsets.zero,
                                          label: const Text('Annuler')))
                                ]),
                      ],
                    )),
                  )
                ],
              )
            ],
          ),
        ),
        backgroundColor: PrimaryColor.white);
  }
}
