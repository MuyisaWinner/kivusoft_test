import 'package:flutter/material.dart';

class ListStockPage extends StatefulWidget {
  const ListStockPage({super.key});
  static const page = '/listStockPage';

  @override
  State<ListStockPage> createState() => _EntreeStockPageState();
}

class _EntreeStockPageState extends State<ListStockPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Text('List stock page'),
    ));
  }
}
