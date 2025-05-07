class Hospital {
  final String id;
  final String name;
  final String location;
  final String imageUrl;

  Hospital({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
  });

  // Convert model to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      '_id': id, // Keep it consistent with MongoDB
      'name': name,
      'location': location,
      'imageUrl': imageUrl,
    };
  }

  // Factory constructor to create an instance from JSON
  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json['_id'] ?? '', // Handle missing fields
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  // Convert a Dart Map (used in local storage or internal processing)
  factory Hospital.fromMap(Map<String, dynamic> map) {
    return Hospital(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  // Convert to a Map (useful for local storage)
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'location': location,
      'imageUrl': imageUrl,
    };
  }

  // CopyWith method for easy updates
  Hospital copyWith({
    String? id,
    String? name,
    String? location,
    String? imageUrl,
  }) {
    return Hospital(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
