import 'package:flutter/material.dart';

class databaseEntry {
	String name;

	databaseEntry(name) {
		this.name = name;
	}


}

class database {
	List allEntries = new List();

	database(){
		this.addEntry('item 1');
		this.addEntry('item 2');
		this.addEntry('item 3');
		this.addEntry('New item');
	}

	addEntry(name){
		databaseEntry newEntry = new databaseEntry(name);
		allEntries.add(newEntry);
	}

	int getLength() { return allEntries.length; }
	databaseEntry getEntry(int i) { return allEntries[i]; }
}