//review class
import 'dart:convert';

class Review {
  final String id;
  final String puid;
  final String duid;
  final String reviewTime;
  final String reviewDate;
  final String reviewContent;
  final String reviewRating;

  Review(this.reviewRating,
      {required this.id,
      required this.puid,
      required this.duid,
      required this.reviewTime,
      required this.reviewDate,
      required this.reviewContent});

  //from map to review
  factory Review.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return Review('',
          id: '',
          puid: '',
          duid: '',
          reviewTime: '',
          reviewDate: '',
          reviewContent: '');
    }
    final String reviewId = documentId;
    final String reviewPatient = data['puid'];
    final String reviewDoctor = data['duid'];
    final String reviewTime = data['reviewTime'];
    final String reviewDate = data['reviewDate'];
    final String reviewContent = data['reviewContent'];
    final String reviewRating = data['reviewRating'];

    return Review(reviewRating,
        id: reviewId,
        puid: reviewPatient,
        duid: reviewDoctor,
        reviewTime: reviewTime,
        reviewDate: reviewDate,
        reviewContent: reviewContent);
  }

  //to map
  Map<String, dynamic> toMap() {
    return {
      'puid': puid,
      'duid': duid,
      'reviewTime': reviewTime,
      'reviewDate': reviewDate,
      'reviewContent': reviewContent,
      'reviewRating': reviewRating,
    };
  }

  //to string
  @override
  String toString() {
    return 'Review{id: $id, puid: $puid, duid: $duid, reviewTime: $reviewTime, reviewDate: $reviewDate, reviewContent: $reviewContent, reviewRating: $reviewRating}';
  }

  //to json
  String toJson() => json.encode(toMap());

  //from json
  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source), '');

  //copy with
  Review copyWith({
    String? id,
    String? puid,
    String? duid,
    String? reviewTime,
    String? reviewDate,
    String? reviewContent,
    String? reviewRating,
  }) {
    return Review(reviewRating ?? this.reviewRating,
        id: id ?? this.id,
        puid: puid ?? this.puid,
        duid: duid ?? this.duid,
        reviewTime: reviewTime ?? this.reviewTime,
        reviewDate: reviewDate ?? this.reviewDate,
        reviewContent: reviewContent ?? this.reviewContent);
  }

  //equals
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Review &&
        other.id == id &&
        other.puid == puid &&
        other.duid == duid &&
        other.reviewTime == reviewTime &&
        other.reviewDate == reviewDate &&
        other.reviewContent == reviewContent &&
        other.reviewRating == reviewRating;
  }

  //hashcode
  @override
  int get hashCode {
    return id.hashCode ^
        puid.hashCode ^
        duid.hashCode ^
        reviewTime.hashCode ^
        reviewDate.hashCode ^
        reviewContent.hashCode ^
        reviewRating.hashCode;
  }

  //to firestore
  Map<String, dynamic> toFirestore() {
    return {
      'puid': puid,
      'duid': duid,
      'reviewTime': reviewTime,
      'reviewDate': reviewDate,
      'reviewContent': reviewContent,
      'reviewRating': reviewRating,
    };
  }

  //from firestore
  factory Review.fromFirestore(Map<String, dynamic> firestore) {
    return Review(firestore['reviewRating'],
        id: firestore['id'],
        puid: firestore['puid'],
        duid: firestore['duid'],
        reviewTime: firestore['reviewTime'],
        reviewDate: firestore['reviewDate'],
        reviewContent: firestore['reviewContent']);
  }
}
