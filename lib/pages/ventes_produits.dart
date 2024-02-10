import 'package:flutter/material.dart';

class VenteProduitPage extends StatefulWidget {
  const VenteProduitPage({super.key});
  static const page = '/VenteProduitPage';

  @override
  State<VenteProduitPage> createState() => _EntreeStockPageState();
}

class _EntreeStockPageState extends State<VenteProduitPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Text('Vente produit page'),
    ));
  }
}
