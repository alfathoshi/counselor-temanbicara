import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:counselor_temanbicara/app/widgets/buttons/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ClientCard extends StatelessWidget {
  final String name;
  final String age;
  final String gender;
  final String note;
  final String status;
  final String profile;
  const ClientCard({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.note,
    required this.status,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final umur = DateTime.now().year - DateTime.parse(age).year;

    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: border,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.network(
                    'https://kpopping.com/documents/9e/1/2048/220723-XG-Chisa-Twitter-Update-documents-1.jpeg?v=c8dfd',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: greyColor.withValues(
                            alpha: 0.3), 
                        child: const Center(
                          child: Icon(Iconsax.image,
                              size: 48, color: Colors.black54),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            szbY8,
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.isNotEmpty ? name : 'Loading Name...',
                      style: h4SemiBold,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    Text(
                      '$umur / ${gender.isNotEmpty ? gender : 'N/A'}',
                      style: h7Regular,
                    ),
                    szbY8,
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        note.isNotEmpty ? note : 'No notes available.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: h6Regular,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: status == 'Done'
                                ? primaryColor.withValues(alpha: 0.1)
                                : warning.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                  status == 'Done'
                                      ? Icons.check_circle
                                      : Icons.pending_actions,
                                  color:
                                      status == 'Done' ? primaryColor : warning,
                                  size: 24),
                              SizedBox(width: 8),
                              Text(
                                status == 'Done' ? 'Reviewed' : 'Pending',
                                style: TextStyle(
                                  color:
                                      status == 'Done' ? primaryColor : warning,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        szbX8,
                        Spacer(),
                        note.isNotEmpty
                            ? SizedBox.shrink()
                            : Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Review',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(Icons.arrow_circle_right,
                                        color: black, size: 24),
                                  ],
                                ),
                              ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
