import 'package:flutter/material.dart';

class Delivery {
  final int id;
  final String title;
  final double from, to,cost;

  Delivery({
    required this.id,
    required this.title,
    required this.from,
    required this.to,
    required this.cost
  });
}


List<Delivery> demoDeliveries = [
  Delivery(
    id: 1,
    title: "First Cost",
    from: 10,
    to: 20,
    cost: 25
  ),
  Delivery(
    id: 2,
      title: "Second Cost",
      from: 20,
      to: 30,
      cost: 15
  ),
  Delivery(
    id: 3,
      title: "Third Cost",
      from: 30,
      to: 40,
      cost: 20
  ),
];

