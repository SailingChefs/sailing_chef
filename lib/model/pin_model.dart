import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sailing_chefs/model/reviews.dart';

enum PinnedLocationStatus {
  pending,
  review,
  published;

  static PinnedLocationStatus fromString(String? s) {
    if (s == null) return PinnedLocationStatus.pending;
    return PinnedLocationStatus.values.firstWhere(
      (e) => e.name == s,
      orElse: () => PinnedLocationStatus.pending,
    );
  }
}

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
  final PinnedLocationStatus status;
  List<Placemark>? placemarks;
  List<ReviewsModel>? reviews = [];

  PinnedLocation({
    required this.contactNumber,
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
    required this.status,
    this.id,
    this.uid,
    this.placemarks,
    this.reviews,
  });

  factory PinnedLocation.fromSnapshot(DocumentSnapshot snapshot) {
    final raw = snapshot.data();
    final data = (raw is Map<String, dynamic>) ? raw : <String, dynamic>{};

    double toDouble(dynamic v) {
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v) ?? 0.0;
      return 0.0;
    }

    List<String> toStringList(dynamic v) {
      if (v is Iterable) {
        return v.map((e) => e.toString()).toList(growable: false);
      }
      return const <String>[];
    }

    return PinnedLocation(
      id: snapshot.id,
      uid: data['uid'] as String?,
      place: (data['place'] as String?) ?? '',
      contactNumber: (data['contact_number'] as String?) ?? '',
      createdTime: (data['created_time'] as Timestamp?) ?? Timestamp.now(),
      description: (data['description'] as String?) ?? '',
      email: (data['email'] as String?) ?? '',
      link: (data['link'] as String?) ?? '',
      location: (data['location'] as GeoPoint?) ?? const GeoPoint(0.0, 0.0),
      name: (data['name'] as String?) ?? '',
      picture: toStringList(data['picture']),
      tags: toStringList(data['tags']),
      rating: toDouble(data['ratings']),
      status: PinnedLocationStatus.fromString(data['status'] as String?),
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
      'status': status.name,
    };
  }

  static PinnedLocation fromMap(Map<String, dynamic> map) {
    double toDouble(dynamic v) {
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v) ?? 0.0;
      return 0.0;
    }

    List<String> toStringList(dynamic v) {
      if (v is Iterable) {
        return v.map((e) => e.toString()).toList(growable: false);
      }
      return const <String>[];
    }

    return PinnedLocation(
      place: (map['place'] as String?) ?? '',
      id: map['id'] as String?,
      uid: map['uid'] as String?,
      location: (map['location'] as GeoPoint?) ?? const GeoPoint(0.0, 0.0),
      contactNumber: (map['contact_number'] as String?) ?? '',
      rating: toDouble(map['ratings']),
      createdTime: (map['created_time'] as Timestamp?) ?? Timestamp.now(),
      description: (map['description'] as String?) ?? '',
      email: (map['email'] as String?) ?? '',
      tags: toStringList(map['tags']),
      picture: toStringList(map['picture']),
      name: (map['name'] as String?) ?? '',
      link: (map['link'] as String?) ?? '',
      status: PinnedLocationStatus.fromString(map['status'] as String?),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PinnedLocation) return false;
    // If both have non-null ids, compare by id (canonical identity)
    if (id != null && other.id != null) return id == other.id;
    // Otherwise, don't consider distinct instances equal
    return false;
  }

  @override
  int get hashCode => id?.hashCode ?? identityHashCode(this);
}
