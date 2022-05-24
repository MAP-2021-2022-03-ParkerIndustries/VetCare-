import 'package:map_mvvm/map_mvvm.dart';

class Failures {
  static const cannotRead = Failure(100, message: 'Cannot read data');
  static const cannotWrite = Failure(101, message: 'Cannot write data');
}
