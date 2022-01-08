import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'container/image_page.dart';

import 'common/utils/image_picker_methods.dart';
import 'common/provider/image_list_provider.dart';
import 'common/widget/keepalive_wrapper.dart';
import 'common/widget/sidedrawer.dart';

// 改变方向，做一个自己的应用，不依赖第三方
// 上传图片，然后图片在首页以瀑布流的形式表现出来
// 后续支持登录与同步

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ImageFileListNotifier(),
        )
      ],
      child: MyApp(),
    ),
  );
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
        // "image_picker_page": (context) => ImagePickerPage(key: imagePickerKey),
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
          // 选择图片
          ImagePickerMethods().getImageFromStorage(
              context.read<ImageFileListNotifier>().setImageFileList);
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
            child: ImagePage(
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
