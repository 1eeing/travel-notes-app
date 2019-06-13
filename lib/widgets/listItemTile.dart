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
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/articleDetail');
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                '$likeNum 人喜欢',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[500]
                ),
                textAlign: TextAlign.right,
              ),
              height: 60,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            picUrl != null ? Container(
              child: Image.network(
                picUrl,
                fit: BoxFit.cover,
              ),
              height: 200,
              width: double.infinity,
            ) : null,
            Container(
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            ),
            subTitle != null ? Container(
              child: Text(
                subTitle,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[500]
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(16.0),
            ) : null,
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 8.0),
      ),
    );
  }
}