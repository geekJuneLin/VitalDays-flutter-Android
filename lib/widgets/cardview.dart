import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  BoxDecoration decoration;

  CardView({this.decoration});

  Widget get topSection => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Left section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Note & NoteType
              Row(
                children: <Widget>[
                  Text(
                    'WWDC',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('倒计时',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ))
                ],
              ),

              // Small NoteType
              Container(
                color: Colors.white24,
                child: Text(' 倒计时 ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    )),
              ),

              // Target date
              Row(
                children: <Widget>[
                  Text('目标日：',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Text('2020 - 2 - 5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ))
                ],
              )
            ],
          ),

          // Right section
          Column(
            children: <Widget>[
              Text('剩余天数',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )),
              SizedBox(
                height: 2,
              ),
              Text('4',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ))
            ],
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration == null
          ? BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.all(Radius.circular(10)))
          : decoration,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Top section
            topSection,

            // Bottom bar
            Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
