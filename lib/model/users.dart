// ignore_for_file: non_constant_identifier_names

class Users {
  final dynamic name;
  final dynamic email;
  final dynamic roles;

  Users({this.name, this.email, this.roles = false});
  Users.copy(Users from)
      : this(roles: from.roles, email: from.email, name: from.name);
  Users copyWith({dynamic name, dynamic email, dynamic roles}) => Users(
      name: name ?? this.name,
      email: email ?? this.email,
      roles: roles ?? this.roles);

  Users.fromJson(Map<String, dynamic> json)
      : this(roles: json['roles'], email: json['email'], name: json['name']);

  Map<String, dynamic> toJson() =>
      {'roles': roles, 'email': email, 'name': name};
}
