import 'package:flutter/material.dart';

class ListUtilisateurPage extends StatefulWidget {
  const ListUtilisateurPage({super.key});
  static const page = '/ListUtilisateurPage';

  @override
  State<ListUtilisateurPage> createState() => _EntreeStockPageState();
}

class _EntreeStockPageState extends State<ListUtilisateurPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Text('List utilisateur page'),
    ));
  }
}
