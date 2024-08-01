import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class HiveUtils<T> {
  Box<T>? _box;
  final String boxName;
  final String key;

  HiveUtils(this.boxName, this.key);

  Future<void> openBox() async {
    try {
      _box ??= await Hive.openBox<T>(boxName);
    } catch (e) {
      // Handle any exceptions that might occur during box opening
      if (kDebugMode) {
        print('Error opening box: $e');
      }
    }
  }

  Future<void> closeBox() async {
    try {
      if (_box != null) {
        await _box!.close();
        _box = null;
      }
    } catch (e) {
      // Handle any exceptions that might occur during box closing
      if (kDebugMode) {
        print('Error closing box: $e');
      }
    }
  }

  Future<bool> isDataStored() async {
    try {
      if (_box == null) await openBox();
      return _box!.containsKey(key);
    } catch (e) {
      // Handle any exceptions that might occur
      if (kDebugMode) {
        print('Error checking if data is stored: $e');
      }
      return false;
    }
  }

  Future<T?> getData() async {
    try {
      if (_box == null) await openBox();
      if (await isDataStored()) {
        return _box!.get(key);
      }
      return null;
    } catch (e) {
      // Handle any exceptions that might occur
      if (kDebugMode) {
        print('Error retrieving data: $e');
      }
      return null;
    }
  }

  Future<void> storeData(T data) async {
    try {
      if (_box == null) await openBox();
      await _box!.put(key, data);
    } catch (e) {
      // Handle any exceptions that might occur
      if (kDebugMode) {
        print('Error storing data: $e');
      }
    }
  }

  Future<void> deleteData() async {
    try {
      if (_box == null) await openBox();
      await _box!.delete(key);
    } catch (e) {
      // Handle any exceptions that might occur
      if (kDebugMode) {
        print('Error deleting data: $e');
      }
    }
  }
}
