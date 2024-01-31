import 'package:hive/hive.dart';

Future<void> newhive() async {
  final hi = await Hive.openBox('dhjd');

  hi.add('12');
}

Future<void> kdj() async {
  final hi = await Hive.openBox('dhjd');

  hi.values.toList();
}
