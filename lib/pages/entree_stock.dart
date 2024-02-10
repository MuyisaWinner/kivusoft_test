import 'package:flutter/material.dart';

class EntreeStockPage extends StatefulWidget {
  const EntreeStockPage({super.key});
  static const page = '/entreeStockPage';

  @override
  State<EntreeStockPage> createState() => _EntreeStockPageState();
}

class _EntreeStockPageState extends State<EntreeStockPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Text('Entrée en stock page'),
    ));
  }
}
