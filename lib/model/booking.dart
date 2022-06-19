class Booking {
  dynamic DoctorID;
  dynamic customerID;
  dynamic dateBooking;
  dynamic paymentType;
  dynamic PaymentValue_Doctor;
  dynamic PaymentValue_Admin;
  dynamic DoctorName; 
  dynamic petID; 
  dynamic appointmentStatus; 

  Booking({
    this.DoctorID,
    this.customerID,
    this.dateBooking,
    this.PaymentValue_Admin,
    this.DoctorName,
    this.PaymentValue_Doctor,
    this.paymentType,
    this.petID,
    this.appointmentStatus,
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