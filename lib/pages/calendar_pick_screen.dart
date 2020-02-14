import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();

  
}

class _CalendarPageState extends State<CalendarPage> {
  bool _isNaviBackBtnClicked = false;
  DateTime selectedDate;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List event) {
    setState(() {
      selectedDate = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _isNaviBackBtnClicked = !_isNaviBackBtnClicked;
            });
          },
          child: Container(
            color: !_isNaviBackBtnClicked ? null : Colors.white10,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                Expanded(
                    child: Text(
                  '返回',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ))
              ],
            ),
          ),
        ),
        title: Text(
          '选择日期',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              print('onDaySelected callback: $selectedDate');
              passDataBack(context, selectedDate);
            },
            child: Text(
              '保存',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: TableCalendar(
        // locale: 'zh_CN',
        calendarController: _calendarController,
        onDaySelected: _onDaySelected,
      ),
    );
  }

  passDataBack(BuildContext context, DateTime date){
    Navigator.pop(context, date);
  }
}
