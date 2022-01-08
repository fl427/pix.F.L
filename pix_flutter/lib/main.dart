import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './tapBox.dart';
import './route.dart';
import './login.dart';
import './listView.dart';
import './gridView.dart';

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
        primaryColor: Colors.grey[10],
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        "new_page": (context) => NewRoute(),
        "echo_page": (context) => EchoRoute(),
        "login_page": (context) => Login(),
        "infinite_page": (context) => InfiniteListView(),
        "infinite_page_notice": (context) => ScrollNotificationTestRoute(),
      },
      home: MyHomePage(title: 'Flutter Demo'),
      // home: CupertinoTestRoute(),
    );
  }
}

class CupertinoTestRoute extends StatelessWidget {
  const CupertinoTestRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino Demo'),
      ),
      child: Center(
        child: CupertinoButton(
          color: CupertinoColors.activeBlue,
          child: Text('Press'),
          onPressed: () {},
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onTap(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.grey,
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TapBoxA(),
              ParentWidget(),
              ParentWidgetC(),
              TextButton(
                onPressed: () {
                  // 导航到新的路由
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NewRoute();
                      },
                      fullscreenDialog: false,
                    ),
                  );
                  // 等价于
                  // 这里的of简单理解为：Widget希望暴露内部状态，于是实现了of方法来让外界
                  // 获取内部状态。
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return NewRoute();
                  //     },
                  //     fullscreenDialog: false,
                  //   ),
                  // );
                  // 等价于使用路由表
                  // todo: 给路由表echo_page传参这里有问题
                  Navigator.of(context)
                      .pushNamed("tips_page", arguments: 'Hi Echo');
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.yellowAccent)),
                child: Text("前往新的路由"),
              ),
              RaisedButton(
                onPressed: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return TipRoute(text: '我是传入的参数');
                      },
                    ),
                  );
                  print('输出TipRoute路由返回结果$result');
                },
                child: Text('前往需要路由传参的路由TipRoute'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  '测试文本Widget' * 4,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1.5,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton.icon(
                    icon: Icon(Icons.send),
                    label: Text("前往登录页"),
                    onPressed: () {
                      Navigator.pushNamed(context, "login_page");
                    },
                  ),
                  OutlineButton.icon(
                    icon: Icon(Icons.add),
                    label: Text("无限列表"),
                    onPressed: () {
                      Navigator.pushNamed(context, "infinite_page");
                    },
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.info),
                    label: Text("详情"),
                    onPressed: () {
                      Navigator.pushNamed(context, "infinite_page_notice");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton.icon(
                    label: Text("GridView"),
                    icon: Icon(Icons.info),
                    onPressed: () {},
                  ),
                ],
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                  minHeight: 400.0,
                ),
                child: Container(
                  height: 5.0, // 父级限制minHeight导致这里的设置被无视
                  child: redBox,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "您的登录密码",
                    prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "用户名或邮箱",
                    prefixIcon: Icon(Icons.person),
                  ),
                  // obscureText: true,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        currentIndex: _selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: '收藏'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }

  Widget redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: MediaQuery.removePadding(
          context: context,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      child: Image.asset(
                        './images/IMG_2946.JPG',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      radius: 30,
                    ),
                    Text(
                      'Hello Demo2',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Person'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
