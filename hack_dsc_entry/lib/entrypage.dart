import 'package:flutter/material.dart';
import 'database.dart';

class EntryPage extends MaterialPageRoute<Null> {
    final databaseEntry entry;
    // When entry page is switched to, entry will be set to the ingredient that was tapped on.
    EntryPage({this.entry}) : super(builder: (BuildContext ctx) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Theme.of(ctx).canvasColor,
                elevation: 1.0,
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text(entry.name),
                        //calories, totalfat, sfat, transfat, cholesterol, sodium, tcarbo, tsugar, asugar
                        Text("Calories " + entry.calories.toString()),
                        Text("Saturated Fat " + entry.sfat.toString()),
                        Text("Trans Fat" + entry.transfat.toString()),
                        Text("Cholesterol " + entry.cholesterol.toString()),
                        Text("Sodium " + entry.sodium.toString()),
                        Text("Total Carbohydrates " + entry.tcarbo.toString()),
                        Text("Total Sugar " + entry.tsugar.toString()),
                        Text("Added Sugar " + entry.asugar.toString()),
                        RaisedButton(
                            onPressed: () {
                                Navigator.pop(
                                    ctx
                                );
                            },
                            child: Text("Back"),
                        ),
                    ],
                ),
            ),
        );
    });
}