import 'package:corrispay/features/bases/widgets/section_label.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../account/widgets/info_row.dart';

class InfoBlock extends StatelessWidget {
  const InfoBlock({super.key, required this.rows,required this.title});

  final List<InfoRow> rows;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(label: title),
        const Gap(10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFF0F0F0)),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              for (int i = 0; i < rows.length; i++) ...[
                rows[i],

              ]
            ],
          ),
        ),
      ],
    );
  }
}