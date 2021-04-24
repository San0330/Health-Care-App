import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/utils.dart';
import '../../../diagnosis_page/diagnosis.dart';
import '../../../doctors_list_page/doctors.dart';
import '../../../health_calc/health_calc.dart';
import '../../../products_page/products.dart';
import '../../../res/res.dart';

class Menus extends StatelessWidget {
  const Menus();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.backgroundColor2,
      margin: const EdgeInsets.all(5),
      elevation: 5,
      child: SizedBox(
        height: 300,
        child: GridView.count(
          crossAxisCount: 2,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          childAspectRatio: 1.2,
          children: <Widget>[
            MenuContainer(
              title: "Medical Products",
              icon: Icons.category,
              onTap: () => Navigator.pushNamed(context, ProductsPage.routeName),
            ),
            MenuContainer(
              title: "Appoint Doctor",
              icon: FontAwesomeIcons.userFriends,
              onTap: () => Navigator.pushNamed(context, DoctorsList.routeName),
            ),
            MenuContainer(
              title: "Diagnosis",
              icon: FontAwesomeIcons.diagnoses,
              onTap: () =>
                  Navigator.pushNamed(context, DiagnosisScreen.routeName),
            ),
            MenuContainer(
              title: "Health Stats",
              icon: FontAwesomeIcons.calculator,
              onTap: () =>
                  Navigator.pushNamed(context, HealthCalcPage.routeName),
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
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                    size: 30.0,
                    color: Theme.of(ctx).primaryColor,
                  ),
                ),
                const SizedBox(height: 3.0),
                SizedBox(
                  width: width,
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 5.percentOf(ctx.screenWidth),
                          color: Theme.of(ctx).primaryColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
