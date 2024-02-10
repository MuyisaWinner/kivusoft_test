import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:crop_image/crop_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kivusoft_test/controllers/todo_controller.dart';
import 'package:kivusoft_test/controllers/user_controller.dart';
import 'package:kivusoft_test/model/user.dart';
import 'package:kivusoft_test/services/database/database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_size/window_size.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'componnents/color.dart';
import 'componnents/formating.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('fr_FR');
  configLoading();
  await GetStorage.init('K_concourt_caches');
  if (Platform.isWindows) {
    //definir la limite de reajustement de la fenetre sur windows
    setWindowTitle('K_Concours');
    setWindowMinSize(const Size(502.7, 1000));
    //setWindowMinSize(const Size(1800, 1000));
  }
  await DbHelper.instance.initDB();
  final user = Get.put(UsersController());
  Get.put(TodoController());
  // print(user.data.length);
  // for (var element
  //     in user.data.map((element) => UserModel.fromMap(element)).toList()) {
  //   print(await element.delete());
  // }
}

GetStorage get box => GetStorage('K_concourt_caches');

int countLetter(String value, String letter) {
  int count = 0;
  for (var i = 0; i < value.length; i++) {
    if (value[i] == letter) {
      count++;
    }
  }
  return count;
}

bool validNumber(String? value) {
  if (value != null) {
    final containsUpperCase = RegExp(r'[A-Z]').hasMatch(value);
    final containsLowerCase = RegExp(r'[a-z]').hasMatch(value);
    final containsNumber = RegExp(r'\d').hasMatch(value);
    final containsSymbols =
        RegExp(r'[`~!@#$%\^&*\(\)_+\\\-={}\[\]\/,<>;]').hasMatch(value);

    if (containsNumber == true &&
        containsLowerCase == false &&
        containsSymbols == false &&
        containsUpperCase == false &&
        countLetter(value, '.') <= 1 &&
        countLetter(value, ' ') == 0) {
      //print('---NUMBER IS VALID');
      return value.startsWith('.') ? false : true;
    } else if (value.isEmpty) {
      //print('---INPUT EMPTY');
      return true;
    } else if (value.contains(' ')) {
      return false;
    } else {
      //print('---ONLY NUMBER');
      return false;
    }
  } else {
    return false;
  }
}

String generateCodeTransaction() {
  const length = 6;
  const number = '1234567890';
  const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String all = '';
  all += number;
  all += uppercase;

  return List.generate(length, (index) {
    final indexRandom = Random.secure().nextInt(all.length);
    return all[indexRandom];
  }).join('');
}

String generateDocId() {
  const length = 20;
  const lowercase = 'abcdefghijklmnopqrstuvwxyz';
  const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const number = '1234567890';
  String all = '';
  all += lowercase;
  all += uppercase;
  all += number;

  return List.generate(length, (index) {
    final indexRandom = Random.secure().nextInt(all.length);
    return all[indexRandom];
  }).join('');
}

Future questionAction(
    {VoidCallback? onRefuse,
    required VoidCallback confirmAction,
    String? action}) async {
  return await AwesomeDialog(
    //width: Platform.isWindows ? Get.width * 0.5 : null,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    context: Get.context!,
    dialogType: DialogType.question,
    animType: AnimType.scale,
    title: 'Question',
    body: Column(
      children: [
        Text(
          action ?? 'Voulez vous supprimer cette element ?',
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => onRefuse != null ? onRefuse() : Get.back(),
                child: const Text(
                  'Annuler',
                  style: TextStyle(color: Colors.black),
                )),
            const SizedBox(
              width: 20,
            ),
            TextButton(
                onPressed: () {
                  Get.back();
                  confirmAction();
                },
                child: const Text(
                  'Oui',
                  style: TextStyle(color: Colors.red),
                ))
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ],
    ),
    btnCancelIcon: Icons.close,
  ).show();
}

String maj(String value) {
  return value.isEmpty ? '' : value[0].toUpperCase() + value.substring(1);
}

Future loader(
  VoidCallback fonction, {
  String? status,
}) async {
  await EasyLoading.show(maskType: EasyLoadingMaskType.black, status: status);
  fonction();
  await EasyLoading.dismiss();
}

Future confirmAction(
    {bool confirm = true, required String action, int? second}) async {
  return await AwesomeDialog(
    //width: Platform.isWindows ? Get.width * 0.5 : null,
    context: Get.context!,
    dialogType: confirm ? DialogType.success : DialogType.error,
    animType: AnimType.scale,
    title: confirm ? 'REUSSI' : 'ECHOUER',
    desc: action,
    autoHide: Duration(seconds: second ?? 2),
  ).show();
}

// double tauxResult({required double number, required DevisesModel devise}) {
//   double result = 0;
//   //final taux = SettingModel.currentSetting()!.tauxEchange;
//   const taux = 2000;
//   if (devise.symp == 'FC') {
//     result = number / taux!;
//   } else if (devise.symp == 'USD') {
//     result = number * taux!;
//   }

//   return result;
// }

