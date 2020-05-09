import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lco_workout/animation_locator.dart';
import 'package:lco_workout/constants.dart';
import 'package:lco_workout/enum/rep_count.dart';
import 'package:lco_workout/get_it/animation_getit.dart';
import 'package:lco_workout/screen/sets_screen.dart';
import 'package:lco_workout/widgets/cneu_radio_button.dart';
import 'package:lco_workout/widgets/cneubutton.dart';
import 'package:lco_workout/widgets/shimmer_button.dart';

class RepCountScreen extends StatefulWidget {
  RepCountScreen({Key key, this.timeList}) : super(key: key);

  final List<int> timeList;

  @override
  _RepCountScreenState createState() => _RepCountScreenState();
}

class _RepCountScreenState extends State<RepCountScreen> {
  final _getIt = locator<AnimationGetIt>();

  RepCount _count = RepCount.count10;

  List<String> _exerList = [], _rawList = [];
  List<int> _timeList = List<int>();

  int _currentView = 0;
  int _currentRep = 10;

  @override
  void initState() {
    super.initState();
    _exerList = List.from(_getIt.exerciseList);
    _rawList = List.from(_getIt.rawList);
  }

  @override
  Widget build(BuildContext context) {
    final _heightFact = MediaQuery.of(context).size.height / 10;
    return Material(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: IconButton(
                    splashColor: Theme.of(context).buttonColor,
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).buttonColor,
                      size: _heightFact * .6,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: ImageAndName(
                  key: ValueKey<String>(_exerList[_currentView]),
                  raw: _rawList[_currentView],
                  exer: _exerList[_currentView],
                  heightFact: _heightFact,
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Number of Reps: $_currentRep",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline1
                          .copyWith(fontSize: _heightFact / 2),
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildNeumorphicRadio(context, "05", RepCount.count5),
                          buildNeumorphicRadio(context, "10", RepCount.count10),
                          buildNeumorphicRadio(context, "15", RepCount.count15),
                          buildNeumorphicRadio(context, "20", RepCount.count20),
                          buildNeumorphicRadio(context, "25", RepCount.count25),
                          buildNeumorphicRadio(context, "??", RepCount.custom),
                        ],
                      ),
                    ),
                  ],
                )),
            Expanded(
              child: ShimmerButton(
                height: _heightFact,
                text: _currentView < 4 ? "Next >" : "Select number of set >",
                delay: 0,
                onPressed: () {
                  int _time;
                  // add to time list
                  if (_currentView < 5)
                    _time = _currentRep * widget.timeList[_currentView];

                  _timeList.add(_time);

                  _ifSkip();

                  if (_currentView < 4) {
                    setState(() {
                      // reset
                      _count = RepCount.count10;
                      _currentRep = 10;
                      // next exercise
                      ++_currentView;
                    });
                  } else {
                    _timeList.forEach((f) => print(f));
                    _getIt.setTime = _timeList;
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => SetsScreen()));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildNeumorphicRadio(BuildContext context, String count, RepCount value,
      {EdgeInsets padding = const EdgeInsets.all(2.0)}) {
    return Padding(
      padding: padding,
      child: CNeumorphicRadio(
        value: value,
        groupValue: _count,
        boxShape: NeumorphicBoxShape.circle(),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              count,
              style: Theme.of(context)
                  .primaryTextTheme
                  .headline1
                  .copyWith(fontSize: 30),
            ),
          ),
        ),
        onChanged: (value) {
          if (value == RepCount.custom) _showDialog();

          setState(() {
            _count = value;
            if (value != RepCount.custom) _currentRep = int.parse(count);
          });
        },
        style: NeumorphicRadioStyle(
          selectedDepth: -10,
          unselectedDepth: 10,
        ),
      ),
    );
  }

  _showDialog() {
    final border = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).buttonColor,
      ),
    );
    int _rep = 0;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Enter number of Reps"),
          content: TextField(
            cursorColor: Theme.of(context).buttonColor,
            style: TextStyle(
              color: Theme.of(context).buttonColor,
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),
            decoration: InputDecoration(
              focusColor: Theme.of(context).buttonColor,
              labelText: "Rep",
              border: border,
              focusedBorder: border,
              labelStyle: TextStyle(
                color: Theme.of(context).buttonColor,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              _rep = int.parse(value);
            },
          ),
          actions: <Widget>[
            CNeuButton(
              child: Text(
                "Done",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  _currentRep = _rep;
                });
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  _ifSkip() {
    if (_currentView < 4 && widget.timeList[_currentView + 1] == 0) {
      _currentView++;
      _timeList.add(60);
    }
  }
}

class ImageAndName extends StatelessWidget {
  const ImageAndName({
    Key key,
    @required String raw,
    @required String exer,
    @required double heightFact,
  })  : _raw = raw,
        _exer = exer,
        _heightFact = heightFact,
        super(key: key);

  final String _raw;
  final String _exer;
  final double _heightFact;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Image.asset(
            "assets/images/" + _raw,
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FittedBox(
              child: Column(
                children: <Widget>[
                  Text(
                    _exer,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline1
                        .copyWith(fontSize: _heightFact),
                  ),
                  Text(
                    "Seconds assigned per rep: " +
                        DEFAULT_TIME[_raw].toString(),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline1
                        .copyWith(fontSize: _heightFact / 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
