import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardView extends StatelessWidget {
  final BoxDecoration decoration;
  final String note;
  final String noteType;
  final String targetDate;
  final int daysLeft;
  final int initDaysLeft;

  CardView({
    this.decoration,
    this.note,
    this.noteType,
    this.targetDate,
    this.daysLeft,
    this.initDaysLeft,
  });

  Widget topSection(context) => Row(
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
                    note == null || note == "" ? '输入备注' : '$note',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(noteType == null || noteType == "" ? '类型' : '$noteType',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ))
                ],
              ),

              // Small NoteType
              Container(
                color: Colors.white24,
                child: Text(
                    noteType == null || noteType == "" ? ' 类型 ' : ' $noteType ',
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
                  Text(
                      targetDate == null || targetDate == ""
                          ? DateFormat("yyyy-MM-dd").format(DateTime.now())
                          : '$targetDate',
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
              Text(daysLeft == null ? "0" : '$daysLeft',
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
            topSection(context),

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
                  width: MediaQuery.of(context).size.width *
                              ((initDaysLeft - daysLeft) <=
                          0
                      ? 0.001
                      : ((initDaysLeft - daysLeft) / initDaysLeft)),
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
