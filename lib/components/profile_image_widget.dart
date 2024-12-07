import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileImageWidget extends StatefulWidget {
  final String iconName;
  final Function onPressed;

  const ProfileImageWidget({
    Key? key,
    required this.iconName,
    required this.onPressed

  }) : super(key: key);

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      width: 88,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
           CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage("assets/images/${widget.iconName}"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  disabledBackgroundColor: Colors.white,
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed:widget.onPressed(),
                child: SvgPicture.asset("assets/icons/Camera.svg",
                    color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }
}
