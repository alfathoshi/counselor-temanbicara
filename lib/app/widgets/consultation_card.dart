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
  final String profile;
  const ConsultationCard({
    super.key,
    required this.name,
    required this.symptoms,
    required this.date,
    required this.time,
    required this.type,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey.shade300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(profile),
                  ),
                ),
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
            Row(
              children: [
                const Icon(Iconsax.calendar),
                szbX8,
                Text(
                  date,
                  style: h6Regular,
                ),
              ],
            ),
            szbY8,
            Row(
              children: [
                const Icon(Iconsax.clock),
                szbX8,
                Text(
                  time,
                  style: h6Regular,
                )
              ],
            ),
            szbY16,
            RoundedButton(
              height: 30,
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
