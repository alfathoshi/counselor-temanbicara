import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ClientCard extends StatelessWidget {
  const ClientCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Center(
        child: Text('Client'),
      ),
    );
  }
}
