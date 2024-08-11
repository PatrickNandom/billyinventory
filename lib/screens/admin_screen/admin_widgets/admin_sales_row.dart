import 'package:flutter/material.dart';

class AdminSalesRow extends StatelessWidget {
  final String leftItem;
  final String rightItem;

  AdminSalesRow({
    super.key,
    required this.leftItem,
    required this.rightItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              leftItem,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              rightItem,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
