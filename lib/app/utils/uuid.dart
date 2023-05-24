import 'package:uuid/uuid.dart';

// DeviceID = WithoutHyphen
String getDeviceId() {
  const uuid = Uuid();
  return uuid.v4().replaceAll('-', '');
}
