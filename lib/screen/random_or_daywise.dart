import 'package:flutter/material.dart';
import 'package:lco_workout/get_it/drawer_getit.dart';
import 'package:lco_workout/screen/daywise_screen.dart';
import 'package:lco_workout/screen/main_screen.dart';
import 'package:lco_workout/widgets/shimmer_button.dart';

import '../animation_locator.dart';

class RandomOrDaywise extends StatelessWidget {
  const RandomOrDaywise({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _drawer = locator<DrawerGetIt>();

    final _size = MediaQuery.of(context).size;
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FittedBox(
                  fit: BoxFit.cover,
                  child: IconButton(
                    icon: Icon(
                      Icons.dehaze,
                      color: Theme.of(context).buttonColor,
                      size: _size.height / 20,
                    ),
                    onPressed: () {
                      _drawer.animateDrawer();
                    },
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Image.asset("assets/logo.png"),
          Spacer(),
          ShimmerButton(
            height: _size.height / 10,
            delay: 0.0,
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            text: "Random",
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => MainPage())),
          ),
          ShimmerButton(
            delay: 0.3,
            height: _size.height / 10,
            text: "Daywise",
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => DaywiseScreen())),
          )
        ],
      ),
    );
  }
}
