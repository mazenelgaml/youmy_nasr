import 'package:flutter/material.dart';
import 'package:merchant/data/model/SubSubCategory.dart';

class SubCategory {
  final int id;
  final String title, description;
  List<SubSubCategories> subSubCategories;
  int categoryId;

  SubCategory({
    required this.id,
    required this.categoryId,
    required this.subSubCategories,
    required this.title,
    required this.description,
  });
}

List<SubCategory> demoSubCategories = [
  SubCategory(
    id: 1,
    categoryId: 1,
    subSubCategories: demoSubSubCategories,
    title: "All",
    description: "Your id card etc....",
  ),
  SubCategory(
    id: 2,
    categoryId: 1,
    subSubCategories: demoSubSubCategories,
    title: "Mobile",
    description: "Your id card etc....",
  ),
  SubCategory(
    id: 3,
    categoryId: 1,
    subSubCategories: demoSubSubCategories,
    title: "Tablet",
    description: "Your id card etc....",
  ),
  SubCategory(
    id: 4,
    categoryId: 1,
    subSubCategories: demoSubSubCategories,
    title: "Memory Cards",
    description: "Your id card etc....",
  ),
  SubCategory(
    id: 5,
    categoryId: 1,
    subSubCategories: demoSubSubCategories,
    title: "Screens",
    description: "Your id card etc....",
  ),
];
