import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/topics/state/loading.dart';
import 'package:lpp/topics/welcome/bloc/login.dart';
import 'package:lpp/topics/welcome/screens/greeting.dart';
import 'package:lpp/topics/welcome/screens/gym.dart';
import 'package:lpp/topics/welcome/screens/login_screen.dart';
import 'package:lpp/topics/welcome/screens/theme.dart';

class WelcomeCarousel extends StatefulWidget {
  const WelcomeCarousel({super.key});

  @override
  State<WelcomeCarousel> createState() => _WelcomeCarouselState();
}

class _WelcomeCarouselState extends State<WelcomeCarousel> {
  late PageController carousel;

  final Duration animDuration = const Duration(milliseconds: 500);
  final Curve animCurve = Curves.easeInOut;

  late int _selected;

  @override
  void initState() {
    super.initState();
    var loginBloc = context.read<LoginBloc>();
    loginBloc.setGymSubmittedCallback(() {
      next();
    });
    int initial = 0;
    if (loginBloc.state.password.isNotEmpty &&
        loginBloc.state.username.isNotEmpty) {
      initial = 3;
    }
    _selected = initial;
    carousel = PageController(initialPage: initial);
  }

  void next() {
    setState(() {
      _selected += 1;
    });
    carousel.nextPage(duration: animDuration, curve: animCurve);
  }

  void back() {
    setState(() {
      _selected -= 1;
    });
    carousel.previousPage(duration: animDuration, curve: animCurve);
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return Scaffold(
      floatingActionButton:
          showFab ? DotsWithRespectForKeyboard(selected: _selected) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
        if (state.state == StudentStates.loading || state.gyms.isEmpty) {
          return const LoadingScreen();
        }
        return PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: carousel,
          children: [
            GreetingsScreen(
              next: next,
            ),
            ThemeScreen(next: next),
            GymScreen(
              next: next,
            ),
            LoginScreen(
              back: back,
            ),
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    carousel.dispose();
  }
}

class DotsWithRespectForKeyboard extends StatelessWidget {
  const DotsWithRespectForKeyboard({
    super.key,
    required int selected,
  }) : _selected = selected;

  final int _selected;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return DotsIndicator(
      decorator: DotsDecorator(
          activeColor: colorScheme.primary,
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
      dotsCount: 4,
      position: _selected,
    );
  }
}
