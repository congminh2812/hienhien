import 'package:flutter/material.dart';
import 'package:flutter_hienhien/helper/format.dart';
import 'package:flutter_hienhien/model/debtor.dart';
import 'package:flutter_hienhien/pages/addpage/add_page.dart';
import 'package:flutter_hienhien/pages/homepage/home_page.dart';

class DetailPage extends StatefulWidget {
  final Debtor debtor;
  DetailPage(this.debtor);
  @override
  State<StatefulWidget> createState() {
    return _DetailPageState();
  }
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    double moneyBalance = widget.debtor.debt - widget.debtor.paid;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(
                  'https://images.pexels.com/photos/956999/milky-way-starry-sky-night-sky-star-956999.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ))
                  ],
                ),
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 5,
                              spreadRadius: 1)
                        ],
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://images.pexels.com/photos/937481/pexels-photo-937481.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.details,
                      color: Colors.pink,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Thông tin chi tiết',
                        style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                rowInfomation(
                    title: 'Họ và tên: ', content: widget.debtor.name),
                SizedBox(
                  height: 10,
                ),
                rowInfomation(
                    title: 'Số tiền: ',
                    content: Format.formatMoney(widget.debtor.debt) + " VNĐ"),
                SizedBox(
                  height: 10,
                ),
                rowInfomation(
                    title: 'Đã trả: ',
                    content: Format.formatMoney(widget.debtor.paid) + " VNĐ"),
                SizedBox(
                  height: 10,
                ),
                rowInfomation(
                    title: 'Còn lại: ',
                    content: Format.formatMoney(moneyBalance) + " VNĐ"),
                SizedBox(
                  height: 10,
                ),
                rowInfomation(
                    title: 'Địa chỉ: ', content: widget.debtor.address),
                SizedBox(
                  height: 10,
                ),
                rowInfomation(
                    title: 'Hạn trả: ',
                    content: Format.formatDate(widget.debtor.duration)),
                SizedBox(
                  height: 10,
                ),
                rowInfomation(title: 'Lý do: ', content: widget.debtor.reason),
                SizedBox(
                  height: 10,
                ),
                rowInfomation(
                    title: 'Trạng thái: ',
                    content: moneyBalance == 0 ? 'Hoàn thành' : 'Chưa xong'),
                SizedBox(
                  height: 30,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Chúc một ngày tốt lành !',
                      style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    )),
              ],
            ),
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPage(false, widget.debtor)));
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        elevation: 10,
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }

  Widget rowInfomation({title, content}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title, style: TextStyle(color: Colors.pink.withAlpha(200))),
        Flexible(
            child: Text(
          content,
          style: TextStyle(color: Colors.pink.withAlpha(200)),
          textAlign: TextAlign.right,
        )),
      ],
    );
  }
}
