import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';
import 'package:lpp/logic/app/typography.dart';
import 'package:lpp/topics/absence/widgets/absence_cause_card.dart';

class CausesSheet extends StatelessWidget {
  const CausesSheet({super.key, required this.onSelect});
  final Function(AbsenceCauses selectedCause) onSelect;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        children: [
          Text(
            "Vælg årsag",
            style: LppTypography.labelSmall(context),
          ),
          ListView(
            primary: false,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            shrinkWrap: true,
            children: AbsenceCauses.values.reversed
                .map((cause) => AbsenceCauseCard(
                      cause: cause,
                      onTap: () {
                        Navigator.pop(context);
                        onSelect(cause);
                      },
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
