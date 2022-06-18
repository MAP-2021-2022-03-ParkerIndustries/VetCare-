
class History {
  final dynamic animal;
  final dynamic customerID;
  final dynamic dateBooking;
  final dynamic doctor;
  final dynamic paymentType;
  History({
    required this.animal,
    required this.customerID,
    required this.dateBooking,
    required this.doctor,
    required this.paymentType,
  });

  History.fromJson(Map<String, dynamic> json)
      : this(animal: json['animal'], customerID: json['customerID'], dateBooking: json['dateBooking'],doctor: json['doctor'],paymentType: json['paymentType']);
  
  Map<String, dynamic> toJson() =>
      {'animal': animal, 'customerID': customerID, 'dataBooking': dateBooking,'doctor':doctor,'paymentType':paymentType};



  History copyWith({
    dynamic animal,
    dynamic customerID,
    dynamic dateBooking,
    dynamic doctor,
    dynamic paymentType,
  }) {
    return History(
      animal: animal ?? this.animal,
      customerID: customerID ?? this.customerID,
      dateBooking: dateBooking ?? this.dateBooking,
      doctor: doctor ?? this.doctor,
      paymentType: paymentType ?? this.paymentType,
    );
  }
}
