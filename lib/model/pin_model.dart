import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';

class PinnedLocation {
  final String? id;
  final String contactNumber;
  final Timestamp createdTime;
  final String description;
  final String email;
  final String link;
  final GeoPoint location;
  final String name;
  final String picture;
  final List<String> tags;
  final double rating;

  PinnedLocation({
    this.id,
    required this.contactNumber,
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
      contactNumber: data['contact_number'] ?? '',
      createdTime: data['created_time'] ?? Timestamp.now(),
      description: data['description'] ?? '',
      email: data['email'] ?? '',
      link: data['link'] ?? '',
      location: data['location'] ?? const GeoPoint(0.0, 0.0),
      name: data['name'] ?? '',
      picture: data['picture'] ?? '',
      tags: List<String>.from(data['tags'] ?? []),
      rating: (data['ratings'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    final geoHash = GeoHasher().encode(location.longitude, location.latitude);
    return {
      'contact_number': contactNumber,
      'created_time': createdTime,
      'description': description,
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
        location: map['location'] ?? const GeoPoint(0.0, 0.0),
        contactNumber: map['contact_number'],
        rating: map['ratings'],
        createdTime: map['created_time'],
        description: map['description'],
        email: map['email'],
        tags: map['tags'],
        picture: map['picture'],
        name: map['name'],
        link: map['link']);
  }
}
