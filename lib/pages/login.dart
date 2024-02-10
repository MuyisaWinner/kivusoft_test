import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kivusoft_test/componnents/color.dart';
import 'package:kivusoft_test/componnents/widget.dart';
import 'package:kivusoft_test/model/user.dart';
import 'package:kivusoft_test/pages/home_page.dart';
import 'package:kivusoft_test/root.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var controlEmail = TextEditingController(),
      controlPassword = TextEditingController(),
      controlNom = TextEditingController(),
      controlPostnom = TextEditingController();
  bool isSignUp = false;
  final _key = GlobalKey<FormState>();
  bool showPassword = false;
  List<int> pictures = [];
  final user = UserModel.currrent;

  @override
  Widget build(BuildContext context) {
    return user != null
        ? const HomePage()
        : Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Get.height / 5,
                      ),
                      const CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Bienvenue sur',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Todoo',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: PrimaryColor.orange),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        isSignUp ? 'Créer un compte !' : 'Connectez-vous !',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                          visible: isSignUp,
                          child: Column(
                            children: [
                              MouseRegionDetector(
                                childDetected: CircleAvatar(
                                  backgroundColor:
                                      PrimaryColor.blueDark.withOpacity(0.4),
                                  radius: 40,
                                  child: IconButton(
                                      onPressed: () async {
                                        final piked = await pikImage();
                                        if (piked.isNotEmpty) {
                                          pictures = piked;
                                        } else {
                                          pictures.clear();
                                        }
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        Icons.camera_alt_rounded,
                                        color: PrimaryColor.white,
                                      )),
                                ),
                                child: CircleAvatar(
                                  backgroundImage: pictures.isEmpty
                                      ? null
                                      : MemoryImage(
                                          Uint8List.fromList(pictures)),
                                  radius: 40,
                                  child: pictures.isEmpty
                                      ? IconButton(
                                          onPressed: () async {
                                            final piked = await pikImage();
                                            if (piked.isNotEmpty) {
                                              pictures = piked;
                                            } else {
                                              pictures.clear();
                                            }
                                            setState(() {});
                                          },
                                          icon: Icon(
                                            Icons.camera_alt_rounded,
                                            color: PrimaryColor.white,
                                          ))
                                      : null,
                                ),
                              ),
                              SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    validator: (value) =>
                                        value!.isEmpty && isSignUp
                                            ? 'Entrer votre nom'
                                            : null,
                                    controller: controlNom,
                                    decoration: const InputDecoration(
                                        hintText: 'Nom',
                                        prefixIcon: Icon(Icons.person)),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    controller: controlPostnom,
                                    validator: (value) =>
                                        value!.isEmpty && isSignUp
                                            ? 'Entrer post nom'
                                            : null,
                                    decoration: const InputDecoration(
                                        hintText: 'Post nom',
                                        prefixIcon: SizedBox.shrink()),
                                  )),
                            ],
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: 300,
                          child: TextFormField(
                            validator: (value) => !value!.isEmail
                                ? 'Entrer un email valide'
                                : null,
                            controller: controlEmail,
                            decoration: const InputDecoration(
                                hintText: 'johndoe@gmail.com',
                                prefixIcon: Icon(CupertinoIcons.mail_solid)),
                          )),
                      SizedBox(
                          width: 300,
                          child: TextFormField(
                            validator: (value) => value!.length < 6
                                ? 'Le mot de passe doit avoir aumoin 6 carracteres'
                                : null,
                            obscureText: !showPassword,
                            controller: controlPassword,
                            decoration: InputDecoration(
                                hintText: 'Mot de passe',
                                suffix: IconButton(
                                    onPressed: () => setState(
                                        () => showPassword = !showPassword),
                                    icon: Icon(showPassword
                                        ? CupertinoIcons.eye
                                        : CupertinoIcons.eye_slash)),
                                prefixIcon: const Icon(Icons.key)),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(isSignUp
                              ? 'Vous avez un compte ?'
                              : 'Vous n\'avez pas de compte ?'),
                          TextButton(
                              onPressed: () =>
                                  setState(() => isSignUp = !isSignUp),
                              child: Text(isSignUp
                                  ? 'Connectez vous !'
                                  : 'Créer en un !'))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: PrimaryColor.white,
                              backgroundColor: PrimaryColor.blue),
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              await EasyLoading.show(status: 'Patienter...');
                              final id = generateDocId();
                              final user = UserModel.build(
                                  id: id,
                                  nom: controlNom.text,
                                  postNom: controlPostnom.text,
                                  email: controlEmail.text.trim(),
                                  password: controlPassword.text,
                                  status: UserStatus.connected.name,
                                  profile: await UserModel.profilePath(id));
                              if (isSignUp) {
                                await user.add().then((value) async {
                                  if (value) {
                                    await user
                                        .createProfile(id, pictures)
                                        .then((value) async {
                                      await user.connect();
                                      Get.to(() => const HomePage());
                                      confirmAction(
                                          action:
                                              'Compte créer avec success !');
                                    });
                                  }
                                });
                              } else {
                                await user.connect().then((value) {
                                  if (value) {
                                    Get.to(() => const HomePage());
                                    confirmAction(
                                        action: 'Connection reussis !');
                                  }
                                });
                              }
                              EasyLoading.dismiss();
                            }
                          },
                          child: const Text(
                            'Connection',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ),
            )),
          );
  }
}
