//appointment class
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String id;
  final String hid;
  final String puid;
  final String duid;
  final DateTime timestamp;
  final String status;

  Appointment(
      {required this.id,
      required this.hid,
      required this.puid,
      required this.duid,
      required this.timestamp,
      required this.status});

  //copywith method
  Appointment copyWith({
    String? id,
    String? hid,
    String? puid,
    String? duid,
    DateTime? timestamp,
    String? status,
  }) {
    return Appointment(
      id: id ?? this.id,
      hid: hid ?? this.hid,
      puid: puid ?? this.puid,
      duid: duid ?? this.duid,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
    );
  }

  //fromjson method
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      hid: json['hid'],
      puid: json['puid'],
      duid: json['duid'],
      timestamp: json['timestamp'],
      status: json['status'],
    );
  }

  //map method
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hid': hid,
      'puid': puid,
      'duid': duid,
      'timestamp': timestamp,
      'status': status,
    };
  }

  //tojson method
  String toJson() => json.encode(toMap());

  //tostring method
  @override
  String toString() {
    return 'Appointment(id: $id, hid: $hid, puid: $puid, duid: $duid, timestamp: $timestamp, status: $status)';
  }

  //equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Appointment &&
        other.id == id &&
        other.hid == hid &&
        other.puid == puid &&
        other.duid == duid &&
        other.timestamp == timestamp &&
        other.status == status;
  }

  //fromfirestore method
  factory Appointment.fromFirestore(Map<String, dynamic> firestore) {
    return Appointment(
      id: firestore['id'],
      hid: firestore['hid'],
      puid: firestore['puid'],
      duid: firestore['duid'],
      timestamp: firestore['timestamp'],
      status: firestore['status'],
    );
  }

  //tofirestore method
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'hid': hid,
      'puid': puid,
      'duid': duid,
      'timestamp': timestamp,
      'status': status,
    };
  }

  //get appointment date
  String getAppointmentDate() {
    return timestamp.toLocal().toString().split(' ')[0];
  }

  //get appointment time
  String getAppointmentTime() {
    return timestamp.toLocal().toString().split(' ')[1];
  }

  //add appointment to firestore
  Future<void> addAppointmentToFirestore() async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(id)
          .set(toFirestore());
    } catch (e) {
      print(e);
    }
  }

  //delete appointment from firestore
  Future<void> deleteAppointmentFromFirestore() async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(id)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  //update appointment in firestore
  Future<void> updateAppointmentInFirestore() async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(id)
          .update(toFirestore());
    } catch (e) {
      print(e);
    }
  }
}

//fetch appointments method
Future<List<Appointment>> fetchAppointments() async {
  var result =
      await FirebaseFirestore.instance.collection('appointments').get();
  List<Appointment> appointments = [];
  for (var doc in result.docs) {
    var data = doc.data();
    appointments.add(Appointment.fromFirestore(data));
  }
  return appointments;
}

//fetch patient appointments method
Future<List<Appointment>> fetchPatientAppointments(String patientId) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('puid', isEqualTo: patientId)
      .get();
  List<Appointment> appointments = [];
  for (var doc in result.docs) {
    var data = doc.data();
    appointments.add(Appointment.fromFirestore(data));
  }
  return appointments;
}

//fetch doctor appointments method
Future<List<Appointment>> fetchDoctorAppointments(String doctorId) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('duid', isEqualTo: doctorId)
      .get();
  List<Appointment> appointments = [];
  for (var doc in result.docs) {
    var data = doc.data();
    appointments.add(Appointment.fromFirestore(data));
  }
  return appointments;
}

//fetch appointment method
Future<Appointment> fetchAppointment(String hid) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .doc(hid)
      .get();
  var data = result.data();
  return Appointment.fromFirestore(data!);
}

//add appointment method
Future<void> addAppointment(Appointment appointment) async {
  await FirebaseFirestore.instance
      .collection('appointments')
      .doc(appointment.hid)
      .set(appointment.toMap());
}

//update appointment method
Future<void> updateAppointment(Appointment appointment) async {
  await FirebaseFirestore.instance
      .collection('appointments')
      .doc(appointment.hid)
      .update(appointment.toMap());
}

//delete appointment method
Future<void> deleteAppointment(String hid) async {
  await FirebaseFirestore.instance.collection('appointments').doc(hid).delete();
}

