import 'package:flutter/material.dart';

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
