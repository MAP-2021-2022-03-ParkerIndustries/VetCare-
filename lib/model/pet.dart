class Pet {
   dynamic petType;
   dynamic petOwner;
   dynamic petName;

  Pet({this.petType, this.petOwner, this.petName});

  Pet.fromJson(Map<String, dynamic> json)
      : this(
            petType: json['petType'],
            petOwner: json['petOwner'],
            petName: json['petName']);

  Map<String, dynamic> toJson() =>
      {'petType': petType, 'petOwner': petOwner, 'petName': petName};

  Pet copyWith({dynamic petType, dynamic petOwner, dynamic petName}) => Pet(
      petName: petName ?? this.petName,
      petType: petType ?? this.petType,
      petOwner: petOwner ?? this.petOwner);

  void setPet(dynamic petType, dynamic petOwner, dynamic petName) {
    this.petName = petName;
    this.petType = petType;
    this.petOwner = petOwner;
  }
}
