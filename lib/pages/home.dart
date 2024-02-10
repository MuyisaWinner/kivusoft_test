import 'package:flutter/material.dart';
import 'package:kivusoft_test/componnents/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const page = '/homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(color: PrimaryColor.whiteDark)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ajouter les cas de decès',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Stock No.'),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 150,
                          child: DropdownButton(
                            isExpanded: true,
                            items: [DropdownMenuItem(child: Text('Selection'))],
                            onChanged: (value) {},
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total deces. '),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 150,
                          child: TextField(
                            decoration: InputDecoration(
                                constraints: BoxConstraints(maxHeight: 50),
                                border: OutlineInputBorder()),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: PrimaryColor.white,
                                    backgroundColor: PrimaryColor.blueDark),
                                onPressed: () {},
                                child: Text('Enregistrer'))),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(color: PrimaryColor.whiteDark)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ajouter une depense',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Stock No.'),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 150,
                          child: DropdownButton(
                            isExpanded: true,
                            items: [
                              DropdownMenuItem(
                                  child: ListTile(
                                title: Text('No data'),
                              ))
                            ],
                            onChanged: (value) {},
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Montant '),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 150,
                          child: TextField(
                            decoration: InputDecoration(
                                constraints: BoxConstraints(maxHeight: 50),
                                border: OutlineInputBorder()),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Affectation '),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 150,
                          child: TextField(
                            decoration: InputDecoration(
                                constraints: BoxConstraints(maxHeight: 50),
                                border: OutlineInputBorder()),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: PrimaryColor.white,
                                    backgroundColor: PrimaryColor.blueDark),
                                onPressed: () {},
                                child: Text('Soumettre'))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.all(15),
          decoration:
              BoxDecoration(border: Border.all(color: PrimaryColor.whiteDark)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details du stock',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('Selectionner le No. du stock.'),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 150,
                    child: DropdownButton(
                      isExpanded: true,
                      items: [DropdownMenuItem(child: Text('Selection'))],
                      onChanged: (value) {},
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date : '),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Type : '),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Quantite : '),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Prix : ')
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Entreprise : '),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Ajoute par : '),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Qte actuelle : '),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Total depense : ')
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
