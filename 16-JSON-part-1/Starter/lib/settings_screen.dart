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

import 'package:flutter/material.dart';
import 'sp_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _listName = '';
  int _calories = 0;
  bool _showFileSize = false;
  bool _showDate = false;
  final double fontSize = 22.0;

  final _listNameController = TextEditingController();
  final _caloriesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future _loadSettings() async {
    final prefs = await SPHelper.getInstance();

    _listName =  prefs.getListName();
    _calories =  prefs.getCalories();
    _showFileSize = prefs.getShowFileSize();
    _showDate = prefs.getShowDate();
    setState(() {});

    _listNameController.text = _listName;
    _caloriesController.text = _calories.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _listNameController,
              decoration: InputDecoration(
                  labelText: 'List Name',
                  labelStyle: TextStyle(fontSize: fontSize)),
              onChanged: (value) {
                setState(() {
                  _listName = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _caloriesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Maximum Daily Calories',
                  labelStyle: TextStyle(fontSize: fontSize)),
              onChanged: (value) {
                setState(() {
                  _calories = int.tryParse(value) ?? 0;
                });
              },
            ),
          ),
          SwitchListTile(
            title: Text('Show File Size', style: TextStyle(fontSize: fontSize)),
            value: _showFileSize,
            onChanged: (bool value) {
              setState(() {
                _showFileSize = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Show Date', style: TextStyle(fontSize: fontSize)),
            value: _showDate,
            onChanged: (bool value) {
              setState(() {
                _showDate = value;
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _saveSettings, child: const Icon(Icons.save)),
    );
  }

  Future _saveSettings() async {
    final prefs = await SPHelper.getInstance();

    await prefs.setListName(_listNameController.text);
    await prefs.setCalories(int.tryParse(_caloriesController.text) ?? 0);
    await prefs.setShowFileSize(_showFileSize);
    await prefs.setShowDate(_showDate);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved!')),
    );
  }

  @override
  void dispose() {
    _listNameController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }
}
