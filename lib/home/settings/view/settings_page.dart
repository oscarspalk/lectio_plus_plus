import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/auth/cubit/cubit.dart';
import 'package:lectio_plus_plus/core/core.dart';
import 'package:lectio_plus_plus/core/essentials/teams/team_cubit.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            l10n.settingsTitle,
            style: CustomTypography.headline(),
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text(l10n.teamCacheError),
              onTap: () async {
                await context.read<TeamCubit>().fetchTeams();
              },
            ),
            ListTile(
              title: Text(l10n.logout),
              onTap: () async {
                await context.read<AuthCubit>().logout();
              },
            )
          ],
        ));
  }
}
