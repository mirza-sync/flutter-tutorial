// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import './bluetooth.dart';

void main() => runApp(FlutterBlueApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name AAAAAA',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: FlutterBlueApp(),
    );
  }
}

class MyClass extends StatefulWidget {
  @override
  _MyClassState createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {
  final bluetoothList = [
    "Mirza",
    "Iyad",
    "Ying Wei",
    "Yushu",
    "Nano",
    "Dr Lim",
    "Carol",
    "Revon",
    "Kak Aieshah"
  ];
  final wifiList = ["SP_1G", "SP_2G", "SP_3G", "SP_4G", "SP_5G"];
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return _bLListScreen(bluetoothList);
                    }),
                  );
                },
                child: Text('Scan Bluetooh Devices',
                    style: TextStyle(fontSize: 20)),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Settings', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bLListScreen(List<String> bl) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Scanned Bluetooth"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: _buildList(bl),
      ),
    );
  }

  Widget _buildList(List<String> bluetoothList) {
    return ListView.separated(
      itemCount: bluetoothList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(bluetoothList[index]),
          trailing: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return _WifiScreenState(wflist: wifiList);
                }),
              );
            },
            child: Text('Connect', style: TextStyle(fontSize: 15)),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class _WifiScreenState extends StatelessWidget {
  final List<String> wflist;
  _WifiScreenState({this.wflist});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Choose WIFI"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: ListView.separated(
          itemCount: wflist.length,
          itemBuilder: (BuildContext context, int index) {
            return TextButton(
              child: Text(wflist[index]),
              onPressed: () {
                print(wflist[index]);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }
}

// ============================================================================================

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
              actions: [
                IconButton(icon: Icon(Icons.list), onPressed: _pushHome),
              ],
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  void _pushHome() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Enabled Button',
                      style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name UUUUUUUU'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
