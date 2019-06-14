import 'package:flutter/material.dart';
import '../pages/articleDetail/index.dart';

class ListItemTile extends StatelessWidget {
  const ListItemTile({
    Key key,
    this.articleId,
    this.title,
    this.subTitle,
    this.content,
    this.picUrl,
    this.likeNum
  }) : super(key: key);

  final int articleId;
  final String title;
  final String subTitle;
  final String content;
  final String picUrl;
  final int likeNum;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 动态路由，可以传参
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext ctx) {
            return ArticleDetail(articleId: articleId);
          })
        );
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
            ) : Container(),
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
            Container(
              child: Text(
                subTitle ?? content,
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
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 8.0),
      ),
    );
  }
}