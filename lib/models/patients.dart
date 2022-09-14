//patient class
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

}