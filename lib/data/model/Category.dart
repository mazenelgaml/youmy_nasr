import 'package:flutter/material.dart';
import 'package:merchant/data/model/SubCategory.dart';
import 'package:merchant/data/model/SubSubCategory.dart';

class Category {
  final int id;
  final String title, description;
  late List<SubCategory> subCategories;

  Category({
    required this.id,
    required this.subCategories,
    required this.title,
    required this.description,
  });
}

// Our demo categories

List<Category> demoCategories = [
  Category(
    id: 1,
    subCategories:demoSubCategories.toList(growable: true),
    title: "All",
    description: "Store License etc....",
  ),
  Category(
    id: 2,
    subCategories:demoSubCategories.toList(growable: true),
    title: "Mobiles & Tablets",
    description: "Tax License etc....",
  ),
  Category(
    id: 3,
    subCategories:demoSubCategories.toList(growable: true),
    title: "Electronics",
    description: "Other License etc....",
  ),
  Category(
    id: 3,
    subCategories:demoSubCategories.toList(growable: true),
    title: "Home Machines",
    description: "Other License etc....",
  ),
  Category(
    id: 3,
    subCategories:demoSubCategories.toList(growable: true),
    title: "Clothes & Shoes",
    description: "Other License etc....",
  ),
];

List<SubCategory> subCategories = [
  SubCategory(
    id: 1,
    categoryId: 1,
    subSubCategories:demoSubSubCategories.toList(growable: true),
    title: "Card Id",
    description: "Your id card etc....",
  ),
  SubCategory(
    id: 2,
    categoryId: 1,
    subSubCategories:demoSubSubCategories.toList(growable: true),
    title: "Driving License",
    description: "Driving License etc....",
  ),
  SubCategory(
    id: 3,
    categoryId: 1,
    subSubCategories:demoSubSubCategories.toList(growable: true),
    title: "Vehicle Category",
    description: "Vehicle picture etc....",
  ),
  SubCategory(
    id: 4,
    categoryId: 1,
    subSubCategories:demoSubSubCategories.toList(growable: true),
    title: "Vehicle License",
    description: "Vehicle License etc....",
  ),
];

