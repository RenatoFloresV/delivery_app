
class UserEntity {
  const UserEntity({
    this.uid,
    this.displayName,
    // this.lastName,
    this.email,
    this.imageUrl,
  });

  final String? uid;
  final String? displayName;
  // final String? lastName;
  final String? email;
  final String? imageUrl;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'displayName': displayName,
        // // 'lastName': lastName,
        'email': email,
        'imageUrl': imageUrl,
      };
  factory UserEntity.empty() => const UserEntity(
        uid: "",
        displayName: "",
        // lastName: "",
        email: "",
        imageUrl: "",
      );
  // List<Object?> get props => [uid, displayName, lastName, email, imageUrl];

  static UserEntity fromSnapshot(dynamic snapshot) {
    return UserEntity(
      uid: snapshot['uid'],
      displayName: snapshot['displayName'],
      // // lastName: snapshot['lastName'],
      email: snapshot['email'],
      imageUrl: snapshot['imageUrl'],
    );
  }

  static UserEntity fromJson(Map<String, dynamic> json) {
    return UserEntity(
      uid: json['uid'] ?? "",
      displayName: json['displayName'] ?? "",
      // // lastName: json['lastName'] ?? "",
      email: json['email'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
    );
  }
}
