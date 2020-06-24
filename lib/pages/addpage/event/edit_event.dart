import 'package:flutter_hienhien/base/base_event.dart';

class EditEvent extends BaseEvent {
  String name;
  double debt;
  double paid;
  String address;
  String reason;
  DateTime duration;

  EditEvent(this.name, this.debt, this.paid, this.address, this.reason,
      this.duration);
}