//delete patient appointments method
Future<void> deletePatientAppointments(String patientId) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('puid', isEqualTo: patientId)
      .get();
  for (var doc in result.docs) {
    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(doc.id)
        .delete();
  }
}

//delete doctor appointments method
Future<void> deleteDoctorAppointments(String doctorId) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('duid', isEqualTo: doctorId)
      .get();
  for (var doc in result.docs) {
    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(doc.id)
        .delete();
  }
}

//delete all appointments method
Future<void> deleteAllAppointments() async {
  var result =
      await FirebaseFirestore.instance.collection('appointments').get();
  for (var doc in result.docs) {
    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(doc.id)
        .delete();
  }
}

//get appointment count method
Future<int> getAppointmentCount() async {
  var result =
      await FirebaseFirestore.instance.collection('appointments').get();
  return result.docs.length;
}

//get patient appointment count method
Future<int> getPatientAppointmentCount(String patientId) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('puid', isEqualTo: patientId)
      .get();
  return result.docs.length;
}

//get doctor appointment count method
Future<int> getDoctorAppointmentCount(String doctorId) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('duid', isEqualTo: doctorId)
      .get();
  return result.docs.length;
}

//get appointment count by status method
Future<int> getAppointmentCountByStatus(String status) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('status', isEqualTo: status)
      .get();
  return result.docs.length;
}

//get patient appointment count by status method
Future<int> getPatientAppointmentCountByStatus(
    String patientId, String status) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('puid', isEqualTo: patientId)
      .where('status', isEqualTo: status)
      .get();
  return result.docs.length;
}

//get doctor appointment count by status method
Future<int> getDoctorAppointmentCountByStatus(
    String doctorId, String status) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('duid', isEqualTo: doctorId)
      .where('status', isEqualTo: status)
      .get();
  return result.docs.length;
}

//get appointment count by date method
Future<int> getAppointmentCountByDate(String date) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('date', isEqualTo: date)
      .get();
  return result.docs.length;
}

//get patient appointment count by date method
Future<int> getPatientAppointmentCountByDate(
    String patientId, String date) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('puid', isEqualTo: patientId)
      .where('date', isEqualTo: date)
      .get();
  return result.docs.length;
}

//get doctor appointment count by date method
Future<int> getDoctorAppointmentCountByDate(
    String doctorId, String date) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('duid', isEqualTo: doctorId)
      .where('date', isEqualTo: date)
      .get();
  return result.docs.length;
}

//get patient appointments between a date range
Future<List<Appointment>> getPatientAppointmentsBetweenDateRange(
    String patientId, DateTime startDate, DateTime endDate) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('puid', isEqualTo: patientId)
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .get();
  List<Appointment> appointments = [];
  for (var doc in result.docs) {
    var data = doc.data();
    appointments.add(Appointment.fromFirestore(data));
  }
  return appointments;
}

//get doctor appointments between a date range
Future<List<Appointment>> getDoctorAppointmentsBetweenDateRange(
    String doctorId, DateTime startDate, DateTime endDate) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('duid', isEqualTo: doctorId)
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .get();
  List<Appointment> appointments = [];
  for (var doc in result.docs) {
    var data = doc.data();
    appointments.add(Appointment.fromFirestore(data));
  }
  return appointments;
}

//get latest patient appointments
Future<List<Appointment>> getLatestPatientAppointments(
    String patientId, int limit) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('puid', isEqualTo: patientId)
      .orderBy('date', descending: true)
      .limit(limit)
      .get();
  List<Appointment> appointments = [];
  for (var doc in result.docs) {
    var data = doc.data();
    appointments.add(Appointment.fromFirestore(data));
  }
  return appointments;
}

//get latest doctor appointments
Future<List<Appointment>> getLatestDoctorAppointments(
    String doctorId, int limit) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('duid', isEqualTo: doctorId)
      .orderBy('date', descending: true)
      .limit(limit)
      .get();
  List<Appointment> appointments = [];
  for (var doc in result.docs) {
    var data = doc.data();
    appointments.add(Appointment.fromFirestore(data));
  }
  return appointments;
}

//get appointment count by date and status method
Future<int> getAppointmentCountByDateAndStatus(
    String date, String status) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('date', isEqualTo: date)
      .where('status', isEqualTo: status)
      .get();
  return result.docs.length;
}

