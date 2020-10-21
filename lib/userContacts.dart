library user_contacts;

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

part 'models/person.dart';

class UserContacts {
  final Permission _permission = Permission.contacts;

  static const MethodChannel _channel = const MethodChannel('userContacts');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<List<Person>> getContacts() async {
    final PermissionStatus permissionStatus = await _permission.request();

    if (permissionStatus == PermissionStatus.granted) {
      final dynamic jsonString = await _channel.invokeMethod('getContacts');
      final List<dynamic> jsonObjects = json.decode(jsonString);
      final List<Person> contacts =
          jsonObjects.map((jsonObject) => Person.fromJson(jsonObject)).toList();

      return contacts;
    } else {
      _handleInvalidPermissions(permissionStatus);
    }

    return null;
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to contact data denied",
          details: null);
    }
  }
}
