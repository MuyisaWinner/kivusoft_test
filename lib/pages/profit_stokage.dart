import 'package:flutter/material.dart';

class ProfitStockagePage extends StatefulWidget {
  const ProfitStockagePage({super.key});
  static const page = '/ProfitStockagePage';

  @override
  State<ProfitStockagePage> createState() => _EntreeStockPageState();
}

class _EntreeStockPageState extends State<ProfitStockagePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Text('Profit stokage page'),
    ));
  }
}
