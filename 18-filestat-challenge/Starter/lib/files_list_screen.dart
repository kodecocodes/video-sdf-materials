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

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'file_helper.dart';
import 'file_screen.dart';
import 'settings_screen.dart';
import 'sp_helper.dart';

class FileListScreen extends StatefulWidget {
  const FileListScreen({super.key});

  @override
  State<FileListScreen> createState() => _FileListScreenState();
}

class _FileListScreenState extends State<FileListScreen> {
  String _listName = '';
  bool _showSize = false;
  bool _showDate = false;

  @override
  void initState() {
    super.initState();
    _getSettings();
    //_getFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_listName),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (context) => const SettingsScreen()),
                ).then((dynamic value) {
                  _getSettings();
                });
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _openFileScreen,
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<List<FileSystemEntity>>(
          future: _getFiles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final file = snapshot.data![index] as File;
                  final date = file.lastModifiedSync();
                  final dateString = '${date.year}-${date.month}-${date.day}';
                  final size = file.lengthSync();
                  var subtitle = '';
                  if (_showSize) {
                    subtitle += 'File size: ${size.toString()} bytes - ';
                  }
                  if (_showDate) subtitle += 'Last modified: $dateString';
                  final fileName = file.path.split('/').last;
                  return Dismissible(
                    key: Key(fileName),
                    onDismissed: (direction) {
                      final fileHelper = FileHelper();
                      fileHelper.deleteFile(fileName).then((dynamic _) {
                        setState(() {});
                      });
                    },
                    child: ListTile(
                        title: Text(file.path.split('/').last),
                        subtitle: Text(subtitle),
                        onTap: () {
                          _openFileScreen(fileName: file.path.split('/').last);
                        } //() =>
                        //_openFileScreen(fileName: file.path.split('/').last),
                        ),
                  );
                },
              );
            }
          },
        ));
  }

  Future<void> _getSettings() async {
    final prefs = await SPHelper.getInstance();
    final settings = prefs.getAppSettings();

    _listName = settings.listName;
    _showSize = settings.showFileSize;
    _showDate = settings.showDate;
    setState(() {});
  }

  Future<List<FileSystemEntity>> _getFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.listSync().whereType<File>().toList();
  }

  void _openFileScreen({String? fileName}) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (context) => FileScreen(fileName: fileName),
      ),
    ).then((dynamic _) => setState(() {}));
  }
}
