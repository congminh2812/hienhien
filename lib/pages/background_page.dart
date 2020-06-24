import 'package:flutter/material.dart';
import 'package:flutter_hienhien/pages/homepage/home_page.dart';

class BackGroundPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BackGroundPageState();
  }
  
}

class _BackGroundPageState extends State<BackGroundPage>   {

  List<List<String>> products = [
    [
      'assets/images/bg_hien5.jpg'
    ],
    [
      'assets/images/bg_hien6.jpg'
    ],
    [
      'assets/images/bg_hien4.jpg'
    ],
  ];
  int currentIndex = 0;
  String txtDone = "Tiếp tục";
  void _next(){
    setState((){
      if(currentIndex < products.length - 1){
        currentIndex++;
        txtDone = "Tiếp tục";
        if(currentIndex == products.length - 1) 
          txtDone = "Xong";
      }else{
        currentIndex = currentIndex;
        txtDone = "Xong";
      }
    });
  }
  void _previous(){
    setState((){
      if(currentIndex > 0){
        currentIndex--;
      }else
        currentIndex = currentIndex;
      txtDone = "Tiếp tục";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details){
          if(details.velocity.pixelsPerSecond.dx < 0){
            _next();
            print(currentIndex);
          }else if(details.velocity.pixelsPerSecond.dx > 0){
            _previous();
            print(currentIndex);
          }
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(products[currentIndex][0]),
              fit: BoxFit.cover
            )
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.2),
                ]
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        SizedBox(width: 30),
                        GestureDetector(child: Text('Bỏ qua',style: TextStyle(color: Colors.white)),
                          onTap: (){
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                          },
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: Row(
                            children: _buildIndicator()
                          ),
                        ),
                        SizedBox(width: 30),
                        GestureDetector(
                          onTap: (){
                            if(currentIndex == products.length - 1)
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                            else
                              _next();
                          },
                          
                          child: Text(txtDone,style: TextStyle(color: Colors.white))),
                        SizedBox(width: 30),
                      ],
                    )
                  )
              ],
            ),
          ),
        ),
      )
    );
  }
  
  Widget _indicator(bool isActive){
    return Expanded(
      child: Container(
        height: 4,
        width: 30,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: !isActive ? Colors.grey[800] : Colors.white
        ),
      ),
    );
  }
  
  List<Widget> _buildIndicator(){
    List<Widget> indicators = [];
    for(int i = 0; i <= products.length - 1; i++){
      if(currentIndex == i){
        indicators.add(_indicator(true));
      }else
        indicators.add(_indicator(false));
    }
    
    return indicators;
  }
  
}