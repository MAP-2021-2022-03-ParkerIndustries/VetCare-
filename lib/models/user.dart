class User {
  final String email;
  final String pass;

  User({required this.email, required this.pass});

  User.fromJson(Map<String,dynamic>json)
    :this(email:json['email'], pass: json['pass']);

  Map<String, dynamic> toJson() => {'email': email, 'pass': pass};
}