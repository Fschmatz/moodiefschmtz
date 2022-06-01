import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:moodiefschmtz/db/mood.dart';
import 'package:moodiefschmtz/db/mood_dao.dart';
import 'package:moodiefschmtz/widgets/mood_card.dart';
import 'package:moodiefschmtz/widgets/pie.dart';
import 'configs/settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final db = MoodDao.instance;
  List<Map<String, dynamic>> moods = [];
  bool _loading = true;

  late int countGood;
  late int countMedium;
  late int countBad;

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
    appStart(false);
    super.initState();
  }

  Future<void> appStart([bool showAnim = true]) async {
    if (showAnim) {
      setState(() {
        _loading = true;
      });
    }
    await getAllCounts();
    await getAllMoods();
  }

  Future<void> getAllMoods() async {
    var resp = await db.queryAllRowsDesc();
    setState(() {
      moods = resp;
      _loading = false;
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
    Map<String, dynamic> row = {
      MoodDao.columnName: name,
      MoodDao.columnColor: color,
      MoodDao.columnMonthYear: getFormattedDate(),
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

  String getFormattedDate() {
    return Jiffy(DateTime.now()).yMMMM;
  }

  void bottomMenuAddMood(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16.0),
              topRight: const Radius.circular(16.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: ListTile(
                    title: Text(
                      "Choose Mood:",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 15),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 15),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 40),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
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
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moodie'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings_outlined,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Settings(),
                    )).then((value) => appStart());
              }),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Pie(dataMap),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: _loading
                ? Center(
                    child: SizedBox.shrink(),
                  )
                : ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        moods.isEmpty
                            ? Text(
                                getFormattedDate(),
                              )
                            : Text(moods[(moods.length - 1)]['monthYear']),
                        moods.length == 1
                            ? Text(
                                moods.length.toString() + " Day",
                              )
                            : Text(
                                moods.length.toString() + " Days",
                              ),
                      ],
                    ),
                  ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: _loading
                ? Center(
                    child: SizedBox.shrink(),
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: GridView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: moods.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return MoodCard(
                            key: UniqueKey(),
                            mood: new Mood(
                              idMood: moods[index]['id_mood'],
                              name: moods[index]['name'],
                              color: moods[index]['color'],
                             monthYear: moods[index]['monthYear']
                            ),
                            delete: _delete,
                          );
                        }),
                  ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bottomMenuAddMood(context);
        },
        child: Icon(
          Icons.add_outlined,
          color: Theme.of(context).textTheme.headline6!.color,
        ),
      ),
    );
  }
}
