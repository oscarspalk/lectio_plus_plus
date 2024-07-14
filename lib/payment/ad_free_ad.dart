import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/payment/ad_free_state.dart';
import 'package:lpp/payment/art.dart';
import 'package:lpp/payment/buy_screen.dart';
import 'package:lpp/payment/owned_bloc.dart';
import 'package:lpp/utils/ad_route.dart';

class AdFreeAd extends StatelessWidget {
  const AdFreeAd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnedCubit, AdFreeState>(
      builder: (context, state) {
        if (state.hasAdFree) {
          return const SizedBox(height: 0.0);
        }
        var colorScheme = Theme.of(context).colorScheme;
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 90.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, adRoute(const BuyAdFreeScreen()));
                    },
                    child: Card.filled(
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: AdFreeArt(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Træt af reklamer?",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: colorScheme.onTertiary),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    EvaIcons.arrowForwardOutline,
                                    color: colorScheme.onTertiary,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
