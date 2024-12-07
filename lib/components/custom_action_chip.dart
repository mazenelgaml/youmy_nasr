import 'package:flutter/material.dart';
import 'package:merchant/util/Constants.dart';

class CustomChoiceChip extends StatefulWidget {
  final String label;
  final Color color;
  final Function onSelected;
  late bool isSelected;

   CustomChoiceChip({Key? key,
    this.isSelected = false,
    required this.label,
    this.color = KChipColor,
    required this.onSelected})
      : super(key: key);

  @override
  State<CustomChoiceChip> createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      labelPadding: const EdgeInsets.all(5.0),
      avatar: CircleAvatar(
        backgroundColor: widget.color,
        child: Text(widget.label[0].toUpperCase(),style: TextStyle(color: Colors.white)),
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
        widget.onSelected(value);
        setState(() {
          widget.isSelected = true;
        });
      },
      selected: widget.isSelected,
    );
  }
}
