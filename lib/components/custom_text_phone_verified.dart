import 'package:flutter/material.dart';

class CustomTextPhoneVerified extends StatelessWidget {
  final bool autoFocus;
  final BuildContext context;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;

  const CustomTextPhoneVerified(
      {super.key,
      required this.context,
      this.controller,
      required this.autoFocus,
        this.textInputType = TextInputType.number,
        this.textInputAction=TextInputAction.next,

      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(this.context).size.shortestSide * 0.13,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        shape: BoxShape.rectangle,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: TextField(
          controller: controller,
          autofocus: autoFocus,
          textInputAction: textInputAction,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          textAlign: TextAlign.center,
          keyboardType: textInputType,
          style: const TextStyle(),
          maxLines: 1,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(this.context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}
