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

  CardStatus _previousStatus;

  @override
  void initState() {
    _animation.editList();
    _animation.getMusic();
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
                    children: <Widget>[
                      Expanded(
                        child: IconButton(
                          alignment: Alignment.centerLeft,
                          splashColor: Theme.of(context).buttonColor,
                          icon: Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).buttonColor,
                            size: _heightFact * .6,
                          ),
                          onPressed: () {
                            if (_animation.status == CardStatus.end)
                              Navigator.pop(context);
                            return _showDialog(fromAppBar: true);
                          },
                        ),
                      ),
                      Expanded(
                        child: Consumer<AnimationGetIt>(
                          builder: (_, _anim, __) {
                            return Text(
                              "${_anim.currentSet + 1}/${_anim.setNum}",
                              textAlign: TextAlign.center,
                              style:
                                  Theme.of(context).primaryTextTheme.headline1,
                            );
                          },
                        ),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: MainCard(
                    heightFact: _heightFact,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<AnimationGetIt>(
                      builder: (_, provider, __) {
                        if (provider.status != CardStatus.end)
                          return FittedBox(
                            child: Text(
                              "Next: ${provider.nextExer}",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline1
                                  .copyWith(
                                    fontSize: _heightFact * .5,
                                    color: Color(0xFAff817a),
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        return Container();
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

  Future<bool> _showDialog({bool fromAppBar = false}) {
    if (_animation.status == CardStatus.end) {
      return Future.value(true);
    }
    _previousStatus = _animation.getState;
    _animation.setState = CardStatus.paused;
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              _animation.setState = _previousStatus;
              return true;
            },
            child: AlertDialog(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text("Come on you can do it!!!"),
              actions: <Widget>[
                alertButton(context, "No, I have work", true,
                    fromAppBar: fromAppBar),
                alertButton(context, "Yes, I can", false),
              ],
            ),
          );
        });
  }

  CNeuButton alertButton(BuildContext context, String text, bool rtrn,
      {bool fromAppBar = false}) {
    return CNeuButton(
      child: Text(
        text,
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
      onPressed: () {
        if (!rtrn) _animation.setState = _previousStatus;
        if (fromAppBar) Navigator.pop(context);
        if (rtrn) _animation.setState = CardStatus.end;
        return Navigator.pop(context, rtrn);
      },
    );
  }
}
