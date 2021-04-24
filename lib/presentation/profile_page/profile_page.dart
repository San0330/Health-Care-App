import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pedometer_page/bar_chart.dart';

import '../../application/auth_bloc/auth_bloc.dart';
import '../../application/profile_cubit/profile_cubit.dart';
import '../../infrastructure/core/api_constants.dart';
import '../home_page/widgets/widgets.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/profile-screen';

  const ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: <Widget>[
          PopupMenuButton<int>(
            initialValue: 0,
            offset: const Offset(10, 30),
            onSelected: (index) {
              Navigator.pushNamed(context, EditProfile.routeName);
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 1,
                  child: Text("Edit Profile"),
                ),
              ];
            },
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdateSuccess) {
              context.read<AuthBloc>().add(const CheckAuth());
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final user = (state as Authenticated).authenticatedUser;
              return Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            ApiConstants.imageUrl(user.image),
                          ),
                          radius: 60,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () async {
                              context.read<ProfileCubit>().updateImage();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.withAlpha(150),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              height: 25,
                              width: 120,
                              child: const Text(
                                "Edit image",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      user.name,
                      style: const TextStyle(fontSize: 25.0),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      user.email,
                      style: const TextStyle(fontSize: 20.0),
                    ),
                    const Divider(),
                    const SizedBox(height: 10.0),
                    Text(
                      "Calories burnt data",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(
                      height: 160,
                      child: SimpleBarChart.withSampleData(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
