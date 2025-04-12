import 'package:flutter/material.dart';

class Branch {
  final int? id;
  final String? name, description, address, email, workingHours, paymentMethods;
  final double? rating;
  final bool isOpen;

  Branch({
    required this.id,
    this.rating = 0.0,
    required this.name,
    this.description = "This branch is the best one in all the series \nhave a good taste food and will be delivered.",
    this.email = "Maadi_b@yomy.com",
    this.workingHours = "Daily from 9 am to 12 pm except Friday",
    this.paymentMethods = "Cash - Visa - Credit Card",
    required this.address,
    required this.isOpen,
  });
}

Color getStatus(bool isOpen) {
  return isOpen ? Colors.green : Colors.red;
}

String getStatusDescription(bool isOpen) {
  return isOpen ? "Opened" : "Closed";
}

String descriptionData="This branch is the best one iin all the series \nhave a good taste food and will delivered.";
String workingHoursData="Daily from 9 am to 12 pm except friday";
String paymentMethodsData="Cash - Visa - Credit Card";

enum StoreState { OPENED, BUSY, CLOSED }
