import 'package:cloud_firestore/cloud_firestore.dart';

class PinnedLocation {
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
      contactNumber: data['contact_number'] ?? '',
      createdTime: data['created_time'] ?? Timestamp.now(),
      description: data['description'] ?? '',
      email: data['email'] ?? '',
      link: data['link'] ?? '',
      location: data['location'] ?? const GeoPoint(0.0, 0.0),
      name: data['name'] ?? '',
      picture: data['picture'] ?? '',
      tags: List<String>.from(data['tags'] ?? []), 
      rating: data['ratings'] ?? 0.0,
    );
  }

  // Convert PinnedLocation instance to Map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'contact_number': contactNumber,
      'created_time': createdTime,
      'description': description,
      'email': email,
      'link': link,
      'location': location,
      'name': name,
      'picture': picture,
      'tags': tags,
      'ratings': rating
    };
  }
}
