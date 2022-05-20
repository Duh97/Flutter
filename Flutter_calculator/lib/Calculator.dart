import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/material.dart';

void main() => runApp(new IosCloneCalculator());

class IosCloneCalculator extends StatelessWidget{
  Widget build(BuildContext buildcx) {
    return new MaterialApp(
      title: '',
      home: new IosCloneCalc(),
    );
  }
}

class IosCloneCalc extends StatefulWidget{
  IosCloneCalcState createState() => IosCloneCalcState();
}

class IosCloneCalcState extends State<IosCloneCalc> {
  Widget build(BuildContext buildCx){

    return new Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: new Column(
        children: <Widget>[
          Row(children:<Widget>[
            Expanded(
              child: Text(
                '123',
                style:TextStyle(
                  color:Colors.white,
                  fontSize:60.0
                ),
                textAlign: TextAlign.right,
              ),
            )
          ],
          ),
          Row(children: <Widget>[
            btn('c',const Color(#808080)),
            btn(),
            btn(),
            btn(),

            )
          ],)
          ],)
    );


  Widget btn(btnText,Colors color) {
    return Container(
      child: new RaisedButton(
              child: Text(btnText),
              onPressed: (){},
              color: color,
    )
    );
    }

  }
}



