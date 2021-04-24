import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../manage_orders/view_orders.dart';

import '../manage_product/manage_product.dart';
import '../manage_survey/manage_survey.dart';

class ManagementScreen extends StatelessWidget {
  static String routeName = '/manage-screen';

  const ManagementScreen();

  Widget optionCard({String title, IconData icon, Function ontap}) {
    return GestureDetector(
      onTap: () => ontap(),
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(children: [
              Expanded(
                child: Icon(
                  icon,
                  color: Colors.blue,
                  size: 90.0,
                ),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 20.0, color: Colors.blue),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage")),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: [
          optionCard(
            title: "Product",
            icon: Icons.shop,
            ontap: () => Navigator.pushNamed(context, ManageProduct.routeName),
          ),
          optionCard(
            title: "Survey",
            icon: Icons.reduce_capacity,
            ontap: () => Navigator.pushNamed(context, ManageSurvey.routeName),
          ),
          optionCard(title: "Doctors", icon: FontAwesomeIcons.stethoscope),
          optionCard(title: "Users", icon: Icons.people),
          optionCard(
            title: "Orders",
            icon: Icons.store_mall_directory,
            ontap: () => Navigator.pushNamed(context, ViewAllOrders.routeName),
          ),
        ],
      ),
    );
  }
}
