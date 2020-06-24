import 'package:flutter/material.dart';
import 'package:flutter_hienhien/bloc/debt_bloc.dart';
import 'package:flutter_hienhien/helper/format.dart';
import 'package:flutter_hienhien/pages/addpage/add_page.dart';
import 'package:flutter_hienhien/pages/addpage/event/add_event.dart';
import 'package:flutter_hienhien/pages/addpage/event/edit_event.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MainContent extends StatefulWidget {
  final AddPage addPage;
  MainContent(this.addPage);
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  DebtorBloc _bloc;
  var _dateTime;

  var nameController = TextEditingController();
  var debtController = TextEditingController();
  var addressController = TextEditingController();
  var reasonController = TextEditingController();
  var paidController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<DebtorBloc>(context);
    initData();
  }

  void initData() {
    if (!widget.addPage.isAdd && widget.addPage.debtor != null) {
      nameController.text = widget.addPage.debtor.name;
      debtController.text = widget.addPage.debtor.debt.toString();
      addressController.text = widget.addPage.debtor.address;
      reasonController.text = widget.addPage.debtor.reason;
      paidController.text = widget.addPage.debtor.paid.toString();
      _dateTime = widget.addPage.debtor.duration;
    }
  }

  @override
  Widget build(BuildContext context) {
    double distance = widget.addPage.isAdd ? 15 : 10;
    return Expanded(
      child: Column(
        children: <Widget>[
          _buildName(),
          SizedBox(
            height: distance,
          ),
          _buildDebt(),
          SizedBox(
            height: distance == 15 ? 0 : 10,
          ),
          _buildPaid(),
          SizedBox(
            height: distance,
          ),
          _buildAddress(),
          SizedBox(
            height: distance,
          ),
          _buildReason(),
          SizedBox(
            height: distance,
          ),
          rowDatePicker(),
          SizedBox(
            height: distance,
          ),
          RaisedButton(
              padding: EdgeInsets.only(left: 50, right: 50),
              color: Colors.white,
              onPressed: () {
                if (validate()) return;
                if (widget.addPage.isAdd) {
                  _bloc.event.add(AddEvent(
                      nameController.text,
                      double.parse(debtController.text),
                      addressController.text,
                      reasonController.text,
                      _dateTime));

                  if (_bloc.result == 1) _showToast(context, 'Thêm thành công');
                } else {
                  _bloc.event.add(EditEvent(
                      nameController.text,
                      double.parse(debtController.text),
                      double.parse(paidController.text),
                      addressController.text,
                      reasonController.text,
                      _dateTime));

                  if (_bloc.result == 1) _showToast(context, 'Sửa thành công');
                }
              },
              child: new Text(
                "CHẤP NHẬN",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.pinkAccent),
              ),
              colorBrightness: Brightness.light,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
              ))
        ],
      ),
    );
  }

  Widget _buildName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Colors.white),
      child: TextField(
        style: TextStyle(color: Colors.pinkAccent),
        controller: nameController,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.account_box,
            color: Colors.pinkAccent,
          ),
          hintStyle: TextStyle(color: Colors.pinkAccent.withAlpha(150)),
          hintText: 'Nhập họ tên người mượn',
        ),
      ),
    );
  }

  Widget _buildDebt() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Colors.white),
      child: TextField(
        style: TextStyle(color: Colors.pinkAccent),
        controller: debtController,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.account_box,
              color: Colors.pinkAccent,
            ),
            hintStyle: TextStyle(color: Colors.pinkAccent.withAlpha(150)),
            hintText: 'Số tiền'),
      ),
    );
  }

  Widget _buildAddress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Colors.white),
      child: TextField(
        style: TextStyle(color: Colors.pinkAccent),
        controller: addressController,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.account_box,
              color: Colors.pinkAccent,
            ),
            hintStyle: TextStyle(color: Colors.pinkAccent.withAlpha(150)),
            hintText: 'Địa chỉ'),
      ),
    );
  }

  Widget _buildReason() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Colors.white),
      child: TextField(
        style: TextStyle(color: Colors.pinkAccent),
        controller: reasonController,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.account_box,
              color: Colors.pinkAccent,
            ),
            hintStyle: TextStyle(color: Colors.pinkAccent.withAlpha(150)),
            hintText: 'Lý do'),
      ),
    );
  }

  Widget rowDatePicker() {
    final f = new DateFormat('yyyy-MM-dd');
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                _dateTime == null
                    ? !widget.addPage.isAdd
                        ? Format.formatDate(widget.addPage.debtor.duration)
                        : 'Chọn hạn ngày trả'
                    : f.format(_dateTime),
                style: TextStyle(
                    color: _dateTime == null && widget.addPage.isAdd
                        ? Colors.pinkAccent.withAlpha(150)
                        : Colors.pinkAccent,
                    fontSize: 16),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  Icons.date_range,
                  color: Colors.pinkAccent,
                ),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2222))
                      .then((date) {
                    setState(() {
                      _dateTime = date;
                    });
                  });
                },
              ),
            )
          ],
        ));
  }

  Widget _buildPaid() {
    return !widget.addPage.isAdd
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40), color: Colors.white),
            child: TextField(
              controller: paidController,
              style: TextStyle(color: Colors.pinkAccent),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.account_box,
                    color: Colors.pinkAccent,
                  ),
                  hintStyle: TextStyle(color: Colors.pinkAccent.withAlpha(150)),
                  hintText: 'Đã trả'),
            ),
          )
        : Container();
  }

  bool validate() {
    if (nameController.text == '') {
      _showToast(context, 'Bạn chưa nhập họ tên');
      return true;
    }
    if (debtController.text == '') {
      _showToast(context, 'Bạn chưa nhập số tiền');
      return true;
    }
    if (paidController.text == '' && !widget.addPage.isAdd) {
      _showToast(context, 'Bạn chưa nhập số tiền đã trả');
      return true;
    }
    if (addressController.text == '') {
      _showToast(context, 'Bạn chưa nhập địa chỉ');
      return true;
    }
    if (reasonController.text == '') {
      _showToast(context, 'Bạn chưa nhập lý do');
      return true;
    }
    if (_dateTime == null) {
      _showToast(context, 'Bạn chưa chọn ngày trả');
      return true;
    }
    return false;
  }

  void  _showToast(BuildContext context, String title) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(title),
        action: SnackBarAction(
          label: 'Bỏ qua',
          onPressed: scaffold.hideCurrentSnackBar,
        ),
        duration: Duration(milliseconds: 1000),
      ),
    );
  }
}
