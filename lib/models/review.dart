//review class
class Review {
  final String reviewId;
  final String reviewPatient;
  final String reviewDoctor;
  final String reviewTime;
  final String reviewDate;
  final String reviewContent;
  final String reviewRating;

  Review(this.reviewRating,
      {required this.reviewId,
      required this.reviewPatient,
      required this.reviewDoctor,
      required this.reviewTime,
      required this.reviewDate,
      required this.reviewContent});
}
