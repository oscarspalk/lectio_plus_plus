import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/topics/state/loading.dart';
import 'package:lpp/topics/welcome/screens/greeting.dart';
import 'package:lpp/topics/welcome/screens/gym.dart';
import 'package:lpp/topics/welcome/screens/login_screen.dart';
import 'package:lpp/topics/welcome/screens/money.dart';
import 'package:lpp/topics/welcome/screens/safety.dart';
import 'package:lpp/topics/welcome/screens/theme.dart';
import 'package:lpp/topics/welcome/screens/tos.dart';

class WelcomeCarousel extends StatefulWidget {
  const WelcomeCarousel({super.key});

  @override
  State<WelcomeCarousel> createState() => _WelcomeCarouselState();
}

class _WelcomeCarouselState extends State<WelcomeCarousel> {
  late PageController carousel;
  int _selectedGym = 0;

  final Duration animDuration = const Duration(milliseconds: 500);
  final Curve animCurve = Curves.easeInOut;

  @override
  void initState() {
    super.initState();
    carousel = PageController();
  }

  void next() {
    carousel.nextPage(duration: animDuration, curve: animCurve);
  }

  void back() {
    carousel.previousPage(duration: animDuration, curve: animCurve);
  }

  void skip() {
    carousel.animateToPage(5, duration: animDuration, curve: animCurve);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
      if (state.state == StudentStates.loading || state.gyms.isEmpty) {
        return const LoadingScreen();
      }
      return PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: carousel,
        children: [
          GreetingsScreen(
            skip: skip,
            next: next,
          ),
          MoneyScreen(next: next),
          ThemeScreen(next: next),
          Safety(next: next),
          TermsOfService(next: next),
          GymScreen(
            next: next,
            selectGym: (n) {
              next();
              setState(() {
                _selectedGym = n;
              });
              Navigator.pop(context);
            },
          ),
          LoginScreen(
            selectedGym: _selectedGym,
            back: back,
          ),
        ],
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    carousel.dispose();
  }
}
