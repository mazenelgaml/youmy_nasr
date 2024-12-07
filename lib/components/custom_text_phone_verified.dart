import 'package:flutter/material.dart';

class CustomTextPhoneVerified extends StatelessWidget {
  final bool autoFocus;
  final BuildContext context;
  final TextInputType textInputType;
  final TextInputAction textInputAction;

  const CustomTextPhoneVerified(
      {Key? key,
      required this.context,
      required this.autoFocus,
        this.textInputType = TextInputType.number,
        this.textInputAction=TextInputAction.next,
      })
      : super(key: key);

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
