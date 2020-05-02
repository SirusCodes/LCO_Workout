import 'package:flutter/material.dart';
import 'package:lco_workout/animation_locator.dart';
import 'package:lco_workout/enum/card_status.dart';
import 'package:lco_workout/get_it/animation_getit.dart';
import 'package:lco_workout/widgets/cneubutton.dart';
import 'package:lco_workout/widgets/main_card.dart';
import 'package:provider/provider.dart';

class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({Key key}) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  var _animation = locator<AnimationGetIt>();

  @override
  void initState() {
    _animation.editList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _heightFact = MediaQuery.of(context).size.height / 10;
    return WillPopScope(
      onWillPop: _showDialog,
      child: Scaffold(
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[Image.asset("assets/logo.png")],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: MainCard(
                    heightFact: _heightFact,
                  ),
                ),
                if (_animation.status != CardStatus.end)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer<AnimationGetIt>(
                        builder: (_, provider, __) {
                          return Text(
                            "Next: ${provider.nextExer}",
                            style: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .copyWith(
                                  fontSize: _heightFact * .5,
                                  color: Color(0xFAff817a),
                                ),
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showDialog() {
    if (_animation.status == CardStatus.end) {
      return Future.value(Navigator.pop(context, true));
    }
    _animation.status = CardStatus.paused;
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              _animation.status = CardStatus.progress;
              return true;
            },
            child: AlertDialog(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text("Come on you can do it!!!"),
              actions: <Widget>[
                alertButton(context, "No, I have work", true),
                alertButton(context, "Yes, I can", false),
              ],
            ),
          );
        });
  }

  CNeuButton alertButton(BuildContext context, String text, bool rtrn) {
    return CNeuButton(
      child: Text(
        text,
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
      onPressed: () => Navigator.pop(context, rtrn),
    );
  }
}