//get patient appointment count by date and status method
Future<int> getPatientAppointmentCountByDateAndStatus(
    String patientId, String date, String status) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('puid', isEqualTo: patientId)
      .where('date', isEqualTo: date)
      .where('status', isEqualTo: status)
      .get();
  return result.docs.length;
}

//get doctor appointment count by date and status method
Future<int> getDoctorAppointmentCountByDateAndStatus(
    String doctorId, String date, String status) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('duid', isEqualTo: doctorId)
      .where('date', isEqualTo: date)
      .where('status', isEqualTo: status)
      .get();
  return result.docs.length;
}

//get appointment count by date range method
Future<int> getAppointmentCountByDateRange(
    String startDate, String endDate) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .get();
  return result.docs.length;
}

//get patient appointment count by date range method
Future<int> getPatientAppointmentCountByDateRange(
    String patientId, String startDate, String endDate) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('puid', isEqualTo: patientId)
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .get();
  return result.docs.length;
}

//get doctor appointment count by date range method
Future<int> getDoctorAppointmentCountByDateRange(
    String doctorId, String startDate, String endDate) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('duid', isEqualTo: doctorId)
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .get();
  return result.docs.length;
}

//get appointment count by date range and status method
Future<int> getAppointmentCountByDateRangeAndStatus(
    String startDate, String endDate, String status) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .where('status', isEqualTo: status)
      .get();
  return result.docs.length;
}

//get patient appointment count by date range and status method
Future<int> getPatientAppointmentCountByDateRangeAndStatus(
    String patientId, String startDate, String endDate, String status) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('puid', isEqualTo: patientId)
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .where('status', isEqualTo: status)
      .get();
  return result.docs.length;
}

//get doctor appointment count by date range and status method
Future<int> getDoctorAppointmentCountByDateRangeAndStatus(
    String doctorId, String startDate, String endDate, String status) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('duid', isEqualTo: doctorId)
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .where('status', isEqualTo: status)
      .get();
  return result.docs.length;
}

//get appointment count by date range and doctor method
Future<int> getAppointmentCountByDateRangeAndDoctor(
    String startDate, String endDate, String doctorId) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .where('duid', isEqualTo: doctorId)
      .get();
  return result.docs.length;
}

//get appointment count by date range and doctor and status method
Future<int> getAppointmentCountByDateRangeAndDoctorAndStatus(
    String startDate, String endDate, String doctorId, String status) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .where('duid', isEqualTo: doctorId)
      .where('status', isEqualTo: status)
      .get();
  return result.docs.length;
}

//get appointment count by date range and patient method
Future<int> getAppointmentCountByDateRangeAndPatient(
    String startDate, String endDate, String patientId) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .where('puid', isEqualTo: patientId)
      .get();
  return result.docs.length;
}

//get appointment count by date range and patient and status method
Future<int> getAppointmentCountByDateRangeAndPatientAndStatus(
    String startDate, String endDate, String patientId, String status) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .where('puid', isEqualTo: patientId)
      .where('status', isEqualTo: status)
      .get();
  return result.docs.length;
}

//get appointment count by date range and doctor and patient method
Future<int> getAppointmentCountByDateRangeAndDoctorAndPatient(
    String startDate, String endDate, String doctorId, String patientId) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .where('duid', isEqualTo: doctorId)
      .where('puid', isEqualTo: patientId)
      .get();
  return result.docs.length;
}

//get appointment count by date range and doctor and patient and status method
Future<int> getAppointmentCountByDateRangeAndDoctorAndPatientAndStatus(
    String startDate,
    String endDate,
    String doctorId,
    String patientId,
    String status) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .where('duid', isEqualTo: doctorId)
      .where('puid', isEqualTo: patientId)
      .where('status', isEqualTo: status)
      .get();
  return result.docs.length;
}

//get appointment count by date range and doctor and patient method
Future<int> getAppointmentCountByDateRangeAndDoctorAndPatientAndStatusAndType(
    String startDate,
    String endDate,
    String doctorId,
    String patientId,
    String status,
    String type) async {
  var result = await FirebaseFirestore.instance
      .collection('appointments')
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .where('duid', isEqualTo: doctorId)
      .where('puid', isEqualTo: patientId)
      .where('status', isEqualTo: status)
      .where('type', isEqualTo: type)
      .get();
  return result.docs.length;
}
