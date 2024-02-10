import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kivusoft_test/componnents/color.dart';
import 'package:kivusoft_test/componnents/formating.dart';
import 'package:kivusoft_test/pages/new_todo.dart';
import 'package:kivusoft_test/pages/todo_details.dart';
import 'package:kivusoft_test/root.dart';

import '../model/todo.dart';

class TodooTile extends StatelessWidget {
  const TodooTile({
    super.key,
    required this.todo,
  });

  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final show = Get.put(TodoDetails());
        show.showDialog(todo);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: todo.getStatus.color.withOpacity(0.4), width: 2)),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 40,
                  decoration: BoxDecoration(
                      color: todo.getStatus.color,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Center(
                    child: Text(
                      todo.getStatus.label,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: PrimaryColor.white),
                    ),
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title.maj,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      formatDateShort.format(todo.date).maj,
                      style: TextStyle(color: PrimaryColor.whiteDark),
                    ),
                    const Divider(),
                    Text(todo.description.maj),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: todo.getStatus == TodoStatus.en_cours,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PopupMenuButton(
                              icon: Row(
                                children: [
                                  Text(
                                    'Action',
                                    style: TextStyle(
                                        color: PrimaryColor.whiteDark),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: PrimaryColor.whiteDark,
                                  )
                                ],
                              ),
                              itemBuilder: (_) => [
                                    PopupMenuItem(
                                        onTap: () => questionAction(
                                              action:
                                                  'Marquer le todoo comme terminer ?',
                                              confirmAction: () async {
                                                await EasyLoading.show(
                                                    status: 'Patienter...');
                                                final t = TodoModel.build(
                                                    id: todo.id,
                                                    title: todo.title,
                                                    description:
                                                        todo.description,
                                                    date: todo.date,
                                                    status: TodoStatus
                                                        .terminer.name);
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
                                              backgroundColor:
                                                  PrimaryColor.green,
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
                                                await EasyLoading.show(
                                                    status: 'Patienter...');
                                                final t = TodoModel.build(
                                                    id: todo.id,
                                                    title: todo.title,
                                                    description:
                                                        todo.description,
                                                    date: todo.date,
                                                    status: TodoStatus
                                                        .annuler.name);
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
                                              backgroundColor:
                                                  PrimaryColor.pink,
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
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
