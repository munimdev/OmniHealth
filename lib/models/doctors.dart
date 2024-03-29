// doctor class
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:omnihealth/models/review.dart';

class Doctor {
  final String uid;
  final String hospitalUid;
  final String fname;
  final String lname;
  final String? phone;
  final String? email;
  final String speciality;
  final List<String> address;
  final String experience;
  final String hourlyFee;

  Doctor(
      {required this.uid,
      required this.hospitalUid,
      required this.fname,
      required this.lname,
      this.phone,
      this.email,
      required this.speciality,
      required this.address,
      required this.experience,
      required this.hourlyFee});

  //copywith method
  Doctor copyWith(
      {String? uid,
      String? fname,
      String? lname,
      String? phone,
      String? email,
      String? speciality,
      List<String>? address,
      String? experience,
      String? hourlyFee}) {
    return Doctor(
        uid: uid ?? this.uid,
        hospitalUid: hospitalUid,
        fname: fname ?? this.fname,
        lname: lname ?? this.lname,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        speciality: speciality ?? this.speciality,
        address: address ?? this.address,
        experience: experience ?? this.experience,
        hourlyFee: hourlyFee ?? this.hourlyFee);
  }

  //calculate experience
  int calculateExperience() {
    return DateTime.now().year - int.parse(experience);
  }

  //calculate hourly fee
  int calculateHourlyFee() {
    return int.parse(hourlyFee);
  }

  //calculate total fee
  int calculateTotalFee(int duration) {
    return int.parse(hourlyFee) * duration;
  }

  //calculate total fee
  int calculateTotalFeeWithDiscount(int duration, double discount) {
    return (int.parse(hourlyFee) * duration) -
        ((int.parse(hourlyFee) * duration) * discount).toInt();
  }

  //get doctor full name
  String getFullName() {
    return "$fname $lname";
  }

  //get doctor full name
  String getFullNameWithSpeciality() {
    return "$fname $lname - $speciality";
  }

  //get doctor full name
  String getFullNameWithSpecialityAndExperience() {
    return "$fname $lname - $speciality (${calculateExperience()} years experience)";
  }

  //get doctor full name
  String getFullNameWithSpecialityAndExperienceAndHourlyFee() {
    return "$fname $lname - $speciality (${calculateExperience()} years experience) - $hourlyFee PKR/hour";
  }

  //get doctor full name
  String getFullNameWithSpecialityAndExperienceAndHourlyFeeAndAddress() {
    return "$fname $lname - $speciality (${calculateExperience()} years experience) - $hourlyFee PKR/hour - ${address[0]}, ${address[1]}, ${address[2]}";
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

  //get email
  String getEmail() {
    return email ?? 'N/A';
  }

  //get phone
  String getPhone() {
    return phone ?? 'N/A';
  }

  //get speciality
  String getSpeciality() {
    return speciality;
  }

  //get hourly fee
  String getHourlyFee() {
    return hourlyFee;
  }

  //convert doctor to map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fname': fname,
      'lname': lname,
      'phone': phone,
      'email': email,
      'speciality': speciality,
      'address': address,
      'experience': experience,
      'hourlyFee': hourlyFee
    };
  }

  //convert map to doctor
  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
        uid: map['uid'],
        hospitalUid: map['hospitalUid'],
        fname: map['fname'],
        lname: map['lname'],
        phone: map['phone'],
        email: map['email'],
        speciality: map['speciality'],
        address: List<String>.from(map['address']),
        experience: map['experience'],
        hourlyFee: map['hourlyFee']);
  }

  //convert doctor to json
  String toJson() => json.encode(toMap());

  //convert json to doctor
  factory Doctor.fromJson(String source) => Doctor.fromMap(json.decode(source));

  //convert doctor to firestore document
  factory Doctor.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Doctor(
        uid: doc.id,
        hospitalUid: data['hospitalUid'],
        fname: data['fname'],
        lname: data['lname'],
        phone: data['phone'],
        email: data['email'],
        speciality: data['speciality'],
        address: List<String>.from(data['address']),
        experience: data['experience'],
        hourlyFee: data['hourlyFee']);
  }

  //add doctor to firestore
  Future<void> addDoctor() async {
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(uid)
        .set(toMap());
  }

  //update doctor in firestore
  Future<void> updateDoctor() async {
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(uid)
        .update(toMap());
  }

  //delete doctor from firestore
  Future<void> deleteDoctor() async {
    await FirebaseFirestore.instance.collection('doctors').doc(uid).delete();
  }

  //check if doctor exists in firestore
  Future<bool> exists() async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('doctors').doc(uid).get();
    return doc.exists;
  }

  //update doctor if not exists
  Future<void> updateIfNotExists() async {
    if (!(await exists())) {
      await addDoctor();
    }
  }
}

