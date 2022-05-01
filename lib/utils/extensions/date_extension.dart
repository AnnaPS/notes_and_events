import 'package:cloud_firestore/cloud_firestore.dart';

extension DateTimeToTimeStamp on DateTime {
  Timestamp toTimeStamp() {
    return Timestamp.fromDate(this); //To TimeStamp
  }
}
