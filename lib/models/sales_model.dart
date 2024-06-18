import 'package:cloud_firestore/cloud_firestore.dart';

class Sales {
  final String saleId;
  final String productId;
  final String quantitySold;
  final double totalPrice;
  final String empId;
  final String empName;
  final DateTime salesDate;

  Sales({
    required this.saleId,
    required this.productId,
    required this.quantitySold,
    required this.totalPrice,
    required this.empId,
    required this.empName,
    required this.salesDate,
  });

  static Sales fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Sales(
      saleId: snapshot["saleId"],
      productId: snapshot["productId"],
      quantitySold: snapshot["quantitySold"],
      totalPrice: snapshot["totalPrice"],
      empId: snapshot["empId"],
      empName: snapshot["empName"],
      salesDate: snapshot["salesDate"],
    );
  }

  Map<String, dynamic> toJson() => {
        "saleId": saleId,
        "productId": productId,
        "quantitySold": quantitySold,
        "totalPrice": totalPrice,
        "empId": empId,
        "empName": empName,
        "salesDate": salesDate,
      };
}
