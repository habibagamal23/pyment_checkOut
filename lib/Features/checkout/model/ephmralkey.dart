class EphemeralKeyModel {
  final String id;
  final String object;
  final List<AssociatedObject> associatedObjects;
  final int created;
  final int expires;
  final bool livemode;
  final String secret;

  EphemeralKeyModel({
    required this.id,
    required this.object,
    required this.associatedObjects,
    required this.created,
    required this.expires,
    required this.livemode,
    required this.secret,
  });

  // Factory method to create an instance from JSON
  factory EphemeralKeyModel.fromJson(Map<String, dynamic> json) {
    return EphemeralKeyModel(
      id: json['id'],
      object: json['object'],
      associatedObjects: (json['associated_objects'] as List)
          .map((e) => AssociatedObject.fromJson(e))
          .toList(),
      created: json['created'],
      expires: json['expires'],
      livemode: json['livemode'],
      secret: json['secret'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': object,
      'associated_objects':
      associatedObjects.map((e) => e.toJson()).toList(),
      'created': created,
      'expires': expires,
      'livemode': livemode,
      'secret': secret,
    };
  }
}

class AssociatedObject {
  final String id;
  final String type;

  AssociatedObject({
    required this.id,
    required this.type,
  });

  // Factory method to create an instance from JSON
  factory AssociatedObject.fromJson(Map<String, dynamic> json) {
    return AssociatedObject(
      id: json['id'],
      type: json['type'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
    };
  }
}
