/*
 * Copyright (c) 2023 Kodeco LLC.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom
 * the Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify,
 * merge, publish, distribute, sublicense, create a derivative work,
 * and/or sell copies of the Software in any work that is designed,
 * intended, or marketed for pedagogical or instructional purposes
 * related to programming, coding, application development, or
 * information technology. Permission for such use, copying,
 * modification, merger, publication, distribution, sublicensing,
 * creation of derivative works, or sale is expressly withheld.
 *
 * This project and source code may use libraries or frameworks
 * that are released under various Open-Source licenses. Use of
 * those libraries and frameworks are governed by their own
 * individual licenses.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 */

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const String _listNameKey = 'listName';
  static const String _caloriesKey = 'calories';
  static const String _showFileSizeKey = 'showFileSize';
  static const String _showDateKey = 'showDate';

//singleton pattern
  SecureStorageHelper._internal();
  static final SecureStorageHelper _instance = SecureStorageHelper._internal();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static Future<SecureStorageHelper> getInstance() async {
    return _instance;
  }

  // CRUD Methods
  Future setListName(String listName) async {
    await _secureStorage.write(key: _listNameKey, value: listName);
  }

  Future<String> getListName() async {
    return await _secureStorage.read(key: _listNameKey) ?? 'My Recipes';
  }

  Future setCalories(int calories) async {
    await _secureStorage.write(key: _caloriesKey, value: calories.toString());
  }

  Future<int> getCalories() async {
    final calories = await _secureStorage.read(key: _caloriesKey) ?? '2000';
    return int.parse(calories);
  }

  Future setShowFileSize(bool showFileSize) async {
    await _secureStorage.write(
        key: _showFileSizeKey, value: showFileSize.toString());
  }

  Future<bool> getShowFileSize() async {
    final showFileSize =
        await _secureStorage.read(key: _showFileSizeKey) ?? 'true';
    return bool.parse(showFileSize);
  }

  Future<bool> getShowDate() async {
    final showDate = await _secureStorage.read(key: _showDateKey) ?? 'true';
    return bool.parse(showDate);
  }

  Future setShowDate(bool showDate) async {
    await _secureStorage.write(key: _showDateKey, value: showDate.toString());
  }

  Future deleteSettings() async {
    await _secureStorage.delete(key: _listNameKey);
    await _secureStorage.delete(key: _caloriesKey);
    await _secureStorage.delete(key: _showFileSizeKey);
  }
}
