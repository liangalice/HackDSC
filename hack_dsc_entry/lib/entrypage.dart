import 'package:flutter/material.dart';
import 'database.dart';

class EntryPage extends MaterialPageRoute<Null> {
    final databaseEntry entry;
    EntryPage({this.entry}) : super(builder: (BuildContext ctx) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Theme.of(ctx).canvasColor,
                elevation: 1.0,
            ),
            body: Center(
                child: RaisedButton(
                    onPressed: () {
                        Navigator.pop(
                            ctx
                        );
                    },
                    child: Text(entry.name),
                ),
            ),
        );
    });
}