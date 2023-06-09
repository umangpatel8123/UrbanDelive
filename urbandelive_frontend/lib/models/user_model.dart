class UserModel {
  final String uid;
  final String username;
  final String email;
  final String phoneNo;
  final String createdAt;
  final String lastLogin;
  final String dob;
  final String bio;
  final String addressLine1;
  final String addressLine2;

  UserModel(
      {required this.uid,
      required this.username,
      required this.email,
      required this.phoneNo,
      required this.createdAt,
      required this.lastLogin,
      required this.dob,
      required this.bio,
      required this.addressLine1,
      required this.addressLine2});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'] ?? '',
        username: map['username'] ?? '',
        email: map['email'] ?? '',
        phoneNo: map['phoneNo'] ?? '',
        createdAt: map['createdAt'] ?? '',
        lastLogin: map['lastLogin'] ?? '',
        dob: map['dob'] ?? '',
        bio: map['bio'] ?? '',
        addressLine1: map['addressLine1'] ?? '',
        addressLine2: map['addressLine2'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'phoneNo': phoneNo,
      'createdAt': createdAt,
      'lastLogin': lastLogin,
      'dob': dob,
      'bio': bio,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2
    };
  }
}
