import 'package:flutter/material.dart';

class SelectCategory extends StatelessWidget {
  final ValueNotifier<String?> controller;

  const SelectCategory({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: controller,
      builder: (context, selectedCategory, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category label
            const Text(
              'Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8.0),

            // Category options
            Row(
              children: [
                _buildCategoryOption(
                  context: context,
                  category: 'Learning',
                  selectedCategory: selectedCategory,
                  onTap: () => controller.value = 'Learning',
                  color: Colors.green,
                ),
                const SizedBox(width: 12.0),
                _buildCategoryOption(
                  context: context,
                  category: 'Work',
                  selectedCategory: selectedCategory,
                  onTap: () => controller.value = 'Work',
                  color: Colors.blue,
                ),
                const SizedBox(width: 12.0),
                _buildCategoryOption(
                  context: context,
                  category: 'General',
                  selectedCategory: selectedCategory,
                  onTap: () => controller.value = 'General',
                  color: Colors.amber,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildCategoryOption({
    required BuildContext context,
    required String category,
    required String? selectedCategory,
    required VoidCallback onTap,
    required Color color,
  }) {
    final isSelected = selectedCategory == category;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? color : Colors.grey.withOpacity(0.1), // Gray for non-selected
        ),
        child: Text(
          category,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: isSelected ? Colors.white : Colors.black, // White text for selected
          ),
        ),
      ),
    );
  }
}
