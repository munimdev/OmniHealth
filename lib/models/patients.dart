//patient class
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Patient {
  String uid;
  String fname;
  String lname;
  String? email;
  String? phone;
  String city;
  String cnic;
  List<String> address;
  List<int> dob;

  Patient({
    required this.uid,
    required this.fname,
    required this.lname,
    this.email,
    this.phone,
    required this.city,
    required this.cnic,
    required this.address,
    required this.dob,
  });

  //copywith method
  Patient copyWith({
    String? uid,
    String? fname,
    String? lname,
    String? email,
    String? phone,
    String? city,
    String? cnic,
    List<String>? address,
    List<int>? dob,
  }) {
    return Patient(
      uid: uid ?? this.uid,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      cnic: cnic ?? this.cnic,
      address: address ?? this.address,
      dob: dob ?? this.dob,
    );
  }

  //calculate age by combing 'dob' list
  int calculateAge() {
    int age = DateTime.now().year - dob[2];
    if (DateTime.now().month < dob[1]) {
      age--;
    } else if (DateTime.now().month == dob[1]) {
      if (DateTime.now().day < dob[0]) {
        age--;
      }
    }
    return age;
  }

  //convert 'dob' list to string
  String getDob() {
    return '${dob[0]}/${dob[1]}/${dob[2]}';
  }

  //convert 'address' list to string
  String getAddress() {
    String addressString = '';
    for (int i = 0; i < address.length; i++) {
      addressString += address[i];
      if (i != address.length - 1) {
        addressString += ', ';
      }
    }
    return addressString;
  }

  //get full name
  String getFullName() {
    return '$fname $lname';
  }

  //get initials
  String getInitials() {
    return '${fname[0]}${lname[0]}';
  }

  //get phone number
  String getPhone() {
    return phone ?? 'N/A';
  }

  //get email
  String getEmail() {
    return email ?? 'N/A';
  }

  //get cnic
  String getCnic() {
    return cnic;
  }

  //get city
  String getCity() {
    return city;
  }

  //get uid
  String getUid() {
    return uid;
  }

  //convert patient data to map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fname': fname,
      'lname': lname,
      'email': email,
      'phone': phone,
      'city': city,
      'cnic': cnic,
      'address': address,
      'dob': dob,
    };
  }

  //convert map to patient data
  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      uid: map['uid'],
      fname: map['fname'],
      lname: map['lname'],
      email: map['email'],
      phone: map['phone'],
      city: map['city'],
      cnic: map['cnic'],
      address: List<String>.from(map['address']),
      dob: List<int>.from(map['dob']),
    );
  }

  //to firestore
  factory Patient.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Patient(
      uid: data['uid'],
      fname: data['fname'],
      lname: data['lname'],
      email: data['email'],
      phone: data['phone'],
      city: data['city'],
      cnic: data['cnic'],
      address: List<String>.from(data['address']),
      dob: List<int>.from(data['dob']),
    );
  }

  //from firestore
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'fname': fname,
      'lname': lname,
      'email': email,
      'phone': phone,
      'city': city,
      'cnic': cnic,
      'address': address,
      'dob': dob,
    };
  }

  //convert patient data to json
  String toJson() => json.encode(toMap());

  //convert json to patient data
  factory Patient.fromJson(String source) =>
      Patient.fromMap(json.decode(source));

  //fetch patient data from firestore
  Future<Patient> fetchPatientData() async {
    //get patient data from firestore
    DocumentSnapshot<Map<String, dynamic>> patientData =
        await FirebaseFirestore.instance.collection('patients').doc(uid).get();
    //convert patient data to map
    Map<String, dynamic> patientDataMap = patientData.data()!;
    //convert map to patient data
    return Patient.fromMap(patientDataMap);
  }

  //update patient data in firestore
  Future<void> updatePatientData() async {
    //update patient data in firestore
    await FirebaseFirestore.instance
        .collection('patients')
        .doc(uid)
        .update(toMap());
  }

  //add new patient data to firestore
  Future<void> addPatientData() async {
    //add new patient data to firestore
    await FirebaseFirestore.instance
        .collection('patients')
        .doc(uid)
        .set(toMap());
  }

  //delete patient data from firestore
  Future<void> deletePatientData() async {
    //delete patient data from firestore
    await FirebaseFirestore.instance.collection('patients').doc(uid).delete();
  }

  //check if patient exists in firestore
  Future<bool> checkPatientExists() async {
    //get patient data from firestore
    DocumentSnapshot<Map<String, dynamic>> patientData =
        await FirebaseFirestore.instance.collection('patients').doc(uid).get();
    //check if patient exists
    return patientData.exists;
  }

  //check if patient data is valid
  bool isValidPatientData() {
    //check if patient data is valid
    return uid.isNotEmpty &&
        fname.isNotEmpty &&
        lname.isNotEmpty &&
        city.isNotEmpty &&
        cnic.isNotEmpty &&
        address.isNotEmpty &&
        dob.isNotEmpty;
  }

  //check if patient data is valid
  bool isValidPatientDataWithPhone() {
    //check if patient data is valid
    return uid.isNotEmpty &&
        fname.isNotEmpty &&
        lname.isNotEmpty &&
        city.isNotEmpty &&
        cnic.isNotEmpty &&
        address.isNotEmpty &&
        dob.isNotEmpty &&
        phone != null;
  }

  //check if patient data is valid
  bool isValidPatientDataWithEmail() {
    //check if patient data is valid
    return uid.isNotEmpty &&
        fname.isNotEmpty &&
        lname.isNotEmpty &&
        city.isNotEmpty &&
        cnic.isNotEmpty &&
        address.isNotEmpty &&
        dob.isNotEmpty &&
        email != null;
  }

  //get patient by cnic
  Future<Patient?> getPatientByCnic(String cnic) async {
    //get patient data from firestore
    QuerySnapshot<Map<String, dynamic>> patientData = await FirebaseFirestore
        .instance
        .collection('patients')
        .where('cnic', isEqualTo: cnic)
        .get();
    //check if patient exists
    if (patientData.docs.isNotEmpty) {
      //return patient data
      return Patient.fromMap(patientData.docs.first.data());
    } else {
      //return null
      return null;
    }
  }

  //get patient by uid
  Future<Patient?> getPatientByUid(String uid) async {
    //get patient data from firestore
    DocumentSnapshot<Map<String, dynamic>> patientData =
        await FirebaseFirestore.instance.collection('patients').doc(uid).get();
    //check if patient exists
    if (patientData.exists) {
      //return patient data
      return Patient.fromMap(patientData.data()!);
    } else {
      //return null
      return null;
    }
  }

  //get all patients
  Future<List<Patient>> getAllPatients() async {
    //get patient data from firestore
    QuerySnapshot<Map<String, dynamic>> patientData =
        await FirebaseFirestore.instance.collection('patients').get();
    //get patient list
    List<Patient> patientList = [];
    //iterate over patient data
    for (DocumentSnapshot<Map<String, dynamic>> patient in patientData.docs) {
      //add patient data to list
      patientList.add(Patient.fromMap(patient.data() as Map<String, dynamic>));
    }
    //return patient list
    return patientList;
  }

  //get all patients with phone
  Future<List<Patient>> getAllPatientsWithPhone() async {
    //get patient data from firestore
    QuerySnapshot<Map<String, dynamic>> patientData = await FirebaseFirestore
        .instance
        .collection('patients')
        .where('phone', isNotEqualTo: null)
        .get();
    //get patient list
    List<Patient> patientList = [];
    //iterate over patient data
    for (DocumentSnapshot<Map<String, dynamic>> patient in patientData.docs) {
      //add patient data to list
      patientList.add(Patient.fromMap(patient.data() as Map<String, dynamic>));
    }
    //return patient list
    return patientList;
  }

  //get all patients with email
  Future<List<Patient>> getAllPatientsWithEmail() async {
    //get patient data from firestore
    QuerySnapshot<Map<String, dynamic>> patientData = await FirebaseFirestore
        .instance
        .collection('patients')
        .where('email', isNotEqualTo: null)
        .get();
    //get patient list
    List<Patient> patientList = [];
    //iterate over patient data
    for (DocumentSnapshot<Map<String, dynamic>> patient in patientData.docs) {
      //add patient data to list
      patientList.add(Patient.fromMap(patient.data() as Map<String, dynamic>));
    }
    //return patient list
    return patientList;
  }

  //get all patients without phone
  Future<List<Patient>> getAllPatientsWithoutPhone() async {
    //get patient data from firestore
    QuerySnapshot<Map<String, dynamic>> patientData = await FirebaseFirestore
        .instance
        .collection('patients')
        .where('phone', isEqualTo: null)
        .get();
    //get patient list
    List<Patient> patientList = [];
    //iterate over patient data
    for (DocumentSnapshot<Map<String, dynamic>> patient in patientData.docs) {
      //add patient data to list
      patientList.add(Patient.fromMap(patient.data() as Map<String, dynamic>));
    }
    //return patient list
    return patientList;
  }

  //get all patients without email
  Future<List<Patient>> getAllPatientsWithoutEmail() async {
    //get patient data from firestore
    QuerySnapshot<Map<String, dynamic>> patientData = await FirebaseFirestore
        .instance
        .collection('patients')
        .where('email', isEqualTo: null)
        .get();
    //get patient list
    List<Patient> patientList = [];
    //iterate over patient data
    for (DocumentSnapshot<Map<String, dynamic>> patient in patientData.docs) {
      //add patient data to list
      patientList.add(Patient.fromMap(patient.data() as Map<String, dynamic>));
    }
    //return patient list
    return patientList;
  }

  //get all patients with phone and email
  Future<List<Patient>> getAllPatientsWithPhoneAndEmail() async {
    //get patient data from firestore
    QuerySnapshot<Map<String, dynamic>> patientData = await FirebaseFirestore
        .instance
        .collection('patients')
        .where('phone', isNotEqualTo: null)
        .where('email', isNotEqualTo: null)
        .get();
    //get patient list
    List<Patient> patientList = [];
    //iterate over patient data
    for (DocumentSnapshot<Map<String, dynamic>> patient in patientData.docs) {
      //add patient data to list
      patientList.add(Patient.fromMap(patient.data() as Map<String, dynamic>));
    }
    //return patient list
    return patientList;
  }

  //get all patients without phone and email
  Future<List<Patient>> getAllPatientsWithoutPhoneAndEmail() async {
    //get patient data from firestore
    QuerySnapshot<Map<String, dynamic>> patientData = await FirebaseFirestore
        .instance
        .collection('patients')
        .where('phone', isEqualTo: null)
        .where('email', isEqualTo: null)
        .get();
    //get patient list
    List<Patient> patientList = [];
    //iterate over patient data
    for (DocumentSnapshot<Map<String, dynamic>> patient in patientData.docs) {
      //add patient data to list
      patientList.add(Patient.fromMap(patient.data() as Map<String, dynamic>));
    }
    //return patient list
    return patientList;
  }

  //get all patients with phone or email
  Future<List<Patient>> getAllPatientsWithPhoneOrEmail() async {
    //get patient data from firestore
    QuerySnapshot<Map<String, dynamic>> patientData = await FirebaseFirestore
        .instance
        .collection('patients')
        .where('phone', isNotEqualTo: null)
        .where('email', isEqualTo: null)
        .get();
    //get patient list
    List<Patient> patientList = [];
    //iterate over patient data
    for (DocumentSnapshot<Map<String, dynamic>> patient in patientData.docs) {
      //add patient data to list
      patientList.add(Patient.fromMap(patient.data() as Map<String, dynamic>));
    }
    //return patient list
    return patientList;
  }

  //get all patients with phone or email
  Future<List<Patient>> getAllPatientsWithoutPhoneOrEmail() async {
    //get patient data from firestore
    QuerySnapshot<Map<String, dynamic>> patientData = await FirebaseFirestore
        .instance
        .collection('patients')
        .where('phone', isEqualTo: null)
        .where('email', isEqualTo: null)
        .get();
    //get patient list
    List<Patient> patientList = [];
    //iterate over patient data
    for (DocumentSnapshot<Map<String, dynamic>> patient in patientData.docs) {
      //add patient data to list
      patientList.add(Patient.fromMap(patient.data() as Map<String, dynamic>));
    }
    //return patient list
    return patientList;
  }

  //get patient by id
  Future<Patient> getPatientById(String id) async {
    //get patient data from firestore
    DocumentSnapshot<Map<String, dynamic>> patientData =
        await FirebaseFirestore.instance.collection('patients').doc(id).get();
    //return patient
    return Patient.fromMap(patientData.data() as Map<String, dynamic>);
  }

  //get patient by phone number
  Future<Patient> getPatientByPhone(String phone) async {
    //get patient data from firestore
    QuerySnapshot<Map<String, dynamic>> patientData = await FirebaseFirestore
        .instance
        .collection('patients')
        .where('phone', isEqualTo: phone)
        .get();
    //return patient
    return Patient.fromMap(
        patientData.docs.first.data() as Map<String, dynamic>);
  }

  //get patient by email
  Future<Patient> getPatientByEmail(String email) async {
    //get patient data from firestore
    QuerySnapshot<Map<String, dynamic>> patientData = await FirebaseFirestore
        .instance
        .collection('patients')
        .where('email', isEqualTo: email)
        .get();
    //return patient
    return Patient.fromMap(
        patientData.docs.first.data() as Map<String, dynamic>);
  }

  //add patient
  Future<void> addPatient(Patient patient) async {
    //add patient to firestore
    await FirebaseFirestore.instance
        .collection('patients')
        .doc(patient.uid)
        .set(patient.toMap());
  }

  //update patient
  Future<void> updatePatient(Patient patient) async {
    //update patient in firestore
    await FirebaseFirestore.instance
        .collection('patients')
        .doc(patient.uid)
        .update(patient.toMap());
  }

  //delete patient
  Future<void> deletePatient(Patient patient) async {
    //delete patient from firestore
    await FirebaseFirestore.instance
        .collection('patients')
        .doc(patient.uid)
        .delete();
  }
}
