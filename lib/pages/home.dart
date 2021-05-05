import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moodiefschmtz/db/mood.dart';
import 'package:moodiefschmtz/db/moodDao.dart';
import 'package:moodiefschmtz/widgets/moodCard.dart';
import 'package:moodiefschmtz/widgets/pie.dart';
import 'configs/settings.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final db = MoodDao.instance;
  List<Map<String, dynamic>> moods = [];
  List<Map<String, dynamic>> moodsEmptyAnim = [];

  int countGood;
  int countMedium;
  int countBad;

  Map<String, double> dataMap = {
    'Good': 0,
    'Medium': 0,
    'Bad': 0,
  };

  List<Color> colorList = [
    Color(0xFF4CAF50).withOpacity(0.9),
    Color(0xFFFDD835).withOpacity(0.9),
    Color(0xFFFF5252).withOpacity(0.9),
  ];

  @override
  void initState() {
    super.initState();
    getAllMoods();
    getAllCounts();
  }

  Future<void> getAllMoods() async {
    var resp = await db.queryAllRowsDesc();
    setState(() {
      moods = resp;
    });
  }

  Future<void> getAllCounts() async {
    var respG = await db.queryRowCountByMood('Good');
    var respM = await db.queryRowCountByMood('Medium');
    var respB = await db.queryRowCountByMood('Bad');

    setState(() {
      countGood = respG;
      countMedium = respM;
      countBad = respB;

      dataMap.update('Good', (value) => respG.toDouble());
      dataMap.update('Medium', (value) => respM.toDouble());
      dataMap.update('Bad', (value) => respB.toDouble());
    });
  }

  Future<void> _saveMood(String name, String color) async {
    setState(() {
      moods = moodsEmptyAnim;
    });

    Map<String, dynamic> row = {
      MoodDao.columnName: name,
      MoodDao.columnColor: color,
    };
    final id = await db.insert(row);

    getAllCounts();
    Future.delayed(Duration(milliseconds: 200), () {
      getAllMoods();
    });
  }

  Future<void> _delete(int id) async {
    final deleted = await db.delete(id);
    getAllCounts();
    Future.delayed(Duration(milliseconds: 200), () {
      getAllMoods();
    });
  }

  //BOTTOM MENU
  void bottomMenuAddMood(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 40, 50, 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      dense: true,
                      tileColor: Color(0xFF4CAF50),
                      leading: Icon(Icons.thumb_up_alt_outlined,
                          color: Colors.black87),
                      title: Text(
                        "Good",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Fine !!! ",
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                      onTap: () {
                        _saveMood("Good", "Color(0xFF4CAF50)");
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      dense: true,
                      leading: Icon(Icons.thumbs_up_down_outlined,
                          color: Colors.black87),
                      tileColor: Color(0xFFFDD835),
                      title: Text(
                        "Medium",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Not Good, Nor Bad",
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                      onTap: () {
                        _saveMood("Medium", "Color(0xFFFDD835)");
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      dense: true,
                      leading: Icon(Icons.thumb_down_alt_outlined,
                          color: Colors.black87),
                      tileColor: Color(0xFFFF5252),
                      title: Text(
                        "Bad",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Problems !!!",
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                      onTap: () {
                        _saveMood("Bad", "Color(0xFFFF5252)");
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Moodie"),
              Text(moods.length.toString()+" Days",style: TextStyle(color: Theme.of(context).hintColor),),
            ],
          ),
          elevation: 0,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Pie(dataMap),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: moods.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 200),
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: MoodCard(
                            key: UniqueKey(),
                            mood: new Mood(
                              id_mood: moods[index]['id_mood'],
                              name: moods[index]['name'],
                              color: moods[index]['color'],
                            ),
                            delete: _delete,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
        floatingActionButton: Container(
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).accentColor,
              elevation: 0.0,
              onPressed: () {
                bottomMenuAddMood(context);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          child: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                IconButton(
                    color: Theme.of(context)
                        .textTheme
                        .headline6
                        .color
                        .withOpacity(0.7),
                    icon: Icon(
                      Icons.settings_outlined,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => Settings(),
                            fullscreenDialog: true,
                          ));
                    }),
              ])),
        ));
  }
}
