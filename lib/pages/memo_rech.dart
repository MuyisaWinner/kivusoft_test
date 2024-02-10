import 'package:flutter/material.dart';

class MemoRechPage extends StatefulWidget {
  const MemoRechPage({super.key});
  static const page = '/MemoRechPage';

  @override
  State<MemoRechPage> createState() => _EntreeStockPageState();
}

class _EntreeStockPageState extends State<MemoRechPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Text('Memo de recherche page'),
    ));
  }
}
