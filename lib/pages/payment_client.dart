import 'package:flutter/material.dart';

class PayementClientPage extends StatefulWidget {
  const PayementClientPage({super.key});
  static const page = '/PayementClientPage';

  @override
  State<PayementClientPage> createState() => _EntreeStockPageState();
}

class _EntreeStockPageState extends State<PayementClientPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Text('Payement client page'),
    ));
  }
}
