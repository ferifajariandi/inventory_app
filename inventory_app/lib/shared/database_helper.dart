import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseHelper {
  static FirebaseDatabase accessDB() {
    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
        app: firebaseApp,
        databaseURL:
            'https://tugasakhir-585e2-default-rtdb.asia-southeast1.firebasedatabase.app/');
    return rtdb;
  }
}
