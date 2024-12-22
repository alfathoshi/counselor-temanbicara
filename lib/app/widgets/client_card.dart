import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:counselor_temanbicara/app/widgets/buttons/rounded_button.dart';
import 'package:flutter/material.dart';


class ClientCard extends StatelessWidget {
  const ClientCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              leading: CircleAvatar(),
              title: Text('Nama'),
              subtitle: Text('Umur/Gender'),
            ),
            szbY8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nama:', style: h6Medium),
                Text('Nama Lengkap', style: h6Regular),
              ],
            ),
            szbY8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Note:', style: h6Medium),
                Text('Catatan', style: h6Regular),
              ],
            ),
            Expanded(child: szbY8),
            Text(
              'Status',
              style: h6Regular,
            ),
            szbY8,
            RoundedButton(
              get: () {},
              color: primaryColor,
              text: 'Completed',
              height: 32,
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
