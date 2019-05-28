import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var _routes = [
    {
      'title': 'userInfo',
    },
    {
      'title': '首页',
      'path': 'home'
    },
    {
      'title': '写游记',
      'path': 'toWrite'
    },
  ];

  Widget _buildList() {
    return new ListView.separated(
      itemCount: _routes.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        return _buildRow(_routes[index], index);
      },
    );
  }

  Widget _buildRow(item, index) {
    if(index == 0){
      return _buildUserInfo();
    }
    final _title = item['title'];

    return ListTile(
      title: new Text(_title),
    );
  }

  Widget _buildUserInfo() {
    return new UserAccountsDrawerHeader(
      accountName: new Text('Leeing'),
      accountEmail: new Text('372711472@qq.com'),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: NetworkImage('https://img.alicdn.com/imgextra/i4/69942425/O1CN01N8clmB1Tmgz5LvAS6_!!69942425.jpg'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: _buildList()
    );
  }
}