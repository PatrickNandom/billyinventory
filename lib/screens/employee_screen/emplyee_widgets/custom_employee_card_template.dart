import 'package:flutter/material.dart';

class EmployeeProductCard extends StatelessWidget {
  final String productImage;
  final String productName;
  final String quantity;
  final String price;
  final VoidCallback onRemove;
  final VoidCallback onAdd;
  final VoidCallback onDelete;

  EmployeeProductCard({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.onRemove,
    required this.onAdd,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 119,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Image.network(
                productImage,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('QTY: $quantity'),
                  Text('Price: ₦ $price'),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: onRemove,
                        child: const Icon(Icons.remove),
                      ),
                      GestureDetector(
                        onTap: onAdd,
                        child: const Icon(Icons.add),
                      ),
                      GestureDetector(
                        onTap: onDelete,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
