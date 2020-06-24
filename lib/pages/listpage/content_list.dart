import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hienhien/bloc/debt_bloc.dart';
import 'package:flutter_hienhien/helper/enum_selector.dart';
import 'package:flutter_hienhien/helper/format.dart';
import 'package:flutter_hienhien/model/debtor.dart';
import 'package:provider/provider.dart';

class ContentList extends StatefulWidget {
  final TypeSelector type;
  ContentList(this.type);
  @override
  _ContentListState createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  AsyncMemoizer<DebtorBloc> debtorCache = AsyncMemoizer();
  DebtorBloc bloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debtorCache.runOnce(() {
      bloc = Provider.of<DebtorBloc>(context);
      switch (widget.type) {
        case TypeSelector.PAID:
          bloc.debtorPaidData();
          break;
        case TypeSelector.NOTPAY:
          bloc.debtorNotPayData();
          break;
        case TypeSelector.NOTFINISH:
          bloc.notFinishData();
          break;
        case TypeSelector.OVERTHEDEADLINE:
          bloc.overTheDeadline();
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DebtorBloc>(
      builder: (context, bloc, child) => StreamBuilder<List<Debtor>>(
          stream: bloc.debtorListSteam,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'Hiện tại chưa có ai mượn nợ !!',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              );
            }

            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return makeItem(snapshot.data[index]);
              },
            );
          }),
    );
  }

  Widget makeItem(Debtor debtor) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 50),
      height: 55,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.bottomLeft, colors: [
            Colors.pinkAccent.shade700.withOpacity(.8),
            Colors.pinkAccent.shade700.withOpacity(.6),
            Colors.pinkAccent.shade700.withOpacity(.4),
            Colors.white.withOpacity(.8),
            Colors.white.withOpacity(.4),
          ]),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54, blurRadius: 5, spreadRadius: 1)
                  ],
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://images.pexels.com/photos/937481/pexels-photo-937481.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  debtor.name,
                  style: TextStyle(
                      color: Colors.grey[100],
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Số tiền: ' + Format.formatMoney(debtor.debt) + ' VNĐ',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
