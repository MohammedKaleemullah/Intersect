import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class Utils {
  static const primaryFontColor = Color(0xFF313131);
  static const primaryColor = Color(0xFF7986C0);
  // background of all screens
  static const primaryBackground = Color(0xFFF8F8F8);

  static const secondaryButtonColor = Color(0xFF3B3B3B);
  static const white = Color(0xFFFFFFFF);
  // for smaller fonts
  static const secondaryFontColor = Color(0xFFC3C3C3);
  static const secondaryPeach = Color(0xFFFA6E6E);

  static String? backendUrl = "";
  static const headerValue = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<List> getCoordinates() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      Fluttertoast.showToast(msg: 'Location is needed to move further.');
      return [];
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    return [position.latitude, position.longitude];
  }
}
