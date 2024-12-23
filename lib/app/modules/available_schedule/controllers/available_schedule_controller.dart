import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AvailableScheduleController extends GetxController {
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();

  void updateDates(List<DateTime>? selectedDates) {
    if (selectedDates != null && selectedDates.length >= 2) {
      startDate.value = selectedDates[0];
      endDate.value = selectedDates[1];
    }
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }
}
