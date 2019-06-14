import 'package:flutter/material.dart';
import '../../pages/addArticle/index.dart';
import '../../utils/httpUtil.dart';
import '../../utils/userInfo.dart';
import '../../widgets/dialog.dart';

class ArticleDetail extends StatefulWidget {
  ArticleDetail({
    Key key,
    this.articleId,
  }) : super(key: key);

  final int articleId;

  @override
  _ArticleDetailState createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  @override
  void initState() {
    super.initState();
    getUserId();
    getArticleDetail();
  }

  int userId;
  int authorId;
  Map<String, dynamic> articleDetail;
  String title = '文章标题';
  String subTitle;
  String picUrl;
  String content = '内容加载中loading……';
  final TextStyle subTitleStyle = TextStyle(color: Colors.grey, fontSize: 15.0);
  final TextStyle contentStyle = TextStyle(fontSize: 17.0);

  void getUserId() async {
    int id = await UserInfo.getUserItem('id');
    setState(() {
      userId = id;
    });
  }

  void getArticleDetail() async {
    if(widget.articleId == null){
      return;
    }
    var json = await HttpUtil(context).request(
      '/posts/:id',
      method: HttpUtil.GET,
      data: {
        'id': widget.articleId,
      }
    );

    if(json == null){
      return;
    }

    if(json['result'] != 100){
      MyDialog.show(
        context,
        content: json['message'],
        isHideCancel: true,
      );
    }else{
      setState(() {
        articleDetail = json['data'];
        title = articleDetail['title'];
        subTitle = articleDetail['subTitle'];
        picUrl = articleDetail['coverPicUrl'];
        content = articleDetail['content'];
        authorId = articleDetail['authorId'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(title),
              actions: <Widget>[
                userId == authorId && userId != null && authorId != null ? IconButton(
                  icon: Icon(Icons.edit),
                  tooltip: 'Edit this article',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext ctx) {
                        return AddArticle(
                          title: title,
                          subTitle: subTitle,
                          picUrl: picUrl,
                          content: content,
                          authorId: authorId,
                          articleId: widget.articleId,
                        );
                      })
                    );
                  },
                ) : IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    // todo 点赞
                  },
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      picUrl != null ? Container(
                        child: Image.network(picUrl),
                      ) : Container(),
                      subTitle != null ? Container(
                        child: Text(subTitle, style: subTitleStyle,),
                        padding: EdgeInsets.all(10.0),
                      ) : Container(),
                      Container(
                        child: Text(content, style: contentStyle,),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                    ],
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}