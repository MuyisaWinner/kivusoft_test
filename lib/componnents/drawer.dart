import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kivusoft_test/componnents/color.dart';
import 'package:kivusoft_test/model/user.dart';
import 'package:kivusoft_test/pages/login.dart';
import 'package:kivusoft_test/root.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});
  final user = UserModel.currrent;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: PrimaryColor.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 70,
                    ),
                    Text(
                      'Todoo',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: PrimaryColor.blue),
                    ),
                    const Text(
                      'Organiser vos notes et votre agenda',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 100,
                child: Divider(),
              ),
              ExpansionTile(
                leading: CircleAvatar(
                  backgroundImage: user!.picture == null
                      ? null
                      : MemoryImage(user!.picture!),
                  child: user!.picture == null
                      ? Text(
                          user!.nom[0].toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      : null,
                ),
                title: Text(user!.nomComplet),
                childrenPadding: const EdgeInsets.symmetric(horizontal: 30),
                children: [
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.mail_solid,
                        color: PrimaryColor.whiteDark,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(user!.email)
                    ],
                  ),
                ],
              ),
              const Spacer(),
              ListTile(
                onTap: () => questionAction(
                  action: 'Voulez vous vous deconnecter ?',
                  confirmAction: () async {
                    await EasyLoading.show(status: 'Patienter...');
                    await user!.desconnect().then((value) async {
                      if (value) {
                        await EasyLoading.dismiss();
                        Get.offAll(() => const LoginPage());
                        confirmAction(action: 'Deconnecter avec succèss');
                      }
                    });
                  },
                ),
                leading: const Icon(CupertinoIcons.power),
                title: const Text('Deconexion'),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Copyright Muyisa Winner',
                style: TextStyle(color: PrimaryColor.whiteDark),
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
