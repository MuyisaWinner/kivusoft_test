import 'package:flutter/material.dart';

class NouvelleClientPage extends StatefulWidget {
  const NouvelleClientPage({super.key});
  static const page = '/NouvelleClientPage';

  @override
  State<NouvelleClientPage> createState() => _EntreeStockPageState();
}

class _EntreeStockPageState extends State<NouvelleClientPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Text('Nouvelle cliennt page'),
    ));
  }
}
