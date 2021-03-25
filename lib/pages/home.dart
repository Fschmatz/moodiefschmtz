import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'configs/configs.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Moodie"),
        elevation: 2,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: IconButton(
                  icon: Icon(
                    Icons.settings,
                    size: 24,
                  ),
                  tooltip: "Settings",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => Configs(),
                          fullscreenDialog: true,
                        ));
                  }),
            ),

          ]
      ),
      body:  GridView.count(
        crossAxisCount: 4,
        children: List.generate(50, (index) {
          return Center(
            child: Text(
              'Item $index',
            ),
          );
        }),
      ),


      floatingActionButton:  BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        marginBottom: 15,
        children: [
          MenuItem(
            child: Icon(Icons.thumb_up_alt_outlined, color: Colors.black87),
            title: "Good",
            titleColor: Colors.black87,
            subtitle: "Fine !!! ",
            subTitleColor: Colors.black87,
            backgroundColor: Colors.green.withOpacity(0.9),
            onTap: () => print('FIRST CHILD'),
          ),
          MenuItem(
            child: Icon(Icons.thumbs_up_down_outlined, color: Colors.black87),
            title: "Medium",
            titleColor: Colors.black87,
            subtitle: "Not Good, Nor Bad",
            subTitleColor: Colors.black87,
            backgroundColor: Colors.yellow[600].withOpacity(0.9),
            onTap: () => print('SECOND CHILD'),
          ),
          MenuItem(
            child: Icon(Icons.thumb_down_alt_outlined, color: Colors.black87),
            title: "Bad",
            titleColor: Colors.black87,
            subtitle: "Not Good",
            subTitleColor: Colors.black87,
            backgroundColor: Colors.redAccent.withOpacity(0.9),
            onTap: () => print('THIRD CHILD'),
          ),

        ],
      ),
    );
  }
}

//https://pub.dev/packages/flutter_boom_menu
//Theme.of(context).textTheme.headline6.color)