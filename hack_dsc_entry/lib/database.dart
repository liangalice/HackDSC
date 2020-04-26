import 'package:flutter/material.dart';

class databaseEntry {
	String name;

	// Alice: Add more parameters here, like name, and build the argument list
	/*
		databaseEntry(name, image, calories) {
			this.name = name;
			this.image = image;
			this.calories = calories;
		}
	*/
	databaseEntry(name) {
		this.name = name;
	}
}

class database {
	List allEntries = new List();

	database(){
		// Alice: Manually create the entries
		// this.addEntry( 'carrot', image?, 90 );
		this.addEntry('item 1');
		this.addEntry('item 2');
		this.addEntry('item 3');
		this.addEntry('New item');
		this.addEntry('carrot');
	}

	// Alice: If you add more parameters to databaseEntry, you have to change this as well
	/*
		addEntry(name, image, calories) {
			databaseEntry newEntry = new databaseEntry(name, image, calories);
			allEntries.add(newEntry);
		}
	*/
	addEntry(name){
		databaseEntry newEntry = new databaseEntry(name);
		allEntries.add(newEntry);
	}

	int getLength() { return allEntries.length; }
	databaseEntry getEntry(int i) { return allEntries[i]; }
}