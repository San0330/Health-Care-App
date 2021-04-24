import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/utils.dart';
import '../bmi_page/bmi_page.dart';
import '../pedometer_page/pedometer_page.dart';

class HealthCalcPage extends StatelessWidget {
  static const routeName = 'health-calc';

  const HealthCalcPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Stat"),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        height: 220,
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            MenuContainer(
              title: "Step Counter",
              icon: FontAwesomeIcons.running,
              onTap:() => Navigator.pushNamed(context, PedometerPage.routeName),
            ),
            MenuContainer(
              title: "BMI",
              icon: Icons.accessibility_outlined,
              onTap: () => Navigator.pushNamed(context, BMIScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuContainer extends StatelessWidget {
  const MenuContainer({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext ctx) {
    final width = 50.percentOf(ctx.screenWidth);

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: width,
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 15.0,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(ctx).primaryColor,
                ),
              ),
              child: Icon(
                icon,
                size: 36.0,
                color: Theme.of(ctx).primaryColor,
              ),
            ),
            SizedBox(
              width: width,
              child: Center(
                child: FittedBox(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 5.percentOf(ctx.screenWidth)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
