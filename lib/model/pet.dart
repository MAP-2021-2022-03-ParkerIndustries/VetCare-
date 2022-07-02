class Pet {
  dynamic petType;
  dynamic petOwner;
  dynamic petName;
  dynamic petImageURL;
  dynamic petID;

  Pet({this.petType, this.petOwner, this.petName, this.petImageURL,this.petID});
  Pet.fromJson(Map<String, dynamic> json)
      : this(
            petType: json['petType'],
            petOwner: json['petOwner'],
            petName: json['petName'],
            petImageURL: json['petImageURL'],
            petID:json['petID']);
  Map<String, dynamic> toJson() => {
        'petType': petType,
        'petOwner': petOwner,
        'petName': petName,
        'petImageURL': petImageURL
      };
  Pet copyWith(
          {dynamic petType,
          dynamic petOwner,
          dynamic petName,
          dynamic petImageURL,
          dynamic petID
          }) =>
      Pet(
          petName: petName ?? this.petName,
          petType: petType ?? this.petType,
          petOwner: petOwner ?? this.petOwner,
          petImageURL: petImageURL ?? this.petImageURL
          );
  void setPet(
      dynamic petType, dynamic petOwner, dynamic petName, dynamic petImageURL) {
    this.petName = petName;
    this.petType = petType;
    this.petOwner = petOwner;
    this.petImageURL = petImageURL;
  }
}
