import 'package:flutter/material.dart';

class Attachment {
  final int id;
  final String title, description;
  final String image;

  Attachment({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
  });
}

// Our demo Attachments

List<Attachment> demoAttachments = [
  Attachment(
    id: 1,
    image: "assets/images/ps4_console_white_4.png",
    title: "Store License",
    description: "Store License etc....",
  ),
  Attachment(
    id: 2,
    image: "assets/images/ps4_console_white_4.png",
    title: "Tax License",
    description: "Tax License etc....",
  ),
  Attachment(
    id: 3,
    image: "assets/images/ps4_console_white_4.png",
    title: "Other License",
    description: "Other License etc....",
  ),
];

List<Attachment> demoCourierAttachments = [
  Attachment(
    id: 1,
    image: "assets/images/ps4_console_white_4.png",
    title: "Card Id",
    description: "Your id card etc....",
  ),
  Attachment(
    id: 2,
    image: "assets/images/ps4_console_white_4.png",
    title: "Driving License",
    description: "Driving License etc....",
  ),
  Attachment(
    id: 3,
    image: "assets/images/ps4_console_white_4.png",
    title: "Vehicle attachment",
    description: "Vehicle picture etc....",
  ),
  Attachment(
    id: 4,
    image: "assets/images/ps4_console_white_4.png",
    title: "Vehicle License",
    description: "Vehicle License etc....",
  ),
];
