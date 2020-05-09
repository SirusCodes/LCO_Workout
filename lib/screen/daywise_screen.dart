import 'package:flutter/material.dart';
import 'package:lco_workout/animations/fade_slide.dart';
import 'package:lco_workout/constants.dart';
import 'package:lco_workout/screen/main_screen.dart';
import 'package:lco_workout/widgets/cneubutton.dart';

class DaywiseScreen extends StatelessWidget {
  const DaywiseScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayList = [
      "Leg day",
      "Chest day",
      "Back day",
      "Arms day",
      "Shoulder day"
    ];
    final _size = MediaQuery.of(context).size;
    return Material(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                FittedBox(
                  child: IconButton(
                    splashColor: Theme.of(context).buttonColor,
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).buttonColor,
                      size: _size.height / 10 * .6,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox.expand(
                child: FittedBox(
                  child: Text(
                    "What's your to-day?",
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline1
                        .copyWith(fontSize: _size.height / 10 * .5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                children: <Widget>[
                  FadeSlide(
                    delay: 1.5,
                    child: buildCard(context, dayList[0], _size,
                        onPressed: () => navigateToMainScreen(legDay, context)),
                    leftToRight: true,
                  ),
                  FadeSlide(
                    delay: 1.7,
                    child: buildCard(context, dayList[1], _size,
                        onPressed: () =>
                            navigateToMainScreen(chestDay, context)),
                    leftToRight: true,
                  ),
                  FadeSlide(
                    delay: 2.0,
                    child: buildCard(context, dayList[2], _size,
                        onPressed: () =>
                            navigateToMainScreen(backDay, context)),
                    leftToRight: true,
                  ),
                  FadeSlide(
                    delay: 2.3,
                    child: buildCard(context, dayList[3], _size,
                        onPressed: () => navigateToMainScreen(armDay, context)),
                    leftToRight: true,
                  ),
                  FadeSlide(
                    delay: 2.6,
                    child: buildCard(context, dayList[4], _size,
                        onPressed: () =>
                            navigateToMainScreen(shoulderDay, context)),
                    leftToRight: true,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }

  navigateToMainScreen(List<String> exercise, BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MainPage(
          list: exercise,
        ),
      ),
    );
  }

  Padding buildCard(BuildContext context, String title, Size size,
      {Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CNeuButton(
        color: Theme.of(context).primaryColor,
        onPressed: onPressed,
        child: SizedBox(
          height: size.height / 15,
          width: size.width,
          child: Center(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .primaryTextTheme
                  .headline1
                  .copyWith(fontSize: size.height / 30),
            ),
          ),
        ),
      ),
    );
  }
}
