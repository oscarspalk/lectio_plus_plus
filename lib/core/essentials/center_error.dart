import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lectio_plus_plus/core/decoration/spacing.dart';
import 'package:lectio_plus_plus/core/decoration/typography.dart';
import 'package:lectio_plus_plus/core/essentials/illustration.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';

class CenterError extends StatelessWidget {
  const CenterError(
      {required this.error, required this.description, super.key});

  final String Function(AppLocalizations l10n) error;
  final String Function(AppLocalizations l10n) description;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Illustration(name: 'empty'),
          Text(
            error(l10n),
            style: CustomTypography.headline(),
          ),
          const LargeSpacer(),
          Text(
            description(l10n),
            style: CustomTypography.body(),
          )
        ],
      ),
    );
  }
}
