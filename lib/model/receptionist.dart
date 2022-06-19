class Receptionist{

  dynamic staffID;
  dynamic email;
  dynamic name;
  
   Receptionist({
    this.staffID,
    this.email,
    this.name,
  });
  Receptionist.fromJson(Map<String, dynamic> json)
      : this(staffID: json['staffID'], email: json['email'], name: json['name']);
  
  Map<String, dynamic> toJson() => {'role': staffID, 'email': email, 'name': name,};
}