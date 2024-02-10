import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kivusoft_test/componnents/color.dart';
import 'package:kivusoft_test/componnents/widget.dart';
import 'package:kivusoft_test/model/todo.dart';
import 'package:kivusoft_test/root.dart';

class NewTodoController extends GetxController {
  var controlTitle = TextEditingController(),
      controlDescription = TextEditingController();
  var selectedDate = DateTime.now().obs;
  final _key = GlobalKey<FormState>();
  showTodo(TodoModel? todo) {
    if (todo != null) {
      controlDescription.text = todo.description;
      controlTitle.text = todo.title;
    } else {
      controlDescription.clear();
      controlTitle.clear();
    }

    return Get.bottomSheet(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Form(
            key: _key,
            child: ListView(
              children: [
                const Column(
                  children: [
                    MyLine(width: 100),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Ajouter une Todoo',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const Column(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Divider(),
                    ),
                  ],
                ),
                Obx(() => TextFormField(
                      readOnly: true,
                      onTap: () async {
                        final piked = await showDatePicker(
                            context: Get.context!,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2099));
                        if (piked != null) {
                          selectedDate.value = piked;
                        } else {
                          selectedDate.value = DateTime.now();
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.calendar_today),
                          hintText: selectedDate.value.short.maj,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: controlTitle,
                  validator: (value) =>
                      value!.isEmpty ? 'Entrer le titre de votre todoo' : null,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.title),
                      hintText: 'Titre du Todoo',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: 4,
                  controller: controlDescription,
                  validator: (value) =>
                      value!.isEmpty ? 'Entrer le titre de votre todoo' : null,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.description),
                      hintText: 'Description du Todoo',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: PrimaryColor.white,
                              backgroundColor: PrimaryColor.blueDark),
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              questionAction(
                                action: 'Enregister le Todoo ?',
                                confirmAction: () async {
                                  final todoo = TodoModel.build(
                                      id: todo != null
                                          ? todo.id
                                          : generateDocId(),
                                      title: controlTitle.text,
                                      date: selectedDate.value,
                                      description: controlDescription.text,
                                      status: TodoStatus.en_cours.name);
                                  await todoo.add().then((value) {
                                    if (value) {
                                      Get.back();
                                      confirmAction(
                                          action:
                                              'Todoo enregistrer avec success');
                                    }
                                  });
                                },
                              );
                            }
                          },
                          child: const Text('Enregistrer')),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        backgroundColor: PrimaryColor.white);
  }
}
