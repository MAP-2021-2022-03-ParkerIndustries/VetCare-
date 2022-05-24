// ignore_for_file: non_constant_identifier_names

class Users {
  final dynamic name;
  final dynamic email;
  final dynamic role;

  Users({this.name, this.email, this.role});
  Users.copy(Users from)
      : this(role: from.role, email: from.email, name: from.name);
  Users copyWith({dynamic name, dynamic email, dynamic role}) => Users(
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role);

  Users.fromJson(Map<String, dynamic> json)
      : this(role: json['role'], email: json['email'], name: json['name']);

  Map<String, dynamic> toJson() =>
      {'role': role, 'email': email, 'name': name};
}
