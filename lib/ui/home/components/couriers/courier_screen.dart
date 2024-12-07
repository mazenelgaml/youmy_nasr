
import 'package:flutter/material.dart';
import 'package:merchant/ui/home/components/couriers/components/body.dart';


class CourierScreen extends StatefulWidget {
  const CourierScreen({Key? key}) : super(key: key);
  static var routeName = "/couriers";

  @override
  State<CourierScreen> createState() => _CourierScreenState();
}

class _CourierScreenState extends State<CourierScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
