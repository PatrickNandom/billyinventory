import 'package:cloud_firestore/cloud_firestore.dart';

class Sales {
  final String saleId;
  final int totalItems;
  final String quantitySold;
  final double totalPrice;
  final String empId;
  final String empName;
  final DateTime salesDate;

  Sales({
    required this.saleId,
    required this.totalItems,
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
      totalItems: snapshot["totalItems"],
      quantitySold: snapshot["quantitySold"],
      totalPrice: snapshot["totalPrice"],
      empId: snapshot["empId"],
      empName: snapshot["empName"],
      salesDate: (snapshot["salesDate"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        "saleId": saleId,
        "totalItems": totalItems,
        "quantitySold": quantitySold,
        "totalPrice": totalPrice,
        "empId": empId,
        "empName": empName,
        "salesDate": salesDate,
      };
}
