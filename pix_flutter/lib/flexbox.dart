import 'package:flutter/material.dart';

class FlexLayoutTestRoute extends StatelessWidget {
  const FlexLayoutTestRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flex'),
      ),
      body: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(height: 30.0, color: Colors.red),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 50.0,
                  color: Colors.green,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: SizedBox(
              height: 100.0,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 30.0,
                      color: Colors.grey,
                    ),
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: 1,
                    child: Container(height: 30.0, color: Colors.yellow),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 20.0,
              runSpacing: 12.0,
              alignment: WrapAlignment.center,
              children: <Widget>[
                Chip(
                  label: Text('Hamilton'),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('A'),
                  ),
                ),
                Chip(
                  label: Text('Hamilton'),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('B'),
                  ),
                ),
                Chip(
                  label: Text('Hamilton'),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('C'),
                  ),
                ),
                Chip(
                  label: Text('Hamilton'),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('D'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