Future<List<int>> pikImage({VoidCallback? onComplete}) async {
  List<int> value = [];
  await EasyLoading.show(
      status: 'Patienter...', maskType: EasyLoadingMaskType.black);
  final controller = CropController(
    aspectRatio: 1,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png'],
  );
  await EasyLoading.dismiss();
  if (result != null) {
    PlatformFile file = result.files.first;
    //print(file.size);
    if (file.size < 1572864) {
      final image = File(file.path!);
      await Get.dialog(Container(
        margin: EdgeInsets.symmetric(
            horizontal: Get.width / 10, vertical: Get.height / 10),
        child: Dialog.fullscreen(
          backgroundColor: PrimaryColor.transparent,
          child: Container(
            margin: const EdgeInsets.all(25),
            decoration: BoxDecoration(
                color: PrimaryColor.white,
                borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                CropImage(
                  controller: controller,
                  image: Image.file(image),
                  paddingSize: 25.0,
                  alwaysMove: true,
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      child: Row(
                        children: [
                          FloatingActionButton.small(
                            elevation: 0,
                            backgroundColor: PrimaryColor.pink.withOpacity(0.5),
                            child: Icon(Icons.close, color: PrimaryColor.white),
                            onPressed: () {
                              Get.back();
                              value = List.empty();
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          FloatingActionButton.small(
                            elevation: 0,
                            backgroundColor:
                                PrimaryColor.green.withOpacity(0.5),
                            child: Icon(
                              Icons.check,
                              color: PrimaryColor.white,
                            ),
                            onPressed: () async {
                              // final setting = SettingModel.currentSetting();
                              await EasyLoading.show();
                              final local = await controller.croppedBitmap();
                              final image = await local.toByteData(
                                  format: ImageByteFormat.png);
                              final bytes = image!.buffer.asUint8List();
                              final path =
                                  (await getApplicationDocumentsDirectory())
                                      .path;
                              ImageFile input = ImageFile(
                                  filePath: path,
                                  rawBytes: bytes); // set the input image file
                              Configuration config = const Configuration(
                                outputType: ImageOutputType.png,
                                // can only be true for Android and iOS while using ImageOutputType.jpg or ImageOutputType.pngÏ
                                useJpgPngNativeCompressor: false,
                                // set quality between 0-100
                                quality: 20,
                              );

                              final param = ImageFileConfiguration(
                                  input: input, config: config);
                              final output = await compressor.compress(param);

                              value = output.rawBytes.toList();
                              await EasyLoading.showToast('Image selectionner');
                              Get.back();
                            },
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ));

      return value;
    } else {
      await EasyLoading.showToast(
          'Selectionner une image de taille inferieur a 1Mo');
    }
    // print(file.name);
    // print(file.bytes);
    // print(file.size);
    // print(file.extension);
    // print(file.path);
    // final image = File(file.path!);
    // print('--------------');
  } else {
    await EasyLoading.showToast('Aucun image selectionner');
    return List.empty();
  }
  return value;
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

// Center emptyList({String message = 'Aucun donnée trouvée'}) {
//   return Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Lottie.asset('assets/lotties/empty.json', height: 200),
//         Text(
//           message,
//           style: TextStyle(
//               fontStyle: FontStyle.italic, color: PrimaryColor.whiteDark),
//         )
//       ],
//     ),
//   );
// }

// Future<bool> deviseIsConnect() async {
//   var connectivityResult = await Connectivity().checkConnectivity();
//   var result = (connectivityResult != ConnectivityResult.none);
//   if (!result) {
//     debugPrint('No Internet');
//   }
//   return result;
// }

void copyToClipboard(String content) {
  Clipboard.setData(ClipboardData(text: content))
      .then((value) => debugPrint('Copié dans le presse-papiers : $content'))
      .catchError((error) => debugPrint('Erreur lors de la copie : $error'));
  EasyLoading.showToast('Copier dans le presse papier');
}

// Future<void> saveAndLauchPDF(
//     {required Uint8List bytes, required String type, String? ext}) async {
//   // final file = Platform.isWindows
//   //     ? await FileSaver.instance.saveFile(
//   //         ext: ext ?? '.pdf',
//   //         bytes: bytes,
//   //         name: 'DOC-$type${DateTime.now().microsecondsSinceEpoch.toString()}')
//   //     : await FileSaver.instance.saveFile(
//   //         ext: ext ?? '.pdf',
//   //         bytes: bytes,
//   //         name: 'DOC-$type${DateTime.now().microsecondsSinceEpoch.toString()}');
//   final path = (await getApplicationDocumentsDirectory()).path;
//   File file = File('$path/$type.pdf');
//   await EasyLoading.showSuccess('Enregister avec succèss !',
//       duration: const Duration(seconds: 5));
//   await file.writeAsBytes(bytes);
//   if (!Platform.isWindows) {
//     Share.shareXFiles([XFile(file.path)], text: type);
//     // await shareFile(file: File(file), subject: '$type ${3456} | ndalostore');
//   }
//   final url = Uri(scheme: 'file', path: file.path);
//   if (await canLaunchUrl(url) && Platform.isWindows) {
//     await launchUrl(url);
//   }
//   await EasyLoading.dismiss();
//   confirmAction(action: 'Exportation terminer !');
// }

void ouvrirSiteWeb(String url) async {
  final u = Uri.parse(url);
  if (await canLaunchUrl(u)) {
    await launchUrl(u);
  } else {
    debugPrint('Impossible d\'ouvrir le site web.');
  }
}

extension StringFonction on String {
  String get maj =>
      isEmpty ? '' : this[0].toUpperCase() + substring(1).toLowerCase();
}

extension DateTimeExtension on DateTime {
  DateTime get date => DateTime(year, month, day);
  DateTime get addMonth => add(const Duration(days: 30));
  DateTimeRange get getMonth => DateTimeRange(
      start: DateTime(year, month),
      end: DateTime(year, month + 1).subtract(const Duration(days: 1)));
  String get dateDay => formatDateDay.format(this);
  String get short => formatDateShort.format(this);
  String get dayMont => formatDayMonth.format(this);
}

extension DateRangeExtension on DateTimeRange {
  String get format {
    if (start.date.isAtSameMomentAs(end.date)) return start.short;
    return 'Du ${start.dateDay.maj} au ${end.short.maj}';
  }
}

extension FormatDouble on double {
  String get format => formatNumber.format(this);
}
