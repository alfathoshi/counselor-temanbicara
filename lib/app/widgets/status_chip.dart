import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String status;
  final IconData icon;
  final Color color;
  const StatusChip({
    super.key,
    required this.status,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          szbX8,
          Text(
            status == 'Pending' ? 'On Review' : status,
            style: h7SemiBold.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
