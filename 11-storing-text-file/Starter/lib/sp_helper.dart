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

import 'package:shared_preferences/shared_preferences.dart';


class SPHelper {
  static const String _listNameKey = 'listName';
  static const String _caloriesKey = 'calories';
  static const String _showFileSizeKey = 'showFileSize';
  static const String _showDateKey = 'showDate';

//singleton pattern
  SPHelper._internal();
  static final SPHelper _instance = SPHelper._internal();
  late SharedPreferences _preferences;

  static Future<SPHelper> getInstance() async {
    _instance._preferences = await SharedPreferences.getInstance();
    return _instance;
  }

  Future<bool> setListName(String listName) async {
    final result = await _preferences.setString(_listNameKey, listName);
    return result;
  }

  String getListName() {
    return _preferences.getString(_listNameKey) ?? 'My Recipes';
  }

  Future<bool> setCalories(int calories) async {
    final result = await _preferences.setInt(_caloriesKey, calories);
    return result;
  }

  int getCalories() {
    return _preferences.getInt(_caloriesKey) ?? 2000;
  }

  Future<bool> setShowFileSize(bool showFileSize) async {
    final result = await _preferences.setBool(_showFileSizeKey, showFileSize);
    return result;
  }

  bool getShowFileSize() {
    return _preferences.getBool(_showFileSizeKey) ?? true;
  }

  bool getShowDate() {
    return _preferences.getBool(_showDateKey) ?? true;
  }

  Future<bool> setShowDate(bool showDate) async {
    final result = await _preferences.setBool(_showDateKey, showDate);
    return result;
  }

  Future<bool> deleteSettings() async {
    return await _preferences.remove(_listNameKey) &&
        await _preferences.remove(_caloriesKey) &&
        await _preferences.remove(_showFileSizeKey);
  }

  
}
