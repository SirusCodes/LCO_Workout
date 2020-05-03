import 'package:flutter/material.dart';
import 'package:lco_workout/widgets/cneubutton.dart';

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
            buildCard(context, "GitHub", _size),
            buildCard(context, "About", _size),
          ],
        ),
      ),
    );
  }

  Padding buildCard(BuildContext context, String title, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CNeuButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {},
        child: SizedBox(
          height: size.height / 15,
          width: size.width,
          child: Center(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .primaryTextTheme
                  .display1
                  .copyWith(fontSize: size.height / 30),
            ),
          ),
        ),
      ),
    );
  }
}
