import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _heightFact = MediaQuery.of(context).size.height / 10;
    return Material(
      child: Column(
        children: <Widget>[
          Expanded(
            child: appBar(context, _heightFact),
          ),
          Expanded(
            flex: 7,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: imgNName(context, _heightFact),
                ),
                Divider(
                  indent: 30,
                  endIndent: 30,
                  color: Theme.of(context).buttonColor,
                  thickness: 1,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            buildSocialButton(
                              context,
                              "assets/images/Twitter_Logo.png",
                              () {},
                            ),
                            buildSocialButton(
                              context,
                              "assets/images/GitHub-Mark.png",
                              () {},
                            ),
                            buildSocialButton(
                              context,
                              "assets/images/LinkedIn_Logo.png",
                              () {},
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 1, child: Container())
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  NeumorphicButton buildSocialButton(
      BuildContext context, String image, Function onPressed) {
    return NeumorphicButton(
      boxShape: NeumorphicBoxShape.circle(),
      style: NeumorphicStyle(
        color: Theme.of(context).primaryColor,
      ),
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            image,
            height: 50,
          ),
        ),
      ),
      onClick: onPressed,
    );
  }

  Column imgNName(BuildContext context, double _heightFact) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Hero(
            tag: "About",
            child: FittedBox(
              fit: BoxFit.cover,
              child: CircleAvatar(
                minRadius: 5,
                backgroundImage: AssetImage("assets/images/darshan_small.jpg"),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Center(
              child: Text(
                "Darshan Rander",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .primaryTextTheme
                    .display1
                    .copyWith(fontSize: _heightFact / 2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row appBar(BuildContext context, double _heightFact) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Expanded(
          child: Text(
            "About",
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.display1,
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }
}
