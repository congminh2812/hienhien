import 'package:flutter/material.dart';
import 'package:flutter_hienhien/bloc/debt_bloc.dart';
import 'package:provider/provider.dart';

class SpecialSelector extends StatefulWidget {
  final List<String> specialList;
  SpecialSelector({@required this.specialList});

  @override
  State<StatefulWidget> createState() {
    return _SpecialSelectorState();
  }
}

class _SpecialSelectorState extends State<SpecialSelector> {
  DebtorBloc _bloc;
  bool isSelected;
  int currentIndex = 0;
  List<Widget> _buttonList() {
    return widget.specialList.map((button) {
      var index = widget.specialList.indexOf(button);
      isSelected = currentIndex == index;
      return Padding(
          padding: EdgeInsets.only(left: 20, right: 15),
          child: GestureDetector(
            child: Text(
              button,
              style: TextStyle(
                  color: isSelected
                      ? Colors.pinkAccent
                      : Colors.pinkAccent.withAlpha(126),
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            onTap: () {
              setState(() {
                currentIndex = index;
                selector();
              });
            },
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = Provider.of<DebtorBloc>(context);
    return Container(
        height: 20,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: _buttonList(),
        ));
  }

  void selector() {
    switch (currentIndex) {
      case 0: // TypeSelector.NEWDEBT
        _bloc.initData();
        break;
      case 1: // TypeSelector.NEWDEBT
        _bloc.debtorPaidData();
        break;
      case 2: // TypeSelector.NEWDEBT
        _bloc.debtorNotPayData();
        break;
      default:
    }
  }
}
