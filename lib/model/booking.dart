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
  dynamic bookingID; 

  Booking({
    this.DoctorID,
    this.customerID,
    this.dateBooking,
    this.PaymentValue_Admin,
    this.PaymentValue_Doctor,
    this.paymentType,
    this.petID,
    this.appointmentStatus,
    this.bookingID,

  });

  Booking.fromJson(Map<String, dynamic> json)
      : this(DoctorID: json['DoctorID'], customerID: json['customerID'], dateBooking: json['dateBooking'],PaymentValue_Doctor: json['PaymentValue_Doctor'],paymentType: json['paymentType'],PaymentValue_Admin: json['PaymentValue_Admin'], petID: json["petID"],appointmentStatus: json['appointmentStatus'],bookingID:json['bookingID']);
  
  Map<String, dynamic> toJson() =>
      {'DoctorID':DoctorID , 'customerID': customerID, 'dateBooking': dateBooking,'Payment_value_Admin':PaymentValue_Admin,'Payment_value_Doctor':PaymentValue_Doctor,'paymentType':paymentType, 'appointmentStatus':appointmentStatus,'petID': petID};



  Booking copyWith({
    dynamic animal,
    dynamic customerID,
    dynamic dateBooking,
    dynamic doctor,
    dynamic paymentType,
    dynamic petID,
    dynamic appointmentStatus,
    dynamic bookingID
  }) {
    return Booking(
      DoctorID: DoctorID ?? DoctorID,
      customerID: customerID ?? this.customerID,
      dateBooking: dateBooking ?? this.dateBooking,
      PaymentValue_Admin: PaymentValue_Admin ?? this.PaymentValue_Admin,
      PaymentValue_Doctor: PaymentValue_Doctor ?? this.PaymentValue_Doctor,
      paymentType: paymentType ?? this.paymentType,
      petID: petID ?? this.petID,
      appointmentStatus: appointmentStatus ?? this.appointmentStatus,
      bookingID: bookingID ?? this.bookingID,
    );
  }
}