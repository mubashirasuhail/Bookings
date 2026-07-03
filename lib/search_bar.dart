import 'package:flutter/material.dart';

class OrderSearchBar extends StatelessWidget {
  const OrderSearchBar({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE8E8EE), width: 1),
        ),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
          decoration: InputDecoration(
            hintText: 'Search package, vendor or Order ID..',
            hintStyle: TextStyle(
              fontSize: 13,
              color: Colors.grey[400],
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: Colors.grey[400],
              size: 20,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
}
