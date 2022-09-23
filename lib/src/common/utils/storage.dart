import 'package:hive_flutter/hive_flutter.dart';

import '../../modules/auth/infrastructure/models/user_model.dart';
import 'logger.dart';

class _BoxKeys {
  static const lang = 'lang';
  static const user = 'user';
  static const deviceId = 'device_id';
  static const pushToken = 'push_token';
}

class Storage {
  static final _box = Hive.box('box');

  static setup() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    try {
      await Hive.openBox('box');
    } catch (error) {
      logger.e(error);
      try {
        await Hive.deleteBoxFromDisk('box');
      } catch (error) {
        logger.e(error);
      }
      await Hive.openBox('box');
    }
  }

  static String? get lang => _box.get(_BoxKeys.lang);
  static Future setLang(String? val) => _box.put(_BoxKeys.lang, val);
  static UserModel? get user => _box.get(_BoxKeys.user);
  static Future setUser(UserModel? val) => _box.put(_BoxKeys.user, val);
  static String? get deviceId => _box.get(_BoxKeys.deviceId);
  static Future setDeviceId(String? val) => _box.put(_BoxKeys.deviceId, val);
  static String? get pushToken => _box.get(_BoxKeys.pushToken);
  static Future setPushToken(String? val) => _box.put(_BoxKeys.pushToken, val);
}
