import 'dart:ffi';

class Vet {
  final dynamic UserID;
  final dynamic email;
  String name;
  String ?specialties;
  int ?consult;
  String ?vet_type;
  String ?location;
  Double ?exprience_year;



  

  Vet({this.UserID,this.email='', this.name=" ", this.specialties, this.consult=0, this.vet_type, this.location, this.exprience_year});
  Vet.copy(Vet from)
      : this(email: from.email, name: from.name, specialties: from.specialties, consult: from.consult, vet_type: from.vet_type, location: from.location, exprience_year: from.exprience_year);
  Vet copyWith({dynamic UserID,String name=" ", dynamic email, dynamic role}) =>(Vet(
      name:  this.name,
      email: email ?? this.email,
      specialties: specialties ?? specialties,
      consult:consult ?? consult,
      vet_type: vet_type ?? vet_type,
      location: location ?? location,
      exprience_year: exprience_year ?? exprience_year,
      ));

Vet.fromJson(Map<String, dynamic> json)
      : this(UserID: json['UserID'], email: json['email'], name: json['name'], specialties:  json['specialties'], consult:  json['consult'],vet_type: json['vet_type'],location: json['location'],exprience_year: json['experience_year']);

  Map<String, dynamic> toJson() =>
      {'UserID': UserID, 'email': email, 'name': name ,'specialties':specialties, 'consult':consult,'vet_type':vet_type, 'location':location,'experience_year':exprience_year};
}