import 'package:flutter/material.dart';

class BadgeTodo extends StatefulWidget {
  final String title;
  final int count;
  final Color color;
  final VoidCallback? onTap;

  const BadgeTodo({
    Key? key,
    required this.title,
    required this.count,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  _BadgeTodoState createState() => _BadgeTodoState();
}

class _BadgeTodoState extends State<BadgeTodo> {
  bool isSelected = false;

  void _handleTap() {
    setState(() {
      isSelected = !isSelected;
    });

    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? widget.color.withOpacity(0.4) : widget.color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? widget.color : Colors.grey),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${widget.count}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: widget.color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 14,
                color: widget.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
