import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:intl/intl.dart';
import 'package:moodiefschmtz/db/mood.dart';
import 'package:moodiefschmtz/db/moodDao.dart';
import 'package:moodiefschmtz/widgets/moodCard.dart';
import 'configs/configs.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  final db = MoodDao.instance;
  List<Map<String, dynamic>> moods = [];
  String formattedDateOnlyDay = " ";

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getAllMoods();

    var now = new DateTime.now();
    var formatter = new DateFormat('dd');
    formattedDateOnlyDay = formatter.format(now);
  }

  Future<void> getAllMoods() async {
    var resp = await db.queryAllRowsDesc();
    setState(() {
      moods = resp;
    });
  }

  void _saveMood(String name, String color) async {
      Map<String, dynamic> row = {
        MoodDao.columnName: name,
        MoodDao.columnColor: color,
        MoodDao.columnDate: formattedDateOnlyDay,
      };
      final id = await db.insert(row);
    getAllMoods();
  }

  void _deletar(int id) async {
    final deletado = await db.delete(id);
    getAllMoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Moodie"), elevation: 0, actions: <Widget>[
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
                    return MoodCard(
                      key: UniqueKey(),
                      mood: new Mood(
                        id_mood:moods[index]['id_mood'],
                        name:moods[index]['name'],
                        color: moods[index]['color'],
                        date: moods[index]['date'],
                      ),
                      delete: _deletar,
                    );
                  }
                  ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),


      floatingActionButton: BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        overlayColor: Colors.black,
        overlayOpacity: 0.6,
        marginBottom: 15,
        fabAlignment: Alignment.center,
        fabPaddingTop: 25,
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
            subtitle: "Problem !!! ",
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
