class Booking {
  final dynamic DoctorID;
  final dynamic customerID;
  final dynamic dateBooking;
  final dynamic paymentType;
  final dynamic PaymentValue_Doctor;
  final dynamic PaymentValue_Admin;
  final dynamic DoctorName; 
  final dynamic petID; 
  final dynamic appointmentStatus; 

  Booking({
    required this.DoctorID,
    required this.customerID,
    required this.dateBooking,
    required this.PaymentValue_Admin,
    required this.DoctorName,
    required this.PaymentValue_Doctor,
    required this.paymentType,
    required this.petID,
    required this.appointmentStatus,
  });

  Booking.fromJson(Map<String, dynamic> json)
      : this(DoctorID: json['DoctorID'], customerID: json['customerID'], dateBooking: json['dateBooking'],PaymentValue_Doctor: json['PaymentValue_Doctor'],paymentType: json['paymentType'],PaymentValue_Admin: json['PaymentValue_Admin'], DoctorName: json["DoctorName"], petID: json["petID"],appointmentStatus: json['appointmentStatus']);
  
  Map<String, dynamic> toJson() =>
      {'DoctorID':DoctorID , 'customerID': customerID, 'dataBooking': dateBooking,'Payment_value_Admin':PaymentValue_Admin,'Payment_value_Doctor':PaymentValue_Doctor,'paymentType':paymentType, 'appointmentStatus':appointmentStatus};



  Booking copyWith({
    dynamic animal,
    dynamic customerID,
    dynamic dateBooking,
    dynamic doctor,
    dynamic paymentType,
    dynamic petID,
    dynamic appointmentStatus
  }) {
    return Booking(
      DoctorID: DoctorID ?? DoctorID,
      DoctorName: DoctorName ?? DoctorName,
      customerID: customerID ?? this.customerID,
      dateBooking: dateBooking ?? this.dateBooking,
      PaymentValue_Admin: PaymentValue_Admin ?? this.PaymentValue_Admin,
      PaymentValue_Doctor: PaymentValue_Doctor ?? this.PaymentValue_Doctor,
      paymentType: paymentType ?? this.paymentType,
      petID: petID ?? this.petID,
      appointmentStatus: appointmentStatus ?? this.appointmentStatus,
    );
  }
}