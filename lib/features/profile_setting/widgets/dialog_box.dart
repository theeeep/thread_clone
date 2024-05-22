import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_clone/core/themes/app_pallate.dart';

class DialogBox extends StatelessWidget {
  final String title, subTitle;
  final VoidCallback callback;
  const DialogBox(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.callback});
  final primaryColor = AppPallete.errorColor;
  final accentColor = AppPallete.whiteColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
            color: AppPallete.greyColor.withOpacity(.2),
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: primaryColor,
              radius: 25,
              child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/FlutterBricksLogo-Med.png?alt=media&token=7d03fedc-75b8-44d5-a4be-c1878de7ed52"),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(title,
                style: const TextStyle(
                    color: AppPallete.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 3.5,
            ),
            Text(subTitle,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleBtn1(text: "Yes", onPressed: callback),
                SimpleBtn1(
                  text: "No",
                  onPressed: () {
                    Get.back();
                  },
                  invertedColors: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SimpleBtn1 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool invertedColors;
  const SimpleBtn1(
      {required this.text,
      required this.onPressed,
      this.invertedColors = false,
      Key? key})
      : super(key: key);
  final primaryColor = Colors.redAccent;
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          alignment: Alignment.center,
          side: WidgetStateProperty.all(
              BorderSide(width: 1, color: primaryColor)),
          padding: WidgetStateProperty.all(
              const EdgeInsets.only(right: 25, left: 25, top: 0, bottom: 0)),
          backgroundColor: WidgetStateProperty.all(
              invertedColors ? accentColor : primaryColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          )),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            color: invertedColors ? primaryColor : accentColor, fontSize: 16),
      ),
    );
  }
}