//get doctor from firestore
Future<Doctor> getDoctor(String uid) async {
  DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('doctors').doc(uid).get();
  return Doctor.fromFirestore(doc);
}

//get all doctors with speciality
Future<List<Doctor>> getDoctorsWithSpeciality(String speciality) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('doctors')
      .where('speciality', isEqualTo: speciality)
      .get();
  List<Doctor> doctors = [];
  for (DocumentSnapshot doc in querySnapshot.docs) {
    doctors.add(Doctor.fromFirestore(doc));
  }
  return doctors;
}

//get all doctors
Future<List<Doctor>> getAllDoctors() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('doctors').get();
  List<Doctor> doctors = [];
  for (DocumentSnapshot doc in querySnapshot.docs) {
    doctors.add(Doctor.fromFirestore(doc));
  }
  return doctors;
}

//get all doctors under a hospital
Future<List<Doctor>> getAllDoctorsUnderHospital(String hospitalUid) async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance
      .collection('doctors')
      .where('hospitalUid', isEqualTo: hospitalUid)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      doctors.add(Doctor.fromMap(doc.data() as Map<String, dynamic>));
    }
  });
  return doctors;
}

//get all doctors under a hospital with speciality
Future<List<Doctor>> getAllDoctorsUnderHospitalWithSpeciality(
    String hospitalUid, String speciality) async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance
      .collection('doctors')
      .where('hospitalUid', isEqualTo: hospitalUid)
      .where('speciality', isEqualTo: speciality)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      doctors.add(Doctor.fromMap(doc.data() as Map<String, dynamic>));
    }
  });
  return doctors;
}

//get doctors that have fee below a certain amount
Future<List<Doctor>> getAllDoctorsWithFeeLessThan(int amount) async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance
      .collection('doctors')
      .where('hourlyFee', isLessThan: amount)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      doctors.add(Doctor.fromMap(doc.data() as Map<String, dynamic>));
    }
  });
  return doctors;
}

//get doctors that have fee above a certain amount
Future<List<Doctor>> getAllDoctorsWithFeeGreaterThan(int amount) async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance
      .collection('doctors')
      .where('hourlyFee', isGreaterThan: amount)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      doctors.add(Doctor.fromMap(doc.data() as Map<String, dynamic>));
    }
  });
  return doctors;
}

//get all doctors
Future<List<Doctor>> getAllDoctorsWithFeeBetween(int min, int max) async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance
      .collection('doctors')
      .where('hourlyFee', isGreaterThanOrEqualTo: min)
      .where('hourlyFee', isLessThanOrEqualTo: max)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      doctors.add(Doctor.fromMap(doc.data() as Map<String, dynamic>));
    }
  });
  return doctors;
}

//get list of all doctors with speciality and fee less than
Future<List<Doctor>> getAllDoctorsWithSpecialityAndFeeLessThan(
    String speciality, int amount) async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance
      .collection('doctors')
      .where('speciality', isEqualTo: speciality)
      .where('hourlyFee', isLessThan: amount)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      doctors.add(Doctor.fromMap(doc.data() as Map<String, dynamic>));
    }
  });
  return doctors;
}

