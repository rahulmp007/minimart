import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final int? rating;
  final String? comment;
  final DateTime? date;
  final String? reviewerName;
  final String? reviewerEmail;

  const Review({
     this.rating,
     this.comment,
     this.date,
     this.reviewerName,
     this.reviewerEmail,
  });

  @override
  List<Object?> get props => [
    rating,
    comment,
    date,
    reviewerName,
    reviewerEmail,
  ];
}
