import 'package:cloud_firestore/cloud_firestore.dart';


Future<bool> fetchPaymentState() async {
  try {
    // Access the document 'var0001' in the collection 'variables'
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('variables')
        .doc('var0001')
        .get();

    // Check if the document exists
    if (documentSnapshot.exists) {
      // Get the 'canPayment' field value
      bool canPaymentValue = documentSnapshot.get('canPayment');

      return  canPaymentValue;

    } else {
      print("Document does not exist.");
      return false;
    }
  } catch (e) {
    print("Error fetching document: $e");
    return false;
  }
}