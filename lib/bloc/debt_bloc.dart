import 'dart:async';

import 'package:flutter_hienhien/base/base_bloc.dart';
import 'package:flutter_hienhien/base/base_event.dart';
import 'package:flutter_hienhien/db/debtor_table.dart';
import 'package:flutter_hienhien/model/debtor.dart';
import 'package:flutter_hienhien/pages/addpage/event/add_event.dart';
import 'package:flutter_hienhien/pages/addpage/event/edit_event.dart';

class DebtorBloc extends BaseBloc{
  StreamController<List<Debtor>> _debtorListStreamController = StreamController();
  StreamController<int> _resultStreamController = StreamController();

  Stream<List<Debtor>> get debtorListSteam => _debtorListStreamController.stream;
  Stream<int> get resultListSteam => _resultStreamController.stream;

  List<Debtor> _debtorList = List();
  DebtorTable _debtorTable = DebtorTable();
  int result = 0;

  @override
  void dispatchEvent(BaseEvent event) {
    if (event is AddEvent){
       _addDebtor();
    }else if (event is EditEvent){
      _updateDebtor();
    }
  }

  void initData() async{
    // get data to __debtorList
    _debtorList = await _debtorTable.selectAllDebtor();
    if(_debtorList == null)
      return;
    
    _debtorListStreamController.sink.add(_debtorList);
  }

  void debtorPaidData() async{
    // get data to __debtorList
    _debtorList = await _debtorTable.selectDebtorPaid();
    if(_debtorList == null)
      return;
    
    _debtorListStreamController.sink.add(_debtorList);
  }

  void debtorNotPayData() async{
    // get data to __debtorList
    _debtorList = await _debtorTable.selectDebtorNotPay();
    if(_debtorList == null)
      return;
    
    _debtorListStreamController.sink.add(_debtorList);
  }

  
  void notFinishData() async{
    // get data to __debtorList
    _debtorList = await _debtorTable.selectDebtorNotPay();
    if(_debtorList == null)
      return;
    
    _debtorListStreamController.sink.add(_debtorList);
  }

  
  void overTheDeadline() async{
    // get data to __debtorList
    _debtorList = await _debtorTable.selectDebtorNotPay();
    if(_debtorList == null)
      return;
    
    _debtorListStreamController.sink.add(_debtorList);
  }

  _addDebtor() async{
    result = await _debtorTable.insertDebtor();

    _resultStreamController.sink.add(result);
  }

  
  _updateDebtor() async{
    result = await _debtorTable.updateDebtor();

    _resultStreamController.sink.add(result);
  }

  @override
  void dispose() {
    super.dispose();
    _debtorListStreamController.close();
  }
}