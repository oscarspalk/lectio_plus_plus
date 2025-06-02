import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lectio_plus_plus/auth/cubit/select_gym_cubit.dart';
import 'package:lectio_plus_plus/auth/view/gym_search_delegate.dart';
import 'package:lectio_plus_plus/core/decoration/layout.dart';
import 'package:lectio_plus_plus/core/decoration/spacing.dart';
import 'package:lectio_plus_plus/core/decoration/typography.dart';
import 'package:lectio_plus_plus/core/essentials/illustration.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';
import 'package:lectio_wrapper/types/gym.dart';

class SelectGymPage extends StatelessWidget {
  const SelectGymPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectGymCubit()..load(),
      child: const SelectGymView(),
    );
  }
}

class SelectGymView extends StatelessWidget {
  const SelectGymView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      floatingActionButton: const ChooseGymButton(),
      body: DefaultColumn(
        children: [
          const Illustration(name: 'campus'),
          Text(
            l10n.chooseGymTitle,
            style: CustomTypography.headline(),
          ),
          const SmallSpacer(),
          Text(
            l10n.chooseGymText,
            style: CustomTypography.body(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ChooseGymButton extends StatelessWidget {
  const ChooseGymButton({super.key});

  Future<void> initSearch(BuildContext context) async {
    final gyms = context.read<SelectGymCubit>().state;
    await showSearch(context: context, delegate: GymSearchDelegate(gyms: gyms));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectGymCubit, List<Gym>>(
      builder: (context, state) {
        final l10n = context.l10n;
        final valid = state.isNotEmpty;
        return FloatingActionButton.extended(
          onPressed: valid ? () => initSearch(context) : null,
          label: Row(
            children: [
              Text(
                l10n.chooseGymButton,
                style: CustomTypography.label(),
              ),
              const SmallSpacer(),
              const FaIcon(
                FontAwesomeIcons.arrowRightLong,
                size: CustomTypography.bodySize,
              ),
            ],
          ),
        );
      },
    );
  }
}
