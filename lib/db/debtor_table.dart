import 'package:flutter_hienhien/model/debtor.dart';

class DebtorTable {
  static const TABLE_NAME = 'Debtor';

  Future<List<Debtor>> selectAllDebtor() async{
    List<Debtor> debtorList = List();
    debtorList.add(Debtor(1, 'Nguyen Hien', 200000, 0, DateTime(2020, 5, 11), 'District 12', 'No reason'));
    debtorList.add(Debtor(2, 'Nguyen Hien 2', 200000, 0, DateTime(2020, 5, 11), 'District 12', 'No reason'));

    return debtorList;
  }

  Future<List<Debtor>> selectDebtorPaid() async{
    List<Debtor> debtorList = List();
    debtorList.add(Debtor(1, 'Cong Minh', 200000, 0, DateTime(2020, 5, 11), 'District 12', 'No reason'));
    debtorList.add(Debtor(2, 'Cong Minh 2', 200000, 0, DateTime(2020, 5, 11), 'District 12', 'No reason'));

    return debtorList;
  }

  Future<List<Debtor>> selectDebtorNotPay() async{
    List<Debtor> debtorList = List();
    debtorList.add(Debtor(1, 'Nguyen Minh', 200000, 0, DateTime(2020, 5, 11), 'District 12', 'No reason'));
    debtorList.add(Debtor(2, 'Nguyen Minh 2', 200000, 0, DateTime(2020, 5, 11), 'District 12', 'No reason'));

    return debtorList;
  }

  Future<int> insertDebtor(){
    return Future.value(1);
  }

  Future<int> updateDebtor(){
    return Future.value(1);
  }
}