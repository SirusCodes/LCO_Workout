import 'package:flutter/material.dart';
import 'package:lco_workout/screen/about_screen.dart';
import 'package:lco_workout/widgets/cneubutton.dart';
import 'package:url_launcher/url_launcher.dart';

class CDrawer extends StatelessWidget {
  const CDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).buttonColor,
      ),
      child: FittedBox(
        child: Column(
          children: <Widget>[
            buildCard(
              context,
              title: "Source Code",
              size: _size,
              onPressed: () =>
                  _launchURL("https://github.com/SirusCodes/LCO_Workout"),
              image: Image.asset("assets/images/OpenSource_Logo_BnW.png"),
            ),
            buildCard(
              context,
              title: "About",
              size: _size,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AboutScreen(),
                ),
              ),
              image: Hero(
                tag: "About",
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/darshan_small.jpg"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildCard(
    BuildContext context, {
    String title,
    Size size,
    Function onPressed,
    Widget image,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CNeuButton(
        intensity: .5,
        color: Theme.of(context).primaryColor,
        onPressed: onPressed,
        child: SizedBox(
          height: size.height / 15,
          width: size.width,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              image,
              SizedBox(width: 20),
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline1
                    .copyWith(fontSize: size.height / 30),
              ),
            ],
          )),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
