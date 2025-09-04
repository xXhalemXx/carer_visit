// lib/helpers/powersync_helper.dart
import 'package:powersync/powersync.dart';

class PowerSyncHelper {
  static Future<void> setUserCredentials({
    required String userId,
    required String token,
  }) async {
    await PowerSync.setCredentials(
      PowerSyncCredentials(
        endpoint: 'https://68b963282dfde049b4c22346.powersync.journeyapps.com',
        userId: userId,
        token: token,
      ),
    );
  }
}
