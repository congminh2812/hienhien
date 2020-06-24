import 'package:flutter_hienhien/base/base_event.dart';

class AddEvent extends BaseEvent {
  String name;
  double debt;
  String address;
  String reason;
  DateTime duration;

  AddEvent(this.name, this.debt, this.address, this.reason, this.duration);
}
