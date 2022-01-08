import 'package:flutter/material.dart';

class TestClass extends StatefulWidget {
  const TestClass({Key? key}) : super(key: key);

  @override
  _TestClassState createState() => _TestClassState();
}

class _TestClassState extends State<TestClass> {
  @override
  Widget build(BuildContext context) {
    var m = fromMap<Params>({'a': 1, 'b': 2});
    return Container(
      child: Text(m.params.message ?? ''),
    );
  }
}

class A {
  String? name;
}

abstract class Params {
  String? message;
}

// 约定JavaScript调用方法时的统一模板
class JSModel<T> {
  String method; // 方法名
  T params; // 参数

  JSModel(this.method, this.params);

  // 实现jsonEncode方法中会调用实体类的toJSON方法
  Map toJson() {
    Map map = new Map();
    map["method"] = this.method;
    map["params"] = this.params;
    return map;
  }

  // 将JS传过来的JSON字符串转换成MAP,然后初始化Model实例
  static JSModel fromMap<T>(Map<String, dynamic> map) {
    JSModel model = new JSModel(map['method'], map['params']);
    return model;
  }

  @override
  String toString() {
    return "JSModel: {method: $method, params: $params}";
  }
}

JSModel<T> fromMap<T>(Map<String, dynamic> map) {
  JSModel<T> model = new JSModel(map['method'], map['params']);
  return model;
}
