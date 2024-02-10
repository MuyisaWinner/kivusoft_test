import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kivusoft_test/componnents/color.dart';
import 'package:kivusoft_test/componnents/drawer.dart';
import 'package:kivusoft_test/componnents/widget.dart';
import 'package:kivusoft_test/controllers/todo_controller.dart';
import 'package:kivusoft_test/model/todo.dart';
import 'package:kivusoft_test/model/user.dart';
import 'package:kivusoft_test/pages/new_todo.dart';
import 'package:kivusoft_test/root.dart';
import 'package:lottie/lottie.dart';

import '../componnents/todoo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoController = Get.put(TodoController());
  var searchController = TextEditingController();
  TodoStatus? selectedStatus;
  DateTime? selectedDate;
  final user = UserModel.currrent;
  String query = '';
  List<TodoModel> filter(
      List<TodoModel> data, String q, DateTime? date, TodoStatus? status) {
    var result = <TodoModel>[];
    if (date != null) {
      result = data
          .where((element) => element.date.date.isAtSameMomentAs(date.date))
          .toList();
    } else if (status != null) {
      result = data.where((element) => element.status == status.name).toList();
    } else if (q.isNotEmpty) {
      result = data
          .where((element) => element.title.contains(q.toLowerCase()))
          .toList();
    } else {
      result = data;
    }

    return result;
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final show = Get.put(NewTodoController());
          show.showTodo(null);
        },
        backgroundColor: PrimaryColor.blueDark,
        child: Icon(
          Icons.add,
          color: PrimaryColor.white,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                    icon: const Icon(CupertinoIcons.rectangle_grid_2x2_fill)),
                CircleAvatar(
                  backgroundImage: user!.picture == null
                      ? null
                      : MemoryImage(user!.picture!),
                  child: user!.picture == null
                      ? Text(
                          user!.nom[0].toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      : null,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/images/logo.png',
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Vos notes sur',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Todoo',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: PrimaryColor.blue),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              query.isNotEmpty
                  ? 'Resultat pour \'$query\''
                  : 'Toutes mes todoo',
              style: TextStyle(color: PrimaryColor.whiteDark),
            ),
            Row(
              children: [
                Expanded(
                  child: SearchTile(
                    controller: searchController,
                    isTaped: query.isNotEmpty,
                    onSearch: (p0) => setState(() => query = p0),
                    onTapped: () => setState(() {
                      selectedDate = null;
                      selectedStatus = null;
                      query = '';
                    }),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      final piked = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2099));
                      selectedDate = piked;
                      query = searchController.text =
                          piked != null ? piked.short.maj : '';
                      setState(() {});
                    },
                    icon: const Icon(Icons.calendar_today)),
                PopupMenuButton(
                  itemBuilder: (context) => TodoStatus.values
                      .map((e) => PopupMenuItem(
                          onTap: () => setState(() {
                                query = searchController.text = e.label;
                                selectedStatus = e;
                              }),
                          child: ListTile(
                            title: Text(e.label.maj),
                          )))
                      .toList(),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(child: Obx(() {
              final data = todoController.data
                  .map((element) => TodoModel.fromMap(element))
                  .toList();

              var todoo = filter(data, query, selectedDate, selectedStatus);
              todoo.sort(
                (a, b) => b.date.compareTo(a.date),
              );
              return todoo.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/lotties/empty.json',
                              height: 100),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Aucun resultat ${query.isNotEmpty ? 'pour $query' : ''}',
                            style: TextStyle(color: PrimaryColor.whiteDark),
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      children: List.generate(todoo.length, (index) {
                        final todo = (todoo[index]);
                        return TodooTile(todo: todo);
                      }),
                    );
            }))
          ],
        ),
      )),
    );
  }
}
