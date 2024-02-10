import 'package:flutter/material.dart';

class HistoriqueClientPage extends StatefulWidget {
  const HistoriqueClientPage({super.key});
  static const page = '/HistoriqueClientPage';

  @override
  State<HistoriqueClientPage> createState() => _EntreeStockPageState();
}

class _EntreeStockPageState extends State<HistoriqueClientPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Text('Historique client page'),
    ));
  }
}
