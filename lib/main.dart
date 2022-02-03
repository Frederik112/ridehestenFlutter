// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.red[900],
        primarySwatch: Colors.red,
      ),
      home: const RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.arrow_drop_down_circle),
            title: Text(pair.asCamelCase),
            trailing: Wrap(children: const <Widget>[
              Icon(Icons.favorite_outline),
              Icon(Icons.share)
            ]),
            subtitle: Text(
              'Teaser text',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Table(columnWidths: const {
              0: FlexColumnWidth(0.3)
            }, children: [
              _cardTextDetail("Type", "Hingst"),
              _cardTextDetail("Højde", "174 cm"),
              _cardTextDetail("Far", "Alfred af Daneborg"),
              _cardTextDetail("Morfar", "Oscar af Marienborg")
            ]),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  // Perform some action
                },
                child: Text(
                  'LÆS MERE',
                  style: TextStyle(color: (Colors.red[900])),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _cardTextDetail(String name, String value) {
    // return Row(children: [
    //   Column(children: [Text(name)]),
    //   Column(children: [Text(value)])
    // ], mainAxisAlignment: MainAxisAlignment.start);
    return TableRow(children: [
      Text(
        name + ":",
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      Text(value)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}
