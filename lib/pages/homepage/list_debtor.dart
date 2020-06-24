import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hienhien/bloc/debt_bloc.dart';
import 'package:flutter_hienhien/helper/enum_selector.dart';
import 'package:flutter_hienhien/helper/format.dart';
import 'package:flutter_hienhien/model/debtor.dart';
import 'package:flutter_hienhien/pages/detaipage/detail_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class ListDebtor extends StatefulWidget {
  @override
  _ListDebtorState createState() => _ListDebtorState();
}

class _ListDebtorState extends State<ListDebtor> {
  AsyncMemoizer<DebtorBloc> debtorCache = AsyncMemoizer();
  DebtorBloc bloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debtorCache.runOnce(() {
      bloc = Provider.of<DebtorBloc>(context);
      bloc.initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DebtorBloc>(
      builder: (context, bloc, child) => StreamBuilder<List<Debtor>>(
          stream: bloc.debtorListSteam,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Expanded(
                child: Center(
                  child: Text(
                    'Hiện tại chưa có ai mượn nợ !!',
                    style: TextStyle(color: Colors.pink, fontSize: 20),
                  ),
                ),
              );
            }

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return makeItem(snapshot.data[index]);
                  },
                ),
              ),
            );
          }),
    );
  }

  Widget makeItem(Debtor debtor) {
    return GestureDetector(
      onLongPress: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailPage(debtor)));
      },
      child: AspectRatio(
        aspectRatio: 2.64 / 3,
        child: Container(
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage('assets/images/avt_hien2.png'),
                    fit: BoxFit.cover)),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.2),
                  ])),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      debtor.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Số tiền: ' + Format.formatMoney(debtor.debt) + ' VNĐ',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
