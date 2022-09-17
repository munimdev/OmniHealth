//test results class
import 'package:cloud_firestore/cloud_firestore.dart';

class TestResults {
  final String testId;
  final String puid;
  final String duid;
  final String testType;
  final String testDate;
  final String testResult;

  TestResults(
      {required this.testId,
      required this.puid,
      required this.duid,
      required this.testType,
      required this.testDate,
      required this.testResult});

  factory TestResults.fromJson(Map<String, dynamic> json) {
    return TestResults(
        testId: json['testId'],
        puid: json['puid'],
        duid: json['duid'],
        testType: json['testType'],
        testDate: json['testDate'],
        testResult: json['testResult']);
  }

  //to map
  Map<String, dynamic> toMap() {
    return {
      'testId': testId,
      'puid': puid,
      'duid': duid,
      'testType': testType,
      'testDate': testDate,
      'testResult': testResult,
    };
  }

  //get patient test results from firestore
  static Future<List<TestResults>> getPatientTestResults(String puid) async {
    List<TestResults> testResults = [];
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('results')
          .where('puid', isEqualTo: puid)
          .get();
      final List<QueryDocumentSnapshot> documents = result.docs;
      for (var document in documents) {
        testResults
            .add(TestResults.fromJson(document.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print(e.toString());
    }
    return testResults;
  }

  //get doctor test results from firestore
  static Future<List<TestResults>> getDoctorTestResults(String duid) async {
    List<TestResults> testResults = [];
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('results')
          .where('duid', isEqualTo: duid)
          .get();
      final List<QueryDocumentSnapshot> documents = result.docs;
      for (var document in documents) {
        testResults
            .add(TestResults.fromJson(document.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print(e.toString());
    }
    return testResults;
  }

  //get latest patient test results from firestore
  static Future<List<TestResults>> getLatestPatientTestResults(
      String puid, int limit) async {
    List<TestResults> testResults = [];
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('results')
          .where('puid', isEqualTo: puid)
          .orderBy('testDate', descending: true)
          .limit(limit)
          .get();
      final List<QueryDocumentSnapshot> documents = result.docs;
      for (var document in documents) {
        testResults
            .add(TestResults.fromJson(document.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print(e.toString());
    }
    return testResults;
  }

  //get latest doctor test results from firestore
  static Future<List<TestResults>> getLatestDoctorTestResults(
      String duid, int limit) async {
    List<TestResults> testResults = [];
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('results')
          .where('duid', isEqualTo: duid)
          .orderBy('testDate', descending: true)
          .limit(limit)
          .get();
      final List<QueryDocumentSnapshot> documents = result.docs;
      for (var document in documents) {
        testResults
            .add(TestResults.fromJson(document.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print(e.toString());
    }
    return testResults;
  }

  //get patient test results by test type from firestore
  static Future<List<TestResults>> getPatientTestResultsByTestType(
      String puid, DateTime testType) async {
    List<TestResults> testResults = [];
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('results')
          .where('puid', isEqualTo: puid)
          .where('testType', isEqualTo: testType)
          .get();
      final List<QueryDocumentSnapshot> documents = result.docs;
      for (var document in documents) {
        testResults
            .add(TestResults.fromJson(document.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print(e.toString());
    }
    return testResults;
  }

  //get patient test results between dates from firestore
  static Future<List<TestResults>> getPatientTestResultsBetweenDates(
      String puid, DateTime startDate, DateTime endDate) async {
    List<TestResults> testResults = [];
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('results')
          .where('puid', isEqualTo: puid)
          .where('testDate', isGreaterThanOrEqualTo: startDate)
          .where('testDate', isLessThanOrEqualTo: endDate)
          .get();
      final List<QueryDocumentSnapshot> documents = result.docs;
      for (var document in documents) {
        testResults
            .add(TestResults.fromJson(document.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print(e.toString());
    }
    return testResults;
  }

  //get patient test results after date from firestore
  static Future<List<TestResults>> getPatientTestResultsAfterDate(
      String puid, DateTime startDate) async {
    List<TestResults> testResults = [];
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('results')
          .where('puid', isEqualTo: puid)
          .where('testDate', isGreaterThanOrEqualTo: startDate)
          .get();
      final List<QueryDocumentSnapshot> documents = result.docs;
      for (var document in documents) {
        testResults
            .add(TestResults.fromJson(document.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print(e.toString());
    }
    return testResults;
  }

  //get patient test results after date from firestore
  static Future<List<TestResults>> getPatientTestResultsBeforeDate(
      String puid, DateTime endDate) async {
    List<TestResults> testResults = [];
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('results')
          .where('puid', isEqualTo: puid)
          .where('testDate', isLessThanOrEqualTo: endDate)
          .get();
      final List<QueryDocumentSnapshot> documents = result.docs;
      for (var document in documents) {
        testResults
            .add(TestResults.fromJson(document.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print(e.toString());
    }
    return testResults;
  }
}
