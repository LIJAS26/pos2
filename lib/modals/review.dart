// @dart=2.9
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String username;
  final String userId;
  final String avatarUrl;
  String review;
  double rating;
  final Timestamp timestamp;

  static Serializer serializer;

  Review(
      {this.username,
        this.userId,
        this.avatarUrl,
        this.review,
        this.rating,
        this.timestamp});

  factory Review.fromMap(Map<String,dynamic> data) {


    return Review(
      username: data['username'],
      userId: data['userId'],
      review: data["review"],
      rating: data["rating"],
      timestamp: data["timestamp"],
      avatarUrl: data["avatarUrl"],
    );
  }




}
