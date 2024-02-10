import 'package:flutter/material.dart';

class NouveauUtilisateurPage extends StatefulWidget {
  const NouveauUtilisateurPage({super.key});
  static const page = '/NouveauUtilisateurPage';

  @override
  State<NouveauUtilisateurPage> createState() => _EntreeStockPageState();
}

class _EntreeStockPageState extends State<NouveauUtilisateurPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Text('Noveau utilisateur page'),
    ));
  }
}
