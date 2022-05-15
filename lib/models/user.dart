class UserModel {
  final String? email;
  final String? pass;
  final String? name;


  UserModel({required this.email, required this.pass, required this.name});

  UserModel.fromJson(Map<String,dynamic>json)
    :this(email:json['email'], pass: json['pass'],name: json['name']);

  Map<String, dynamic> toJson() => {'email': email, 'pass': pass, 'name':name};
}