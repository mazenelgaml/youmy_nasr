import 'package:flutter/material.dart';

import 'Order.dart';

class Product {
  final String id;
  int quantity;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isActive;
  final int? branchCode;
  final String? itemCode;

  Product(  {
    this.itemCode,
    this.branchCode,
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.quantity = 1,
    this.isFavourite = false,
    this.isActive = false,
    required this.title,
    required this.price,
    required this.description,
  });
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: "1",
    images: [
      "assets/images/logo.png",
      "assets/images/branch.png",
      "assets/images/facebook.png",
      "assets/images/mobile.png"
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Burger King™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isActive: true,
  ),
  Product(
    id: "2",
    images: [
      "assets/images/logo.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Pizza Mondial - super",
    price: 50.5,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isActive: false,
  ),
  Product(
    id: "3",
    images: ["assets/images/mobile.png"],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "PizzaHut - Light",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isActive: false,
  ),
  Product(
    id: "4",
    images: ["assets/images/logo.png", "assets/images/mobile.png"],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Orange Organic",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isActive: true,
  ),
  Product(
    id: "1",
    images: [
      "assets/images/logo.png",
      "assets/images/branch.png",
      "assets/images/facebook.png",
      "assets/images/mobile.png"
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Burger Chief™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isActive: true,
  ),
  Product(
    id: '2',
    images: [
      "assets/images/logo.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Pizza - Dominus",
    price: 50.5,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isActive: true,
  ),
  Product(
    id: '3',
    images: ["assets/images/mobile.png"],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "PizzaHut - SoftCraft",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isActive: true,
  ),
  Product(
    id: '4',
    images: ["assets/images/logo.png", "assets/images/mobile.png"],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Apple Juice",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isActive: true,
  ),
  Product(
    id: '1',
    images: [
      "assets/images/logo.png",
      "assets/images/branch.png",
      "assets/images/facebook.png",
      "assets/images/mobile.png"
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Burger Buffalou™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isActive: true,
  ),
  Product(
    id: '2',
    images: [
      "assets/images/logo.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Rice - super",
    price: 50.5,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isActive: true,
  ),
  Product(
    id: '3',
    images: ["assets/images/mobile.png"],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Hampurger - super",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isActive: true,
  ),
  Product(
    id: '4',
    images: ["assets/images/logo.png", "assets/images/mobile.png"],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Guafa Juice",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isActive: true,
  ),
  Product(
    id: '1',
    images: [
      "assets/images/logo.png",
      "assets/images/branch.png",
      "assets/images/facebook.png",
      "assets/images/mobile.png"
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Water King™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isActive: true,
  ),
  Product(
    id: '2',
    images: [
      "assets/images/logo.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Marshmillo - super",
    price: 50.5,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isActive: true,
  ),
  Product(
    id: '3',
    images: ["assets/images/mobile.png"],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Donuts - super",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isActive: true,
  ),
  Product(
    id: '4',
    images: ["assets/images/logo.png", "assets/images/mobile.png"],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Onion Juice",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: false,
    isActive: false,
  ),
];

List <Product> subList=demoProducts.sublist(0,4);

const String description = "This product is to delicious and tasy  …";
