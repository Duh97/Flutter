import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() => runApp(new IosCloneCalculator());
class MyApp extends StatelessWidget { //套用响應式框架
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
          child,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      initialRoute: "/",
    );
  }
}

class IosCloneCalculator extends StatelessWidget {

  Widget build(BuildContext buildcx) {
    return new MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      home: new IosCloneCalc(),
    );
  }
}

class IosCloneCalc extends StatefulWidget {
  IosCloneCalcState createState() => IosCloneCalcState();
}

class IosCloneCalcState extends State<IosCloneCalc> {
  //先設定計算器邏輯中所需要的
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';



  Widget btn(btnText, Color color) {//設定按鈕
    return Container(
        padding: EdgeInsets.only(bottom: 10.0),//讓全部按鈕間隔看起來更平均
        child: new RaisedButton(
            child: Text(btnText,
              style: TextStyle(
                  fontSize: 30
              ),
            ),
            onPressed: (){
              calculation(btnText);//這裡要調用最下面的計算方法
            },
            color: color,
            padding: EdgeInsets.all(22.0),
            shape: CircleBorder() //為一個圓形按鈕

        )
    );
  } // end of button

  Widget btnZero(btnText, Color color) { //按鈕0專屬設定
    return Container(
        padding: EdgeInsets.only(bottom: 10.0),//讓按鈕間隔看起來更平均
        child: new RaisedButton(
            child: Text(btnText,
              style: TextStyle(
                  fontSize: 30
              ),
            ),
            onPressed: (){
              calculation(btnText);//這裡要調用最下面的計算方法
            },
            color: color,
            padding: EdgeInsets.only(left:85 ,top:20,right:85,bottom: 20),//調整按鈕0大小
            shape: StadiumBorder()//邊界

        )
    );
  } // end of button

  Widget build(BuildContext buildCx) {
    return new Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,//將列主軸為中心點，垂直對齊
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                child: Text(
                  text,//這裡是零狀態顯示
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60.0,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                ),
              )
            ],
            ),
            Row(//第一行
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn('AC',const Color(0xffa5a5a5)),//組合式AARRGGBB
                btn('+/-',const Color(0xffa5a5a5)),
                btn('%',const Color(0xffa5a5a5)),
                btn('/', Colors.orange),//因前面有三個同樣顏色，這裡÷就用橙色。
              ],),
            Row(//第二行
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, //水平對齊，不要讓按鈕擠在一起。
              children: <Widget>[
                btn('7',const Color(0xff333333)),//深灰色
                btn('8',const Color(0xff333333)),
                btn('9',const Color(0xff333333)),
                btn('x',Colors.orange),//因前面有三個同樣顏色，這裡÷就用橙色。
              ],),
            Row(//第三行
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn('4',const Color(0xff333333)),
                btn('5',const Color(0xff333333)),
                btn('6',const Color(0xff333333)),
                btn('-',Colors.orange),//因前面有三個同樣顏色，這裡÷就用橙色。
              ],),
            Row(//第四行
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn('1',const Color(0xff333333)),
                btn('2',const Color(0xff333333)),
                btn('3',const Color(0xff333333)),
                btn('+',Colors.orange),//因前面有三個同樣顏色，這裡÷就用橙色。
              ],),
            Row(//第五行
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btnZero('0',const Color(0xff333333)),
                btn('.',const Color(0xff333333)),
                btn('=',Colors.orange),//因前面有三個同樣顏色，這裡÷就用橙色。
              ],),
          ],
        ),
      ),
    );

  } // end of state class



  void calculation(btnText) { //這邊建立一個計算的方法
                              //每當按下一次按鈕時，都會到這裡來計算
                              //檢查這些計算條件，持續下降檢查

    if(btnText  == 'AC') {    //當我按下每個按鈕，所有的值都會為默認值
      text ='0';
      numOne = 0;
      numTwo = 0;

      result = '';
      finalResult = '';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }
      //當我按下"+"時，這個else if條件就會被執行，檢查是否等於"+"
    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
      //條件如果true，num第一次等於0，此條件就成立
      if(numOne == 0) {//檢查是否到0
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);//如果沒有，則numTwo將獲得結果值
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();{
          if(numTwo==0){
            finalResult="Error";
            numOne=0;
          }
        }
      }
      preOpr = opr;
      opr = btnText;
      result = '';//結果為空白
    }
    else if(btnText == '%') {
      result =(double.parse(result) / 100).toString();
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;
    }


    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {//當我按下第一個按鈕時+第二按鈕時，等於下去再一次等於時會再疊加上去
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

}