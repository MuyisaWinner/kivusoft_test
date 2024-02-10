import 'package:flutter/material.dart';

class HistoriqueVentePage extends StatefulWidget {
  const HistoriqueVentePage({super.key});
  static const page = '/HistoriqueVentePage';

  @override
  State<HistoriqueVentePage> createState() => _EntreeStockPageState();
}

class _EntreeStockPageState extends State<HistoriqueVentePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Text('Historique des ventes page'),
    ));
  }
}
