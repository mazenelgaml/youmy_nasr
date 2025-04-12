import 'package:flutter/material.dart';
import 'package:merchant/util/Constants.dart';

class CustomChip extends StatefulWidget {
  final String label;
  final Color color;
  final Function onPressed;
  final int type;
  final Function(bool)? onSelected; // Accepts bool

  const CustomChip({
    Key? key,
    required this.label,
    this.color = KChipColor,
    this.type = 1,
    this.onSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  bool isSelected = false; // State to track if chip is selected

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Change the selection state and invoke the onSelected callback with a boolean value
        if (widget.type == 1) { // Only handle selection for Chip (type 1)
          setState(() {
            isSelected = !isSelected;
          });

          if (widget.onSelected != null) {
            widget.onSelected!(isSelected);
          }
        }

        widget.onPressed(); // Invoke onPressed callback
      },
      child: widget.type == 1
          ? Chip(
        labelPadding: const EdgeInsets.all(5.0),
        avatar: CircleAvatar(
          backgroundColor: widget.color,
          child: Text(
            widget.label[0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        label: Text(
          widget.label,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: KChipBackColor,
        elevation: 6.0,
        shadowColor: Colors.grey[60],
        padding: const EdgeInsets.all(6.0),
      )
          : FilterChip(
        labelPadding: const EdgeInsets.all(5.0),
        avatar: CircleAvatar(
          backgroundColor: widget.color,
          child: Text(
            widget.label[0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        label: Text(
          widget.label,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: KChipBackColor,
        elevation: 6.0,
        shadowColor: Colors.grey[60],
        padding: const EdgeInsets.all(6.0),
        onSelected: (bool value) {
          if (widget.onSelected != null) {
            widget.onSelected!(value);
          }
        },
      ),
    );
  }
}
