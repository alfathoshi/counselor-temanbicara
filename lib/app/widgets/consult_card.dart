import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsultCard extends StatelessWidget {
  final String image;
  final String name;
  final String problem;
  final String date;
  final String start;
  final String end;
  final String status;
  const ConsultCard({
    super.key,
    required this.image,
    required this.name,
    required this.problem,
    required this.date,
    required this.start,
    required this.end,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    DateTime formattedDate = DateTime.parse(date);
    DateTime sTime = DateFormat('HH:mm:ss').parse(start);
    DateTime eTime = DateFormat('HH:mm:ss').parse(end);
    String startTime = DateFormat('HH:mm').format(sTime);
    String endTime = DateFormat('HH:mm').format(eTime);
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: border,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primaryColor,
                      width: 1,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: NetworkImage(image),
                  ),
                ),
                szbX8,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: h5Bold,
                      ),
                      Text(
                        problem,
                        style: h6Medium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      szbY16,
                      Row(
                        children: [
                          const Icon(
                            Icons.date_range,
                            size: 18,
                            color: font,
                          ),
                          szbX8,
                          Text(DateFormat('d MMMM').format(formattedDate),
                              style: h6Medium),
                          szbX16,
                          const Icon(
                            Icons.schedule_rounded,
                            size: 18,
                            color: font,
                          ),
                          szbX8,
                          Text('$startTime - $endTime', style: h6Medium),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            szbY16,
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: status == 'Done' ? primaryColor : warning,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    status,
                    style: h5Bold.copyWith(
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
