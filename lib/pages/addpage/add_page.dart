import 'package:flutter/material.dart';
import 'package:flutter_hienhien/bloc/debt_bloc.dart';
import 'package:flutter_hienhien/model/debtor.dart';
import 'package:flutter_hienhien/pages/addpage/main_content.dart';
import 'package:flutter_hienhien/pages/homepage/home_page.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  final bool isAdd;
  final Debtor debtor;
  AddPage(this.isAdd, this.debtor);
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Provider<DebtorBloc>.value(
        value: DebtorBloc(),
        child: content()
      ),
    );
  }
  Widget appBar(){
    return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,),onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomePage()));
          },),
          Text('Quay lại', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
  Widget circleAvatar() {
    return Center(
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(blurRadius: 5, spreadRadius: 0.2, color: Colors.grey[500])
        ], borderRadius: BorderRadius.circular(50)),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/images/avt_hien2.png'),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              Icons.camera_enhance,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }


  Widget content(){
    if (widget.isAdd)
      return addContent();
    else
      return editContent();

  }

  Widget addContent(){
    return Container(
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://images.pexels.com/photos/364096/pexels-photo-364096.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                  fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(.7),
                  Colors.black.withOpacity(.2),
                ]
              )
            ),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  appBar(),
                  circleAvatar(),
                  MainContent(widget),
                ],
              ),
            ),
          ),
        );
  }

  Widget editContent(){
    return Container(
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://images.pexels.com/photos/364096/pexels-photo-364096.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                  fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(.7),
                  Colors.black.withOpacity(.2),
                ]
              )
            ),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  appBar(),
                  circleAvatar(),
                  MainContent(widget),
                ],
              ),
            ),
          ),
        );
  }
  
}
