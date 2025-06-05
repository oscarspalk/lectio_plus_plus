import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lectio_plus_plus/auth/cubit/login_cubit.dart';
import 'package:lectio_plus_plus/auth/types/login_state.dart';
import 'package:lectio_plus_plus/core/decoration/colors.dart';
import 'package:lectio_plus_plus/core/decoration/layout.dart';
import 'package:lectio_plus_plus/core/decoration/spacing.dart';
import 'package:lectio_plus_plus/core/decoration/typography.dart';
import 'package:lectio_plus_plus/core/essentials/illustration.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';
import 'package:lectio_plus_plus/routes/app_routes.gr.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.stage == LoginStage.unilogin) {
          // push unilogin page
          context.navigateTo(const UniloginRoute());
        }
      },
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      floatingActionButton: const MitIdButton(),
      appBar: AppBar(),
      body: DefaultColumn(
        children: [
          const Illustration(name: 'security'),
          const LargeSpacer(),
          Text(
            l10n.loginTitle,
            style: CustomTypography.headline(),
          ),
          const SmallSpacer(),
          Text(
            l10n.loginDescription,
            style: CustomTypography.body(),
          ),
        ],
      ),
    );
  }
}

class MitIdButton extends StatelessWidget {
  const MitIdButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FloatingActionButton.extended(
      backgroundColor: CustomColors.mitIdColor,
      foregroundColor: Colors.white,
      onPressed: () {
        context.read<LoginCubit>().loginWithMitID();
      },
      label: Row(
        children: [
          Text(
            l10n.loginButton,
            style: CustomTypography.body(),
          ),
          const SmallSpacer(),
          SizedBox(
            height: CustomTypography.bodySize,
            width: CustomTypography.bodySize * 2,
            child: SvgPicture.asset(
              'assets/illustrations/filled_mitid.svg',
            ),
          ),
        ],
      ),
    );
  }
}
