import 'package:vetcare/vetcare.dart';

class Failures {
  static const cannotRead = const Failure(100, message: 'Cannot read data');
  static const cannotWrite = const Failure(101, message: 'Cannot write data');
}
