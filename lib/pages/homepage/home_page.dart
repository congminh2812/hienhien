import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hienhien/animations/fade_animation.dart';
import 'package:flutter_hienhien/bloc/debt_bloc.dart';
import 'package:flutter_hienhien/helper/enum_selector.dart';
import 'package:flutter_hienhien/pages/addpage/add_page.dart';
import 'package:flutter_hienhien/pages/homepage/button_icons.dart';
import 'package:flutter_hienhien/pages/homepage/list_debtor.dart';
import 'package:flutter_hienhien/pages/homepage/special_selector.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _breathingController;
  var _breathe = 0.0;

  @override
  initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _breathingController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _breathingController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _breathingController.forward();
      }
    });
    _breathingController.addListener(() {
      setState(() {
        _breathe = _breathingController.value;
      });
    });

    _breathingController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = 30.0 - 10*_breathe;
    final scale =  _breathe * 0.1 + 0.8;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Provider<DebtorBloc>.value(
        value: DebtorBloc(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Transform.scale(
                      scale: scale ,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50 / 2),
                            image: DecorationImage(
                                image: AssetImage('assets/images/avt_hien2.png'),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Icon(
                      Icons.alarm_on,
                      size: 25,
                      color: Colors.pinkAccent,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Row(
                  children: <Widget>[
                    Text('Chức năng chính',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ButtonIcons(
                      buttonText: [
                        [
                            'assets/images/user_1.png',
                            'Thanh toán',
                            TypeSelector.PAID,
                        ],
                        [
                            'assets/images/user_2.png',
                            'Chưa thanh toán',
                            TypeSelector.NOTPAY,
                        ],
                        [
                            'assets/images/user_3.png',
                            'Còn thiếu',
                            TypeSelector.NOTFINISH,
                        ],
                        [
                            'assets/images/user_4.png',
                            'Quá thời hạn',
                            TypeSelector.OVERTHEDEADLINE,
                        ],
                        
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Text('Nổi bật',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              SpecialSelector(
                specialList: ['Nợ mới', 'Đã trả', 'Chưa trả'],
              ),
              SizedBox(
                height: 10,
              ),
             ListDebtor(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FadeAnimation(1.3, 
        FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPage(true, null)));
          },
          child: Icon(Icons.person_add,size: size,),
          backgroundColor: Colors.pinkAccent,
          elevation: 20,
          
        ),
      ),
    );
  }
}
