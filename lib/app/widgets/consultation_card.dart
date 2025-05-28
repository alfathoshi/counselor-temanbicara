import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/widgets/buttons/rounded_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../themes/fonts.dart';
import '../themes/sizedbox.dart';

class ConsultationCard extends StatelessWidget {
  final String name;
  final String gender;
  final String date;
  final String startTime;
  final String endTime;
  final String status;
  final String profile;
  final String age;
  const ConsultationCard({
    super.key,
    required this.name,
    required this.date,
    required this.status,
    required this.profile,
    required this.gender,
    required this.age,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    final umur = DateTime.parse(age);
    DateTime sTime = DateFormat('HH:mm:ss').parse(startTime);
    DateTime eTime = DateFormat('HH:mm:ss').parse(endTime);

    String start = DateFormat('HH:mm').format(sTime);
    String end = DateFormat('HH:mm').format(eTime);
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
                  child: ClipOval(
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
                    Text('${DateTime.now().year.toInt() - umur.year} / $gender')
                  ],
                )
              ],
            ),
            Divider(
              color: primaryColor,
            ),
            szbY8,
            Row(
              children: [
                Row(
                  children: [
                    const Icon(
                      Iconsax.calendar,
                      size: 16,
                    ),
                    szbX4,
                    Text(
                      DateTime.parse(date).toLocal().toString().split(' ')[0],
                      style: h6Regular,
                    ),
                  ],
                ),
                szbX16,
                Row(
                  children: [
                    const Icon(
                      Iconsax.clock,
                      size: 16,
                    ),
                    szbX4,
                    Text(
                      '$start - $end',
                      style: h6Regular,
                    )
                  ],
                )
              ],
            ),
            Spacer(),
            RoundedButton(
              height: 30,
              width: 117,
              get: () {},
              color: status == 'Done' ? primaryColor : warning,
              text: status,
            )
          ],
        ),
      ),
    );
  }
}
