// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kivusoft_test/pages/historique_vente.dart';

// import 'componnents/color.dart';
// import 'pages/historique_client.dart';
// import 'pages/historique_depots.dart';
// import 'pages/home.dart';
// import 'pages/journal_deces.dart';
// import 'pages/list_stock.dart';
// import 'pages/list_utilisateur.dart';
// import 'pages/memo_rech.dart';
// import 'pages/nouveau_utilisateur.dart';
// import 'pages/nouvelle_cliet.dart';
// import 'pages/payment_client.dart';
// import 'pages/profit_stokage.dart';
// import 'pages/ventes_produits.dart';
// import 'services/navigation.dart';

// class NavigationPage extends StatelessWidget {
//   NavigationPage({super.key});

//   final navController = Get.put(NavigationController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(25),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   height: 30,
//                   width: 200,
//                   decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(15)),
//                   child: const Text('Logo place'),
//                 ),
//                 Row(
//                   children: [
//                     const Card(
//                       child: Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Row(
//                           children: [
//                             Text('Bienvenue : '),
//                             Text(
//                               'Thanks. M',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.refresh,
//                           size: 25,
//                         )),
//                     CircleAvatar(
//                         backgroundColor: PrimaryColor.blueDark,
//                         child: Icon(
//                           Icons.logout_sharp,
//                           color: PrimaryColor.white,
//                         ))
//                   ],
//                 )
//               ],
//             ),
//             const Divider(),
//             Row(
//               children: [
//                 SizedBox(
//                     width: 300,
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: ListView(
//                           shrinkWrap: true,
//                           scrollDirection: Axis.vertical,
//                           children: [
//                             navTile('Acceul', HomePage.page),
//                             navTile('List de stockage', ListStockPage.page),
//                             navTile('Nouveau client', NouvelleClientPage.page),
//                             navTile(
//                                 'Ventes des produits', VenteProduitPage.page),
//                             navTile('Payement client', PayementClientPage.page),
//                             navTile('Memo de rech', MemoRechPage.page),
//                             navTile('Historique des clients',
//                                 HistoriqueClientPage.page),
//                             navTile('Journal deces', JournalDecesPage.page),
//                             navTile(
//                                 'Historique des dps', HistoriqueDepotPage.page),
//                             navTile('Nouveau utilisateur',
//                                 NouveauUtilisateurPage.page),
//                             navTile('List des utilisateur',
//                                 ListUtilisateurPage.page),
//                             navTile(
//                                 'Profit de stockage', ProfitStockagePage.page),
//                             navTile('Historique de vente',
//                                 HistoriqueVentePage.page),
//                           ],
//                         ),
//                       ),
//                     )),
//                 const SizedBox(
//                   width: 15,
//                 ),
//                 Expanded(
//                     child: navController.pages[navController.currentPage] ??
//                         const Center(
//                           child: Text('Page not found'),
//                         ))
//               ],
//             )
//           ],
//         ),
//       )),
//     );
//   }

//   Widget navTile(String title, String page) {
//     final navigation = Get.put(NavigationController());
//     return Obx(() {
//       final isSelected = navigation.currentPage.value == page;
//       return Container(
//         decoration: BoxDecoration(
//             color: isSelected ? PrimaryColor.blueDark : null,
//             borderRadius: BorderRadius.circular(15)),
//         child: ListTile(
//           onTap: () => navigation.changePage(page),
//           title: Text(
//             title,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: isSelected ? PrimaryColor.white : null,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
