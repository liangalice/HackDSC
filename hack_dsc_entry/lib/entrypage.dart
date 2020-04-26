import 'package:flutter/material.dart';
import 'database.dart';

class EntryPage extends MaterialPageRoute<Null> {
    EntryPage() : super(builder: (BuildContext ctx) {
        databaseEntry entry;
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
                    child: Text("Go to Page Three"),
                ),
            ),
        );
    });
}