//get list of all doctors with speciality and fee greater than
Future<List<Doctor>> getAllDoctorsWithSpecialityAndFeeGreaterThan(
    String speciality, int amount) async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance
      .collection('doctors')
      .where('speciality', isEqualTo: speciality)
      .where('hourlyFee', isGreaterThan: amount)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      doctors.add(Doctor.fromMap(doc.data() as Map<String, dynamic>));
    }
  });
  return doctors;
}

//get list of all doctors with speciality and fee in range
Future<List<Doctor>> getAllDoctorsWithSpecialityAndFeeBetween(
    String speciality, int min, int max) async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance
      .collection('doctors')
      .where('speciality', isEqualTo: speciality)
      .where('hourlyFee', isGreaterThanOrEqualTo: min)
      .where('hourlyFee', isLessThanOrEqualTo: max)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      doctors.add(Doctor.fromMap(doc.data() as Map<String, dynamic>));
    }
  });
  return doctors;
}

//get list of all doctors with speciality and fee in range
Future<List<Doctor>> getAllDoctorsWithFeeLessThanAndSpecialityBetween(
    int amount, String minSpeciality, String maxSpeciality) async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance
      .collection('doctors')
      .where('hourlyFee', isLessThan: amount)
      .where('speciality', isGreaterThanOrEqualTo: minSpeciality)
      .where('speciality', isLessThanOrEqualTo: maxSpeciality)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      doctors.add(Doctor.fromMap(doc.data() as Map<String, dynamic>));
    }
  });
  return doctors;
}

//get list of all doctors with speciality and fee in range
Future<List<Doctor>> getAllDoctorsWithFeeGreaterThanAndSpecialityBetween(
    int amount, String minSpeciality, String maxSpeciality) async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance
      .collection('doctors')
      .where('hourlyFee', isGreaterThan: amount)
      .where('speciality', isGreaterThanOrEqualTo: minSpeciality)
      .where('speciality', isLessThanOrEqualTo: maxSpeciality)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      doctors.add(Doctor.fromMap(doc.data() as Map<String, dynamic>));
    }
  });
  return doctors;
}

//get all doctors of a city
Future<List<Doctor>> getAllDoctorsOfCity(String city) async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance
      .collection('doctors')
      .where('city', isEqualTo: city)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      doctors.add(Doctor.fromMap(doc.data() as Map<String, dynamic>));
    }
  });
  return doctors;
}

//get all doctors of a city with fee less than
Future<List<Doctor>> getAllDoctorsOfCityWithFeeLessThan(
    String city, int amount) async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance
      .collection('doctors')
      .where('city', isEqualTo: city)
      .where('hourlyFee', isLessThan: amount)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      doctors.add(Doctor.fromMap(doc.data() as Map<String, dynamic>));
    }
  });
  return doctors;
}

//get all doctors of a city with fee greater than
Future<List<Doctor>> getAllDoctorsOfCityWithFeeGreaterThan(
    String city, int amount) async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance
      .collection('doctors')
      .where('city', isEqualTo: city)
      .where('hourlyFee', isGreaterThan: amount)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      doctors.add(Doctor.fromMap(doc.data() as Map<String, dynamic>));
    }
  });
  return doctors;
}

//get all doctors of a city with fee in range
Future<List<Doctor>> getAllDoctorsOfCityWithFeeBetween(
    String city, int min, int max) async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance
      .collection('doctors')
      .where('city', isEqualTo: city)
      .where('hourlyFee', isGreaterThanOrEqualTo: min)
      .where('hourlyFee', isLessThanOrEqualTo: max)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      doctors.add(Doctor.fromMap(doc.data() as Map<String, dynamic>));
    }
  });
  return doctors;
}

//   //get doctor reviews
//   Future<List<Review>> getDoctorReviews(String doctorId) async {
//     List<Review> reviews = [];
//     await FirebaseFirestore.instance
//         .collection('doctors')
//         .doc(doctorId)
//         .collection('reviews')
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       for (var doc in querySnapshot.docs) {
//         reviews.add(Review.fromMap(doc.data() as Map<String, dynamic>));
//       }
//     });
//     return reviews;
//   }
