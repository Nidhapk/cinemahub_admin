import 'package:cloud_firestore/cloud_firestore.dart';

class MovieReview {
  String userId;
  String userName;
  int rating;
  String comment;
  DateTime dateTime;

  MovieReview({
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.dateTime,
  });

  // Convert a Review object to a map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'dateTime': dateTime,
    };
  }

   factory MovieReview.fromJson(Map<String, dynamic> json) {
    return MovieReview(
      userId: json['userId'],
      userName: json['userName'],
      rating: json['rating'],
      comment: json['comment'],
      dateTime: (json['dateTime'] as Timestamp).toDate(),
    );
  }
}
