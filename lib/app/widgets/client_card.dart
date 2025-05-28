import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:counselor_temanbicara/app/widgets/buttons/rounded_button.dart';
import 'package:flutter/material.dart';

class ClientCard extends StatelessWidget {
  final String fullname;
  final String nickname;
  final String age;
  final String gender;
  final String note;
  final String status;
  final String profile;
  const ClientCard({
    super.key,
    required this.fullname,
    required this.nickname,
    required this.age,
    required this.gender,
    required this.note,
    required this.status,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final umur = DateTime.parse(age);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(16),
        color: whiteColor
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey.shade300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(profile),
                ),
              ),
              title: Text(nickname),
              subtitle:
                  Text('${DateTime.now().year.toInt() - umur.year} / $gender'),
            ),
            szbY8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nama:', style: h6Medium),
                Text(fullname, style: h6Regular),
              ],
            ),
            szbY8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Note:', style: h6Medium),
                Text(note, style: h6Regular),
              ],
            ),
            szbY8,
            Text(
              'Status',
              style: h6Regular,
            ),
            szbY8,
            RoundedButton(
              get: () {},
              color: status == 'Done' ? primaryColor : warning,
              text: status,
              height: 32,
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
