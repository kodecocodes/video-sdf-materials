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

// ignore_for_file: avoid_bool_literals_in_conditional_expressions

class AppSettings {
  String listName;
  int calories;
  bool showFileSize;
  bool showDate;

  AppSettings({
    required this.listName,
    required this.calories,
    required this.showFileSize,
    required this.showDate,
  });

  AppSettings.fromJson(Map<String, dynamic> json)
      : listName = json['listName'] is String
            ? json['listName'] as String
            : 'My Recipes',
        calories = json['calories'] is int ? json['calories'] as int : 2000,
        showFileSize =
            json['showFileSize'] is bool ? json['showFileSize'] as bool : true,
        showDate = json['showDate'] is bool ? json['showDate'] as bool : true;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'listName': listName,
      'calories': calories,
      'showFileSize': showFileSize,
      'showDate': showDate,
    };
  }
}
