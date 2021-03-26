import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodiefschmtz/db/mood.dart';
import 'package:moodiefschmtz/db/moodDao.dart';
import 'package:moodiefschmtz/widgets/moodCard.dart';
import 'configs/configs.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  final db = MoodDao.instance;
  List<Map<String, dynamic>> moods = [];
  String formattedDateOnlyDay = " ";
  List<Map<String, dynamic>> moodsEmptyAnim = [];


  @override
  void initState() {
    super.initState();
    getAllMoods();
  }

  getAllMoods() async {
    var resp = await db.queryAllRowsDesc();
    setState(() {
      moods = resp;
    });
  }

  void _saveMood(String name, String color) async {

    var now = new DateTime.now();
    var formatter = new DateFormat('dd');
    formattedDateOnlyDay = formatter.format(now);

    Map<String, dynamic> row = {
      MoodDao.columnName: name,
      MoodDao.columnColor: color,
      MoodDao.columnDate: formattedDateOnlyDay,
    };
    final id = await db.insert(row);
    Timer( Duration(seconds: 1), getAllMoods());
  }

  void _delete(int id) async {
    final deletado = await db.delete(id);
    Timer( Duration(seconds: 1), getAllMoods());
  }

  //BOTTOM MENU
  void bottomMenu(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 45, 40, 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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
                        setState(() {
                          moods = moodsEmptyAnim;
                        });
                        _saveMood("Good", "Color(0xFF4CAF50)");
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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
                        setState(() {
                          moods = moodsEmptyAnim;
                        });
                        _saveMood("Medium", "Color(0xFFFDD835)");
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 50),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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
                        "Problem !!!",
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                      onTap: () {
                        setState(() {
                          moods = moodsEmptyAnim;
                        });
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
      appBar:AppBar(
        title:Text("Moodie"),
        elevation: 0,
      ) ,
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
                      crossAxisCount: 6,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList (
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: MoodCard(
                              key: UniqueKey(),
                              mood: new Mood(
                                id_mood: moods[index]['id_mood'],
                                name: moods[index]['name'],
                                color: moods[index]['color'],
                                date: moods[index]['date'],
                              ),
                              delete: _delete,
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).accentColor,
              elevation: 0.0,
              onPressed: () {
                bottomMenu(context);
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
                    icon: Icon(
                      Icons.settings_outlined,
                      size: 23,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => Configs(),
                            fullscreenDialog: true,
                          ));
                    }),
              ])),
        ));
  }
}

//Theme.of(context).textTheme.headline6.color)
