import 'package:firebase_remote_config/firebase_remote_config.dart';

const String _PARAMETER_1 = "front_cam_image_name";
const String _PARAMETER_2 = "rear_cam_image_name";

class RemoteConfigService {
  final RemoteConfig _remoteConfig;

  RemoteConfigService({RemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;

  final defaults = <String, dynamic>{
    _PARAMETER_1: "front_cam_img_1.png",
    _PARAMETER_2: "back_cam_img_1.png"
  };

  static RemoteConfigService _instance;

  static Future<RemoteConfigService> getInstance() async {
    if (_instance == null) {
      _instance =
          RemoteConfigService(remoteConfig: await RemoteConfig.instance);
    }
    return _instance;
  }

  //Alttaki true you düzelt.
  String get getFrontCamButName => _remoteConfig.getString(_PARAMETER_1);
  String get getRearCamButName => _remoteConfig.getString(_PARAMETER_2);

  Future initialize() async {
    try {
      await _remoteConfig.setDefaults(defaults);
      await _fetchAndActivate();
    } on Exception {}
  }

  Future _fetchAndActivate() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));
    await _remoteConfig.fetchAndActivate();
    print(getFrontCamButName);
  }
}
