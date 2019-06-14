import 'package:flutter/material.dart';
import '../../utils/httpUtil.dart';
import '../../widgets/listItemTile.dart';
import '../../widgets/dialog.dart';

class ArticleList extends StatefulWidget {
  @override
  _ArticleListState createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  @override
  void initState() {
    super.initState();
    getRequestList();
  }

  List _lists;

  void getRequestList() async {
    var res = await HttpUtil(context).request(
      '/posts',
      method: HttpUtil.GET
    );

    if(res == null){
      return;
    }

    if(res['result'] != 100){
      MyDialog.show(
        context,
        content: '请求失败',
        isHideCancel: true,
      );
    }else{
      var data = res['data'];
      setState(() {
        _lists = data['list'];
      });
    }
  }

  Widget _buildLitsItem(item) {
    final _articleId = item['id'];
    final _title = item['title'];
    final _subTitle = item['subTitle'];
    final _picUrl = item['coverPicUrl'];
    final _likeNum = item['likeNum'];
    final _content = item['content'];

    return ListItemTile(
      articleId: _articleId,
      title: _title,
      subTitle: _subTitle,
      content: _content,
      picUrl: _picUrl,
      likeNum: _likeNum,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('浪漫旅行'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.supervised_user_circle),
                tooltip: 'Add entry',
                onPressed: () {
                  Navigator.pushNamed(context, '/userInfo');
                },
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if(_lists == null){
                    return Text('loading');
                  }else if(_lists.length == 0){
                    return Text('暂时没有内容哦~快记录您的第一篇游记吧');
                  }else{
                    return _buildLitsItem(_lists[index]);
                  }
                },
                childCount: (_lists == null || _lists.length == 0) ? 1 : _lists.length,
              ),
            ),
          ),
        ],
      ),
      color: Colors.grey[300],
    );
  }
}