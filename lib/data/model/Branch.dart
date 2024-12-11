import 'package:flutter/material.dart';

class Branch {
  final int? id;
  final String? name,description, address, email, workingHours, paymentMethods;
  final double? rating;
  final StoreState status;

  Branch({required this.id,
    this.rating = 0.0,
    required this.name,
    this.description="This branch is the best one iin all the series \nhave a good taste food and will delivered.",
    this.email = "Maadi_b@yomy.com",
    this.workingHours = "Daily from 9 am to 12 pm except friday",
    this.paymentMethods = "Cash - Visa - Credit Card",
    required this.address,
    required this.status});
}

// Our demo Branchs

List<Branch> demoBranches = [
  Branch(
      id: 1,
      name: "Maadi - Branch",
      address: "Maadi,Cairo,Egypt",
      email:"Maadi_b@yomy.com" ,
      description: descriptionData,
      workingHours: workingHoursData,
      paymentMethods:paymentMethodsData,
      rating: 4.8,
      status: StoreState.OPENED),
  Branch(
      id: 2,
      name: "Tahrir - Branch",
      address: "Tahrir,Cairo,Egypt",
      email:"Tahrir_b@yomy.com" ,
      description: descriptionData,
      workingHours: workingHoursData,
      paymentMethods:paymentMethodsData,
      rating: 4.1,
      status: StoreState.CLOSED),
  Branch(
      id: 3,
      name: "Helwan - Branch",
      address: "Helwan,Cairo,Egypt",
      email:"Helwan_b@yomy.com" ,
      description: descriptionData,
      workingHours: workingHoursData,
      paymentMethods:paymentMethodsData,
      status: StoreState.OPENED),
  Branch(
      id: 4,
      name: "Giza - Branch",
      address: "Giza,Cairo,Egypt",
      email:"Giza_b@yomy.com" ,
      description: descriptionData,
      workingHours: workingHoursData,
      paymentMethods:paymentMethodsData,
      rating: 3.1,
      status: StoreState.BUSY),
  Branch(
      id: 4,
      name: "Down Town - Branch",
      address: "Giza,Cairo,Egypt",
      email:"Down_b@yomy.com" ,
      description: descriptionData,
      workingHours: workingHoursData,
      paymentMethods:paymentMethodsData,
      rating: 3.1,
      status: StoreState.BUSY),
  Branch(
      id: 4,
      name: "5 Settlement - Branch",
      address: "Giza,Cairo,Egypt",
      email:"5Settlement_b@yomy.com" ,
      description: descriptionData,
      workingHours: workingHoursData,
      paymentMethods:paymentMethodsData,
      rating: 3.1,
      status: StoreState.BUSY),
  Branch(
      id: 4,
      name: "H-Helwan - Branch",
      address: "Giza,Cairo,Egypt",
      email:"Maadi_b@yomy.com" ,
      description: descriptionData,
      workingHours: workingHoursData,
      paymentMethods:paymentMethodsData,
      rating: 3.1,
      status: StoreState.BUSY),
];

Color getStatus(StoreState status) {
  switch (status) {
    case StoreState.OPENED:
      return Colors.green;

    case StoreState.BUSY:
      return Colors.yellow;
      break;
    case StoreState.CLOSED:
      return Colors.red;
      break;
  }
}

bool isOpened(StoreState status) {
  switch (status) {
    case StoreState.OPENED:
      return true;

    case StoreState.BUSY:
    case StoreState.CLOSED:
      return false;
  }
}

String getStatusDescription(StoreState status) {
  switch (status) {
    case StoreState.OPENED:
      return "Opened";

    case StoreState.BUSY:
      return "Busy";
    case StoreState.CLOSED:
      return "Closed";
      break;
  }
}

String descriptionData="This branch is the best one iin all the series \nhave a good taste food and will delivered.";
String workingHoursData="Daily from 9 am to 12 pm except friday";
String paymentMethodsData="Cash - Visa - Credit Card";

enum StoreState { OPENED, BUSY, CLOSED }
