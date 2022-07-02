import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:vetclinic/model/booking.dart';


Future sendEmail({
  required String name,
  required String email,
  required String subject,
  required String message,
  required String emailrep
})

 async {
  
  
  const  serviceId = 'service_l05oha8';
  const templateId = 'template_jg9rcy9';
  const userId = 'sJvFcXbvm2rfgR4bP';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(
    url,
    headers: {
      'origin':'http://localhost',
      'Content-Type': 'application/json'

      },
    body: jsonEncode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params':{
        'user_name':name,
        'user_email':email,
        'user_subject':subject,
        'user_message':message,
        'to_email':emailrep
      }
    }),
  );

  print(response.body);
}
