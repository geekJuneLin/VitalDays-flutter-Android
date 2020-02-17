import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  Widget _infoRow(title, text) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$title",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  )),
              Text("$text",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ))
            ],
          ),
        ),
        SizedBox(height:6,)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text(
          "更多",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Column(
          children: <Widget>[
            _infoRow("版本信息", "1.0.0"),
            _infoRow("好评", ""),
            _infoRow("Bug 反馈", ""),
          ],
        ),
      ),
    );
  }
}
