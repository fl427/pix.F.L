import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'container/image_picker_page.dart';

// 改变方向，做一个自己的应用，不依赖第三方
// 上传图片，然后图片在首页以瀑布流的形式表现出来
// 后续支持登录与同步
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.amber,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        "image_picker_page": (context) => ImagePickerPage(),
      },
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List tabs = ['我的收藏', '所有图片'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('流式布局'),
        // 更改默认抽屉图像
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.dashboard, color: Colors.white),
              onPressed: () {
                // 打开抽屉菜单
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((tab) => Tab(text: tab)).toList(),
          indicatorSize: TabBarIndicatorSize.label,
        ),
      ),
      drawer: SideDrawer(),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('image_picker_page');
        },
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            SizedBox(),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((tab) {
          return KeepAliveWrapper(
            child: Page(
              content: tab,
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

// 子页面
class Page extends StatefulWidget {
  const Page({Key? key, required this.content}) : super(key: key);
  final String content;
  @override
  _PageState createState() => _PageState();
}

// 页面缓存，不做这一步的话每次滑动页面就会重新加载
class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        widget.content,
        textScaleFactor: 3,
      ),
    );
  }

  @override
  void dispose() {
    print('page dispose');
    super.dispose();
  }
}

// code source: https://book.flutterchina.club/chapter6/keepalive.html#_6-8-2-keepalivewrapper
class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({Key? key, this.keepAlive = true, required this.child})
      : super(key: key);
  final bool keepAlive;
  final Widget child;
  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      // keepAlive状态更新
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  // 页面不显示是保存在内存中
  @override
  bool get wantKeepAlive => widget.keepAlive;
}

// 侧边栏抽屉
class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 38, left: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.cyanAccent,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1641574280142-b39f3e9457cf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxOHx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60')),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1641576369369-870158b0d11b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('fl427'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('个人主页'),
                  ),
                  ListTile(
                    leading: Icon(Icons.download),
                    title: Text('下载管理'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
