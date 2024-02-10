import 'package:flutter/material.dart';

class JournalDecesPage extends StatefulWidget {
  const JournalDecesPage({super.key});
  static const page = '/JournalDecesPage';

  @override
  State<JournalDecesPage> createState() => _EntreeStockPageState();
}

class _EntreeStockPageState extends State<JournalDecesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Text('Journal deces page'),
    ));
  }
}
