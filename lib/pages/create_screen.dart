import 'package:flutter/material.dart';
import 'package:vital_days/model/create_day_menu_item.dart';
import 'package:vital_days/widgets/cardview.dart';

class CreateDayScreen extends StatefulWidget {
  @override
  _CreateDayScreenState createState() => _CreateDayScreenState();
}

class _CreateDayScreenState extends State<CreateDayScreen> {
  final menuItems = [
    MenuItem(
      title: "种类",
      icon: Icon(
        Icons.category,
        color: Colors.white,
      ),
      content: "倒计时",
    ),
    MenuItem(
      title: "目标日期",
      icon: Icon(
        Icons.email,
        color: Colors.white,
      ),
      content: "2020-2-5",
    ),
    MenuItem(
      title: "循环提醒",
      icon: Icon(
        Icons.repeat,
        color: Colors.white,
      ),
      content: "无循环",
    ),
    MenuItem(
      title: "备注",
      icon: Icon(
        Icons.note_add,
        color: Colors.white,
      ),
      content: "宝贝回来",
    ),
    PreviewItem(title: '预览效果：')
  ];
  int _selectedIndex;

  Widget _navigationBar() => AppBar(
        title: Text('Create the Vital Day'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              print('save btn pressed!');
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
                child: ListTile(
                  onTap: () {
                    print('clicked the $index item');
                    setState(() {
                      _selectedIndex = index;
                    });
                    // navigate to the calendar pick screen
                    if (index == 1) {
                      Navigator.pushNamed(context, '/calendar');
                    }
                  },
                  leading: item.icon,
                  title: Text(
                    item.title,
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
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
                        ]))
                  ],
                ),
              );
            }
          },
        ));
  }
}
