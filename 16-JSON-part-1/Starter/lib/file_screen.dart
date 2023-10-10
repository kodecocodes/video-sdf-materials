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

import 'file_helper.dart';

class FileScreen extends StatefulWidget {
  final String? fileName;
  const FileScreen({this.fileName, super.key});

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  final TextEditingController _fileNameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String _statusMessage = '';
  final FileHelper _fileHelper = FileHelper();

  @override
  void initState() {
    super.initState();
    if (widget.fileName != null) {
      _fileNameController.text = widget.fileName!;
      _readFile();
    }
  }

  @override
  void dispose() {
    _fileNameController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _readFile() async {
    final content = await _fileHelper.readFile(_fileNameController.text);
    _contentController.text = content;
    setState(() {
      _statusMessage = 'File content retrieved.';
      _showMessage();
    });
  }

  Future<void> _writeFile() async {
    await _fileHelper.writeFile(
        _fileNameController.text, _contentController.text);
    setState(() {
      _statusMessage = 'File successfully saved.';
      _showMessage();
    });
  }

  Future<void> _deleteFile() async {
    await _fileHelper.deleteFile(_fileNameController.text);
    _contentController.clear();
    setState(() {
      _statusMessage = 'File deleted.';
      _showMessage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.fileName ?? 'New File'), 
          actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteFile().then((value) {
                Navigator.pop(context);
              });
            },
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: _writeFile,
          child: const Icon(Icons.save),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
              TextField(
                controller: _fileNameController,
                decoration: const InputDecoration(labelText: 'File Name'),
              ),
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 10,
              ),
            ])));
  }

  void _showMessage() {
    if (_statusMessage != '') {
      final snackBar = SnackBar(content: Text(_statusMessage));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      _statusMessage = '';
    }
  }

  
}
