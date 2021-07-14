// class UserModel {
//   String _id;
//   String username;
//   String password;
//   String email;
//   String firstname;
//   String lastname;

//   UserModel(
//       {
//         required this._id,
//       required this.username,
//       required this.password,
//       required this.email,
//       required this.firstname,
//       required this.lastname});

//   // UserModel.fromJson(dynamic json) {
//   //   this.username = json['user_name'];
//   //   this.password = json['password'];
//   //   this.email = json['email'];
//   //   this.firstname = json['first_name'];
//   //   this.lastname = json['last_name'];
//   // }
// }

class UserModel {
  final String? id;
  final String? username;
  final String? email;
  final String? token;
  // final String password;
  // final String email;
  // final String createAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.token,

    // required this.password,
    // required this.email,
    // required this.createAt
  });

  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     id: json['_id'],
  //     username: json['username'],
  //     password: json['password'],
  //     email: json['email'],
  //     createAt: json['createAt'],
  //   );
  // }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      username: json['username'],

      // password: json['password'],
      email: json['email'],
      token: json['token'],
      // createAt: json['createAt'],
    );
  }
}
