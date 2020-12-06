import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry/sentry.dart';

final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
final PackageInfo packageInfo = PackageInfo();

Future<Event> getSentryEnvEvent(
  dynamic exception,
  StackTrace stackTrace,
) async {
  /// return Event with IOS extra information to send it to Sentry
  if (Platform.isIOS) {
    final IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    return Event(
      release: packageInfo.version,
      environment: 'production', // replace it as it's desired
      tags: {
        'buildNumber': packageInfo.buildNumber,
      },
      extra: <String, dynamic>{
        'name': iosDeviceInfo.name,
        'model': iosDeviceInfo.model,
        'systemName': iosDeviceInfo.systemName,
        'systemVersion': iosDeviceInfo.systemVersion,
        'localizedModel': iosDeviceInfo.localizedModel,
        'utsname': iosDeviceInfo.utsname.sysname,
        'identifierForVendor': iosDeviceInfo.identifierForVendor,
        'isPhysicalDevice': iosDeviceInfo.isPhysicalDevice,
      },
      exception: exception,
      stackTrace: stackTrace,
    );
  }

  /// return Event with Andriod extra information to send it to Sentry
  if (Platform.isAndroid) {
    final AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    return Event(
      release: packageInfo.version,
      environment: 'production', // replace it as it's desired
      tags: {
        'buildNumber': packageInfo.buildNumber,
      },
      extra: <String, dynamic>{
        'type': androidDeviceInfo.type,
        'model': androidDeviceInfo.model,
        'device': androidDeviceInfo.device,
        'id': androidDeviceInfo.id,
        'androidId': androidDeviceInfo.androidId,
        'brand': androidDeviceInfo.brand,
        'display': androidDeviceInfo.display,
        'hardware': androidDeviceInfo.hardware,
        'manufacturer': androidDeviceInfo.manufacturer,
        'product': androidDeviceInfo.product,
        'version': androidDeviceInfo.version.release,
        'supported32BitAbis': androidDeviceInfo.supported32BitAbis,
        'supported64BitAbis': androidDeviceInfo.supported64BitAbis,
        'supportedAbis': androidDeviceInfo.supportedAbis,
        'isPhysicalDevice': androidDeviceInfo.isPhysicalDevice,
      },
      exception: exception,
      stackTrace: stackTrace,
    );
  }

  /// Return standard Error in case of non-specifed paltform
  ///
  /// if there is no detected platform,
  /// just return a normal event with no extra information
  return Event(
    release: '${packageInfo.version}-${packageInfo.buildNumber}',
    environment: 'production',
    exception: exception,
    stackTrace: stackTrace,
  );
}
