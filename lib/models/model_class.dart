import 'package:flutter/material.dart';

class OrderModel {
  final String title;
  final String orderId;
  final double price;
  final String status;
  final Color statusColor;
  final Color statusBgColor;
  final IconData statusIcon;
  final String imagePath;
  final List<String> categories;
  const OrderModel({
    required this.title,
    required this.orderId,
    required this.price,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
    required this.statusIcon,
    required this.imagePath,
    required this.categories,
  });
}