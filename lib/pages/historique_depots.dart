import 'package:flutter/material.dart';

class HistoriqueDepotPage extends StatefulWidget {
  const HistoriqueDepotPage({super.key});
  static const page = '/HistoriqueDepotPage';

  @override
  State<HistoriqueDepotPage> createState() => _EntreeStockPageState();
}

class _EntreeStockPageState extends State<HistoriqueDepotPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Text('Historique de depot page'),
    ));
  }
}
