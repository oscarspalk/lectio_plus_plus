import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/auth/cubit/login_cubit.dart';
import 'package:lectio_plus_plus/core/decoration/input_decoration.dart';
import 'package:lectio_plus_plus/core/decoration/spacing.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginView();
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.loginAppBarTitle),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: CustomSpacing.lg * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UsernameField(),
            LargeSpacer(),
            PasswordField(),
            LargeSpacer(),
            SubmitButton()
          ],
        ),
      ),
    );
  }
}

class UsernameField extends StatelessWidget {
  const UsernameField({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final setUsername = context.read<LoginCubit>().setUsername;
    return TextField(
      onChanged: setUsername,
      decoration: CustomInputDecorator.fromLabel(l10n.usernameLoginFieldTitle),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final setPassword = context.read<LoginCubit>().setPassword;

    return TextField(
      obscureText: true,
      onChanged: setPassword,
      decoration: CustomInputDecorator.fromLabel(l10n.passwordLoginFieldTitle),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final valid = context.select((LoginCubit cubit) => cubit.valid);
    return FilledButton(
        onPressed: valid ? () {} : null,
        child: Text(l10n.submitLoginButtonTitle));
  }
}
