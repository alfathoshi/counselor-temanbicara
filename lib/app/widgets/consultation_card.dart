import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/widgets/buttons/rounded_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

import '../themes/fonts.dart';
import '../themes/sizedbox.dart';

class ConsultationCard extends StatelessWidget {
  final String name;
  final String symptoms;
  final String date;
  final String time;
  final String type;
  const ConsultationCard(
      {super.key,
      required this.name,
      required this.symptoms,
      required this.date,
      required this.time,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F5EB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(),
                szbX8,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        name,
                        style: h5Bold,
                        maxLines: 2,
                      ),
                    ),
                    Text(symptoms)
                  ],
                )
              ],
            ),
            const Divider(),
            Expanded(
              child: Row(
                children: [
                  Icon(Iconsax.calendar),
                  szbX8,
                  Text(
                    date,
                    style: h6Regular,
                  ),
                  szbX24,
                  Icon(Iconsax.clock),
                  szbX8,
                  Text(
                    time,
                    style: h6Regular,
                  )
                ],
              ),
            ),
            RoundedButton(
              height: 40,
              width: 117,
              get: () {},
              color: primaryColor,
              text: type,
            )
          ],
        ),
      ),
    );
  }
}
