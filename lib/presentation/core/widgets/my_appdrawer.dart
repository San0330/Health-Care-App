import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../application/auth_bloc/auth_bloc.dart';
import '../../../infrastructure/core/api_constants.dart';
import '../../../utils/utils.dart';
import '../../admin/management_list/management_list.dart';
import '../../doctor/doctors.dart';
import '../../orders_lists_page/order_lists.dart';
import '../../profile_page/profile_page.dart';
import '../../res/styling.dart';
import '../../surveys/surveys.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final logger = getLogger("AppDrawer")..i("build() called");
    final authBloc = ctx.watch<AuthBloc>();

    final appDrawerListTileTextStyle = AppTheme.appDrawerListTileTextStyle
        .copyWith(fontSize: 6.percentOf(ctx.screenWidth));

    void changePage({@required String destinationPageRouteName}) {
      final String currentPageRouteName = ModalRoute.of(ctx).settings.name;

      // close the drawer
      Navigator.pop(ctx);

      if (currentPageRouteName == '/') {
        Navigator.pushNamed(ctx, destinationPageRouteName);
      } else {
        Navigator.pushReplacementNamed(ctx, destinationPageRouteName);
      }
    }

    return SizedBox(
      width: 75.percentOf(ctx.screenWidth),
      child: Drawer(
        child: Column(
          children: <Widget>[
            BlocBuilder<AuthBloc, AuthState>(
              cubit: authBloc,
              buildWhen: (p, c) => c is Authenticated,
              builder: (ctx, state) {
                logger.i(state);
                if (state is Authenticated) {
                  return UserAccountsDrawerHeader(
                    accountEmail: Text(state.authenticatedUser.email),
                    accountName: Text(state.authenticatedUser.name),
                    currentAccountPicture: const CachedCircleAvatarImage(),
                  );
                } else {
                  logger.w("Unexpected state : $state");
                  return const SizedBox();
                }
              },
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.user,
                color: Theme.of(ctx).primaryColor,
              ),
              title: Text(
                'Profile',
                style: appDrawerListTileTextStyle,
              ),
              onTap: () =>
                  changePage(destinationPageRouteName: ProfileScreen.routeName),
            ),
            ListTile(
              leading: Icon(
                Icons.assignment,
                color: Theme.of(ctx).primaryColor,
              ),
              title: Text(
                'Orders',
                style: appDrawerListTileTextStyle,
              ),
              onTap: () => changePage(
                  destinationPageRouteName: OrderListsPage.routeName),
            ),
            ListTile(
              leading: Icon(
                Icons.people_alt,
                color: Theme.of(ctx).primaryColor,
              ),
              title: Text(
                'Survey',
                style: appDrawerListTileTextStyle,
              ),
              onTap: () =>
                  changePage(destinationPageRouteName: SurveysPage.routeName),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              cubit: authBloc,
              buildWhen: (p, c) => c is Authenticated,
              builder: (ctx, state) {
                logger.i(state);
                if (state is Authenticated) {
                  if (state.authenticatedUser.role == 'Admin') {
                    return ListTile(
                      leading: Icon(
                        Icons.assignment,
                        color: Theme.of(ctx).primaryColor,
                      ),
                      title: Text(
                        'Manage',
                        style: appDrawerListTileTextStyle,
                      ),
                      onTap: () => changePage(
                          destinationPageRouteName: ManagementScreen.routeName),
                    );
                  } else if (state.authenticatedUser.role == 'Doctor') {
                    return ListTile(
                      leading: Icon(
                        FontAwesomeIcons.userInjured,
                        color: Theme.of(ctx).primaryColor,
                      ),
                      title: Text(
                        'Appointments',
                        style: appDrawerListTileTextStyle,
                      ),
                      onTap: () => changePage(
                        destinationPageRouteName: DoctorsAppointments.routeName,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                } else {
                  logger.w("Unexpected state : $state");
                  return const SizedBox();
                }
              },
            ),
            const Divider(),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.powerOff,
                    color: Theme.of(ctx).primaryColor,
                  ),
                  title: Text(
                    'Logout',
                    style: appDrawerListTileTextStyle,
                  ),
                  onTap: () {
                    logger.i("Logout clicked");
                    Navigator.popUntil(ctx, ModalRoute.withName('/'));
                    authBloc.add(const Signout());
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CachedCircleAvatarImage extends StatelessWidget {
  const CachedCircleAvatarImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final state = ctx.watch<AuthBloc>().state;

    return state is Authenticated
        ? CachedNetworkImage(
            imageUrl: ApiConstants.imageUrl(state.authenticatedUser.image),
            imageBuilder: (ctx, imageProvider) => CircleAvatar(
              backgroundImage: imageProvider,
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(
              value: downloadProgress.progress,
            ),
          )
        : const SizedBox();
  }
}
