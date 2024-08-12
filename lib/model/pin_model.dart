import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sailing_chefs/model/reviews.dart';

class PinnedLocation {
  String? id;
  final String contactNumber;
  final Timestamp createdTime;
  final String description;
  final String email;
  final String link;
  final GeoPoint location;
  final String name;
  final List<String> picture;
  final List<String> tags;
  final double rating;
  final String place;
  final String? uid;
  List<Placemark>? placemarks;
  List<ReviewsModel>? reviews = [];

  PinnedLocation({
    this.id,
    this.uid,
    this.placemarks,
    required this.contactNumber,
    this.reviews,
    required this.place,
    required this.rating,
    required this.createdTime,
    required this.description,
    required this.email,
    required this.link,
    required this.location,
    required this.name,
    required this.picture,
    required this.tags,
  });

  factory PinnedLocation.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return PinnedLocation(
      id: snapshot.id,
      uid: data['uid'] ?? '',
      place: data['place'] ?? '',
      contactNumber: data['contact_number'] ?? '',
      createdTime: data['created_time'] ?? Timestamp.now(),
      description: data['description'] ?? '',
      email: data['email'] ?? '',
      link: data['link'] ?? '',
      location: data['location'] ?? const GeoPoint(0.0, 0.0),
      name: data['name'] ?? '',
      picture: List<String>.from(data['picture'] ?? []),
      tags: List<String>.from(data['tags'] ?? []),
      rating: (data['ratings'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    final geoHash = GeoHasher().encode(location.longitude, location.latitude);
    return {
      'contact_number': contactNumber,
      'id': id,
      'uid': uid,
      'created_time': createdTime,
      'description': description,
      'place': place,
      'email': email,
      'link': link,
      'location': location,
      'geo': {'geopoint': location, 'geohash': geoHash},
      'name': name,
      'picture': picture,
      'tags': tags,
      'ratings': rating,
      'geohash': geoHash,
    };
  }

  static PinnedLocation fromMap(Map<String, dynamic> map) {
    return PinnedLocation(
        place: map['place'] ?? '',
        id: map['id'],
        uid: map['uid'],
        location: map['location'] ?? const GeoPoint(0.0, 0.0),
        contactNumber: map['contact_number'],
        rating: map['ratings'],
        createdTime: map['created_time'],
        description: map['description'],
        email: map['email'],
        tags: map['tags'],
        picture: map['picture'],
        name: map['name'],
        reviews: map['reviews'] ?? [],
        link: map['link']);
  }
}
