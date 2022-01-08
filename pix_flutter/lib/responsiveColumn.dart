import 'package:flutter/material.dart';

class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxHeight < 200) {
          return Column(
            children: children,
            mainAxisSize: MainAxisSize.min,
          );
        } else {
          var _children = <Widget>[];
          for (var i = 0; i < children.length; i += 2) {
            if (i + 1 < children.length) {
              _children.add(Row(
                children: [children[i], children[i + 1]],
                mainAxisSize: MainAxisSize.min,
              ));
            } else {
              _children.add(children[i]);
            }
          }
          return Column(
            children: _children,
            mainAxisSize: MainAxisSize.min,
          );
        }
      },
    );
  }
}

class LayoutBuilderRoute extends StatelessWidget {
  const LayoutBuilderRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _children = List.filled(6, Text('A'));
    return Column(
      children: [
        SizedBox(
          width: 100,
          child: ResponsiveColumn(children: _children),
        ),
        ResponsiveColumn(children: _children),
        LayoutLogPrint(child: Text('xx')),
      ],
    );
  }
}

class LayoutLogPrint<T> extends StatelessWidget {
  const LayoutLogPrint({Key? key, this.tag, required this.child})
      : super(key: key);

  final Widget child;
  final T? tag;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      assert(() {
        print('${tag ?? key ?? child}: $constraints');
        return true;
      }());
      return child;
    });
  }
}
