import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground(context)
        ],
      ),
    );
  }

  Widget _createBackground(BuildContext context) {

    final size = MediaQuery.of(context).size;
    
    final purpleBackground = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        )
      ),
    );

    final circle = Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255 , 255, 0.05)
      ),
    );

    final headerIconText = Container(
      padding: EdgeInsets.only(top: 70),
      child: Column(
        children: <Widget>[
          Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
          SizedBox(height: 10.0, width: double.infinity),
          Text('David Toledo', style: TextStyle(color: Colors.white, fontSize: 25.0))
        ],
      ),
    );

    return Container(
      height: size.height * 0.4,
      child: Stack(
        children: <Widget>[
          purpleBackground,
          Positioned( top: 80.0, left: 30.0, child: circle),
          Positioned(top: -40.0, right: -30.0, child: circle),
          Positioned(bottom: -50.0, right: -5.0, child: circle),
          Positioned(bottom: 95.0, right: 30.0, child: circle),
          Positioned(bottom: -30.0, left: -40.0, child: circle),
          headerIconText
        ],
      ),
    );
  }
}