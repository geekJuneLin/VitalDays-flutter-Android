import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vital_days/model/create_day_menu_item.dart';
import 'package:vital_days/model/event.dart';
import 'package:vital_days/pages/calendar_pick_screen.dart';
import 'package:vital_days/utils/auth.dart';
import 'package:vital_days/widgets/cardview.dart';

class CreateDayScreen extends StatefulWidget {
  final VitalEvent event;

  CreateDayScreen({this.event});

  @override
  _CreateDayScreenState createState() => _CreateDayScreenState(
      selectedType: event.noteType,
      selectedDate: event.targetDate,
      note: event.note,
      daysLeft: event.daysLeft);
}

class _CreateDayScreenState extends State<CreateDayScreen> {
  // states
  String selectedType = "";
  String selectedRepeat = "";
  String selectedDate = "";
  String note = "";
  int daysLeft = 0;
  int _selectedIndex;

  _CreateDayScreenState(
      {this.selectedType,
      this.selectedDate,
      this.note,
      this.daysLeft});

  final _ref = FirebaseDatabase.instance.reference();

  final _noteController = TextEditingController();

  final _typeItems = ["倒计时", "纪念日", "生日", "作业"];
  final _repeatItems = ["不重复", "周重复", "月重复", "天重复", "年重复"];

  final menuItems = [
    MenuItem(
      title: "种类",
      icon: Icon(
        Icons.category,
        color: Colors.white,
      ),
      content: "选择种类",
    ),
    MenuItem(
      title: "目标日期",
      icon: Icon(
        Icons.email,
        color: Colors.white,
      ),
      content: DateFormat("yyyy-MM-dd").format(DateTime.now()),
    ),
    MenuItem(
      title: "循环提醒",
      icon: Icon(
        Icons.repeat,
        color: Colors.white,
      ),
      content: "选择循环类型",
    ),
    MenuItem(
      title: "备注",
      icon: Icon(
        Icons.note_add,
        color: Colors.white,
      ),
      content: "填写备注",
    ),
    PreviewItem(title: '预览效果：')
  ];

  Widget _navigationBar() => AppBar(
        title: Text('Create the Vital Day'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              print('save btn pressed!');
              _saveEvent(context);
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.save_alt,
                  color: Colors.white,
                ),
                Text(
                  '保存',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )
        ],
      );

  // init state func
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // add listener for note textfield to update the cardview real time
    _noteController.addListener(() {
      final value = _noteController.text;
      setState(() {
        note = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: _navigationBar(),
        body: ListView.builder(
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];

            if (item is MenuItem) {
              return Container(
                color: _selectedIndex == index ? Colors.white10 : null,
                child: index == 3
                    ? ListTile(
                        leading: item.icon,
                        title: Text(
                          item.title,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Container(
                          width: 100,
                          padding: EdgeInsets.only(left: 44),
                          child: TextField(
                            controller: _noteController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: item.content,
                                hintStyle: TextStyle(
                                  color: Colors.grey[200],
                                  fontSize: 14,
                                )),
                          ),
                        ),
                      )
                    : ListTile(
                        onTap: () {
                          print('clicked the $index item');
                          setState(() {
                            _selectedIndex = index;
                          });
                          // kind picker
                          if (index == 0) {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Scaffold(
                                    body: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Center(
                                            child: CupertinoPicker(
                                          backgroundColor: Colors.blue[200],
                                          itemExtent: 30,
                                          onSelectedItemChanged: (index) {
                                            setState(() {
                                              selectedType = _typeItems[index];
                                            });
                                            print("selected $selectedType");
                                          },
                                          children: _typeItems.map((type) {
                                            return Text(
                                              "$type",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            );
                                          }).toList(),
                                        ))),
                                  );
                                });
                          }

                          // navigate to the calendar pick screen
                          if (index == 1) {
                            _presentCalendar();
                          }

                          // repeat picker view
                          if (index == 2) {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Scaffold(
                                    body: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Center(
                                            child: CupertinoPicker(
                                          backgroundColor: Colors.blue[200],
                                          itemExtent: 30,
                                          onSelectedItemChanged: (index) {
                                            setState(() {
                                              selectedRepeat =
                                                  _repeatItems[index];
                                            });
                                            print("selected $selectedRepeat");
                                          },
                                          children: _repeatItems.map((type) {
                                            return Text(
                                              "$type",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            );
                                          }).toList(),
                                        ))),
                                  );
                                });
                          }
                        },
                        leading: item.icon,
                        title: Text(
                          item.title,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: index == 0
                            ? Text(
                                selectedType == ""
                                    ? item.content
                                    : selectedType,
                                style: TextStyle(color: Colors.white),
                              )
                            : index == 2
                                ? Text(
                                    selectedRepeat == ""
                                        ? item.content
                                        : selectedRepeat,
                                    style: TextStyle(color: Colors.white),
                                  )
                                : index == 1
                                    ? Text(
                                        selectedDate == ""
                                            ? item.content
                                            : selectedDate,
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text(
                                        item.content,
                                        style: TextStyle(color: Colors.white),
                                      ),
                      ),
              );
            } else if (item is PreviewItem) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Divider(
                      height: 1,
                      color: Colors.white,
                    ),
                    SizedBox(height: 12),
                    Text(
                      item.title,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 12),

                    // cardview
                    CardView(
                      decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 1,
                            )
                          ]),
                      note: note,
                      noteType: selectedType,
                      targetDate: selectedDate,
                      daysLeft: daysLeft,
                      initDaysLeft: daysLeft == 0 ? 1 : daysLeft,
                    )
                  ],
                ),
              );
            }
          },
        ));
  }

  // present the calendar picker view
  _presentCalendar() async {
    final date = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CalendarPage()));
    if (date != null) {
      setState(() {
        selectedDate = DateFormat("yyyy-MM-dd").format(date);
      });

      _calcDaysLeft();
    }
  }

  // save the created the event onto DB
  _saveEvent(BuildContext context) async {
    // check the note textfield first
    if (_noteController.text == null || _noteController.text == "") {
      _showError(context, "Please enter the note");
      return;
    }
    if (selectedDate != "" && selectedType != "" && selectedRepeat != "") {
      dynamic uid;
      int daysLeft;
      await Auth().getCurrentUser().then((user) => {uid = user.uid});
      if (uid != null) {
        print(
            "set value onto DB: $selectedType, $selectedRepeat, $selectedDate, " +
                _noteController.text +
                " uid: $uid");

        daysLeft = DateFormat("yyyy-MM-dd")
            .parse(selectedDate)
            .difference(DateTime.now())
            .inDays;

        _ref.child("Events").child(uid).push().set(<String, dynamic>{
          'note': _noteController.text,
          'noteType': selectedType,
          'targetDate': selectedDate,
          'leftDays': daysLeft,
          "initialLeft": daysLeft,
        }).then((_) {
          print("save event successfully");
          Navigator.pop(context, true);
        });
      } else {
        _showError(context, "no uid found!");
      }
    } else {
      _showError(context, "Save event with errors");
    }
  }

  // show the error in alert dialog
  _showError(BuildContext context, String error) {
    Widget okBtn = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog dialog = AlertDialog(
      title: Text("Error!"),
      content: Text("$error"),
      actions: <Widget>[okBtn],
    );

    showDialog(context: context, child: dialog);
  }

  // calculate how much days left according to the date that's been selected
  _calcDaysLeft() {
    setState(() {
      daysLeft = selectedDate == ""
          ? 0
          : DateFormat("yyyy-MM-dd")
                  .parse(selectedDate)
                  .difference(DateTime.now())
                  .inDays +
              1;
    });
  }
}
