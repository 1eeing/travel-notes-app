import 'package:flutter/material.dart';

class ListItemTile extends StatelessWidget {
  const ListItemTile({
    Key key,
    this.title,
    this.subTitle,
    this.picUrl,
    this.likeNum
  }) : super(key: key);

  final String title;
  final String subTitle;
  final String picUrl;
  final int likeNum;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/articleDetail');
      },
      child: new Card(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Text(
                '$likeNum 人喜欢',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[500]
                ),
                textAlign: TextAlign.right,
              ),
              height: 60,
              alignment: Alignment.centerLeft,
              padding: new EdgeInsets.symmetric(horizontal: 16.0),
            ),
            new Container(
              child: new Image.network(
                picUrl,
                fit: BoxFit.cover,
              ),
              height: 200,
              width: double.infinity,
            ),
            new Container(
              child: new Text(
                title,
                textAlign: TextAlign.left,
                style: new TextStyle(
                  fontSize: 22.0,
                  color: Colors.black
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              alignment: Alignment.centerLeft,
              padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            ),
            new Container(
              child: new Text(
                subTitle,
                textAlign: TextAlign.left,
                style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[500]
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              alignment: Alignment.centerLeft,
              padding: new EdgeInsets.all(16.0),
            ),
          ],
        ),
        margin: new EdgeInsets.symmetric(vertical: 8.0),
      ),
    );
  }
}