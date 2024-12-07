import 'package:flutter/material.dart';
import 'package:merchant/data/model/Brand.dart';

class SubSubCategories {
  final int id;
  final String title, description;
  int categoryId;
  List<Brand> brandsList;

  SubSubCategories({
    required this.id,
    required this.categoryId,
    required this.brandsList,
    required this.title,
    required this.description,
  });
}

List<SubSubCategories> demoSubSubCategories = [
  SubSubCategories(
    id: 1,
    categoryId: 1,
    brandsList: demoBrandsList,
    title: "All",
    description: "Store License etc....",
  ),
  SubSubCategories(
    id: 2,
    categoryId: 1,
    brandsList: demoBrandsList,
    title: "Smart Phones",
    description: "Tax License etc....",
  ),
  SubSubCategories(
    id: 3,
    categoryId: 1,
    brandsList: demoBrandsList,
    title: "Memory Cards",
    description: "Other License etc....",
  ),
];
