// ignore_for_file: non_constant_identifier_names

class Users {
  final dynamic name;
  final dynamic email;
  final dynamic role;
  final dynamic profileImg;

  Users({this.name, this.email, this.role, this.profileImg});
  
  Users.copy(Users from)
      : this(
            role: from.role,
            email: from.email,
            name: from.name,
            profileImg: from.profileImg);

  Users copyWith(
          {dynamic name, dynamic email, dynamic role, dynamic profileImg}) =>
      Users(
          name: name ?? this.name,
          email: email ?? this.email,
          role: role ?? this.role,
          profileImg: profileImg ?? this.profileImg);

  Users.fromJson(Map<String, dynamic> json)
      : this(role: json['role'], email: json['email'], name: json['name'],profileImg:json['profileImg']);

  Map<String, dynamic> toJson() => {'role': role, 'email': email, 'name': name, 'profileImg':profileImg};
}
