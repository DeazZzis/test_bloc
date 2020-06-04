import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testblocapp/pages/mainPage.dart';

class SecondPage extends StatelessWidget {
  SecondPage({this.text = null});

  String text;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = text;
    return WillPopScope(
        onWillPop: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainPage(text: _controller.text)));
          return false;
        },
        child: Scaffold(
            appBar: AppBar(),
            body: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: Card(
                          child: Container(
                              padding: EdgeInsets.all(8),
                              child: TextField(
                                controller: _controller,
                                autocorrect: false,
                                textAlign: TextAlign.start,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration:
                                    InputDecoration.collapsed(hintText: ""),
                              ))),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(23.0),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFFB415B),
                                    Color(0xFFEE5623)
                                  ],
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft),
                            ),
                            child: FlatButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainPage(
                                              text: _controller.text)));
                                },
                                child: Center(
                                  child: Text(
                                    'Зберегти',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ))))
                  ],
                ))));
  }
}
