import 'package:vetcare/vetcare.dart';

class Failures {
  static const cannotRead = Failure(100, message: 'Cannot read data');
  static const cannotWrite = Failure(101, message: 'Cannot write data');
}
