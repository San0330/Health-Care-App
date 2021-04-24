import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/doctors/doctor.dart';
import '../../../infrastructure/core/api_constants.dart';
import '../../doctor_page/doctor_page.dart';

class DoctorsGrid extends StatelessWidget {
  final Doctor doctor;

  const DoctorsGrid({Key key, this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 3.0),
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              ApiConstants.imageUrl(doctor.image),
            ),
            radius: 40,
          ),
          const SizedBox(height: 10.0),
          Text(
            doctor.name,
            style: const TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 10.0),
          Text(
            doctor.field,
            style: const TextStyle(fontSize: 15.0, color: Colors.grey),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                DoctorPage.routeName,
                arguments: doctor,
              ),
              child: Container(                
                height: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'View',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
