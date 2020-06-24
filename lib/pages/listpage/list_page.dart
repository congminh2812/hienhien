import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hienhien/bloc/debt_bloc.dart';
import 'package:flutter_hienhien/helper/enum_selector.dart';
import 'package:flutter_hienhien/pages/homepage/home_page.dart';
import 'package:flutter_hienhien/pages/listpage/content_list.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {
  final String title;
  final TypeSelector type;
  ListPage(this.title, this.type);

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: DebtorBloc(),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_hien4.jpg'),
                  fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
              Colors.black.withOpacity(.8),
              Colors.black.withOpacity(.2),
            ])),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomePage()));
                          },
                        ),
                        Text(
                          'DANH SÁCH '+title.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5),
                        )
                      ],
                    ),
                  ),
                  Container(
                  padding: EdgeInsets.symmetric(vertical: 1),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.grey,),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                      hintText: "Tìm kiếm theo tên..."
                    ),
                  ),
                ),
                  Expanded(
                    child: ContentList(type),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
