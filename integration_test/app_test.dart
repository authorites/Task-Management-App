import 'package:integration_test/integration_test.dart';
import 'package:patrol/patrol.dart';
import 'package:task_manage_management/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  patrolTest(
    'open app success',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());
      await $.pumpAndSettle();
      await $('splash screen').waitUntilExists();
    },
  );
}
