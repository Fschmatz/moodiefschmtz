import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:moodiefschmtz/db/moodDao.dart';
import 'configs/configs.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  final db = MoodDao.instance;
  List<Map<String, dynamic>> moods = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getAllMoods();
  }

  Future<void> getAllMoods() async {
    var resp = await db.queryAllRowsDesc();
    setState(() {
      moods = resp;
    });
    print(moods.length.toString());
  }

  void _saveMood(String name, String color) async {
    Map<String, dynamic> row = {
      MoodDao.columnName: name,
      MoodDao.columnColor: color,
      MoodDao.columnDate: " ",
    };
    final id = await db.insert(row);
    getAllMoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Moodie"), elevation: 2, actions: <Widget>[
        IconButton(
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
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: moods.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Color(int.parse(moods[index]['color'].substring(6, 16))),
                    );
                  }),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),


      floatingActionButton: BoomMenu(
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
            backgroundColor: Color(0xFF4CAF50).withOpacity(0.9),
            onTap: () => _saveMood("Good", "Color(0xFF4CAF50)"),
          ),
          MenuItem(
            child: Icon(Icons.thumbs_up_down_outlined, color: Colors.black87),
            title: "Medium",
            titleColor: Colors.black87,
            subtitle: "Not Good, Nor Bad",
            subTitleColor: Colors.black87,
            backgroundColor: Color(0xFFFDD835).withOpacity(0.9),
            onTap: () => _saveMood("Medium", "Color(0xFFFDD835)"),
          ),
          MenuItem(
            child: Icon(Icons.thumb_down_alt_outlined, color: Colors.black87),
            title: "Bad",
            titleColor: Colors.black87,
            subtitle: "Not Good",
            subTitleColor: Colors.black87,
            backgroundColor: Color(0xFFFF5252).withOpacity(0.9),
            onTap: () => _saveMood("Bad", "Color(0xFFFF5252)"),
          ),
        ],
      ),
    );
  }
}

//https://pub.dev/packages/flutter_boom_menu
//Theme.of(context).textTheme.headline6.color)
