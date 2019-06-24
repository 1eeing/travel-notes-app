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
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        getRequestList(pageNo: _pageNo + 1, pageSize: _pageSize, isRefresh: false);
      }
    });
    getRequestList();
  }

  List _lists;
  int _pageNo = 1;
  int _pageSize = 10;
  bool _locked = false;

  ScrollController scrollController = ScrollController();

  void getRequestList({pageNo = 1, pageSize = 10, isRefresh = true}) async {
    if(_locked) return;
    setState(() => _locked = true);
    var res = await HttpUtil(context).request(
      '/posts?pageNo=$pageNo&pageSize=$pageSize',
      method: HttpUtil.GET,
    );
    setState(() => _locked = false);

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
      List newList = data['list'];
      setState(() {
        if(isRefresh){
          _lists = newList;
          _pageNo = 1;
          _pageSize = 10;
        }else if(newList.length != 0){
          _lists.addAll(newList);
          _pageNo = int.parse(data['pageNo']);
          _pageSize = int.parse(data['pageSize']);
        }
      });
    }
  }

  Future<Null> _refresh() async {
    getRequestList();
    return;
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

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: _locked ? 1.0 : 0.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: CustomScrollView(
          controller: scrollController,
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
                    }else if(index == _lists.length){
                      return _buildProgressIndicator();
                    }else{
                      return _buildLitsItem(_lists[index]);
                    }
                  },
                  childCount: (_lists == null || _lists.length == 0) ? 1 : _lists.length + 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}