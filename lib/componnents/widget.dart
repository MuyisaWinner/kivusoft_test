import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        const SizedBox(
          width: 10,
        ),
        Text(text),
        const SizedBox(
          width: 10,
        ),
        const Expanded(child: Divider())
      ],
    );
  }
}

class MyLine extends StatelessWidget {
  const MyLine({super.key, required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Get.theme.primaryColor),
    );
  }
}

class MyLineVert extends StatelessWidget {
  const MyLineVert(
      {super.key,
      required this.height,
      this.color = Colors.black,
      this.space = 5});
  final double height;
  final Color color;
  final double space;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: space,
        ),
        Container(
          height: height,
          width: 0.5,
          decoration: BoxDecoration(color: color),
        ),
        SizedBox(
          width: space,
        )
      ],
    );
  }
}

class MyCircle extends StatelessWidget {
  const MyCircle({super.key, required this.raduis, this.color = Colors.blue});
  final double raduis;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: raduis,
      width: raduis,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
    );
  }
}

class MyDash extends StatelessWidget {
  const MyDash({super.key, this.height = 1.0, this.color = Colors.black});
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final boxWidth = constraints.constrainWidth();
          const dashWidth = 6.0;
          final dashHeight = height;
          final dashCount = (boxWidth / (2 * dashWidth)).floor();
          return Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                dashCount,
                (index) => SizedBox(
                      width: dashWidth,
                      height: dashHeight,
                      child:
                          DecoratedBox(decoration: BoxDecoration(color: color)),
                    )),
          );
        },
      ),
    );
  }
}

// class MyTimeline extends StatelessWidget {
//   const MyTimeline(
//       {super.key,
//       this.isFirst = false,
//       this.isLast = false,
//       required this.color,
//       this.contrain = 60,
//       required this.icon,
//       required this.child});
//   final bool isFirst;
//   final bool isLast;
//   final Color color;
//   final IconData icon;
//   final double contrain;
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return TimelineTile(
//       beforeLineStyle: const LineStyle(color: Colors.black26),
//       indicatorStyle: IndicatorStyle(
//           width: 30,
//           color: color,
//           iconStyle: IconStyle(iconData: icon, color: Colors.white)),
//       isFirst: isFirst,
//       isLast: isLast,
//       endChild: Container(
//           margin: const EdgeInsets.all(5),
//           constraints: BoxConstraints(minHeight: contrain),
//           child: child),
//     );
//   }
// }

class MouseRegionDetector extends HookWidget {
  const MouseRegionDetector(
      {super.key, required this.child, this.childDetected});
  final Widget? childDetected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isMouseOver = useState<bool>(false);

    return MouseRegion(
      onEnter: (_) {
        isMouseOver.value = true;
      },
      onExit: (_) {
        isMouseOver.value = false;
      },
      child: Stack(
        children: [
          // Votre contenu principal lorsque la souris est absente
          child,

          // Le contenu à afficher lorsque la souris est détectée
          if (isMouseOver.value && childDetected != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: childDetected!,
            ),
        ],
      ),
    );
  }
}

class SearchTile extends StatefulWidget {
  const SearchTile(
      {super.key,
      this.onSearch,
      this.controller,
      this.isTaped = false,
      this.onTapped,
      this.qrCodeSearch});
  final Function(String)? onSearch;
  final TextEditingController? controller;
  final bool isTaped;
  final bool? qrCodeSearch;
  final VoidCallback? onTapped;

  @override
  State<SearchTile> createState() => _SearchTileState();
}

class _SearchTileState extends State<SearchTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: TextField(
              onChanged: widget.onSearch,
              controller: widget.controller,
              decoration: InputDecoration(
                  hintText: 'Rechercher',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  constraints: const BoxConstraints(maxHeight: 40),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                  filled: true,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (widget.controller != null) {
                            widget.controller!.clear();
                          }
                          if (widget.onTapped != null) {
                            widget.onTapped!();
                          }
                        });
                      },
                      icon: Icon(widget.isTaped
                          ? EvaIcons.close
                          : EvaIcons.search))))),
    );
  }
}

// Widget buildSignature() {
//   return RichText(
//     text: TextSpan(
//       children: [
//         const TextSpan(
//           text: '©',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         const TextSpan(text: ' '),
//         TextSpan(
//           text: 'Ndalosoft',
//           style: const TextStyle(
//             fontSize: 16,
//             color: Colors.blue,
//           ),
//           recognizer: TapGestureRecognizer()
//             ..onTap = () {
//               ouvrirSiteWeb('https://ndalosoft.com/');
//             },
//         ),
//         const TextSpan(text: ' '),
//         TextSpan(
//           text: '${DateTime.now().year} All rights reserved',
//           style: TextStyle(
//             fontSize: 16,
//             color: PrimaryColor.whiteDark,
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget myPinput(
//     {required controller,
//     String? Function(String?)? validator,
//     required void Function(String value)? onCompleted,
//     bool obscureTex = false,
//     int length = 4}) {
//   final defaultPinTheme = PinTheme(
//     width: 56,
//     height: 56,
//     textStyle: const TextStyle(
//         fontSize: 20,
//         color: Color.fromRGBO(30, 60, 87, 1),
//         fontWeight: FontWeight.w600),
//     decoration: BoxDecoration(
//       border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
//       borderRadius: BorderRadius.circular(20),
//     ),
//   );

//   final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//     border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
//     borderRadius: BorderRadius.circular(8),
//   );

//   final submittedPinTheme = defaultPinTheme.copyWith(
//     decoration: defaultPinTheme.decoration!.copyWith(
//       color: const Color.fromRGBO(234, 239, 243, 1),
//     ),
//   );

//   return Pinput(
//     length: length,
//     defaultPinTheme: defaultPinTheme,
//     focusedPinTheme: focusedPinTheme,
//     submittedPinTheme: submittedPinTheme,
//     validator: validator,
//     controller: controller,
//     obscureText: obscureTex,
//     keyboardType: TextInputType.text,
//     //inputFormatters: [FilteringTextInputFormatter.],
//     pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//     showCursor: true,
//     onCompleted: onCompleted,
//   );
// }

// class MyBanner extends StatelessWidget {
//   const MyBanner(
//       {super.key,
//       required this.child,
//       required this.text,
//       required this.show,
//       this.color = Colors.blue,
//       this.position = BannerPosition.topLeft,
//       this.onTap});

//   final Widget child;
//   final String text;
//   final bool show;
//   final Color color;
//   final VoidCallback? onTap;
//   final BannerPosition position;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         child,
//         Positioned.fill(
//           child: GestureDetector(
//             onTap: onTap,
//             child: CornerBanner(
//               showBanner: show,
//               bannerPosition: position,
//               bannerText: text,
//               bannerSize: 80.0,
//               bannerColor: color,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

class HeaderDialog extends StatelessWidget {
  const HeaderDialog({super.key, required this.title, this.action});
  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Bootstrap.arrow_left)),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            action ?? const SizedBox.shrink()
          ],
        ),
        const Divider(),
      ],
    );
  }
}
