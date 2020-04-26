import 'package:flutter/material.dart';

// added more variables
class databaseEntry {
	String name;
	String image;
	int  calories;
	int totalfat;
	int sfat;
	int transfat;
	int cholesterol;
	int sodium;
	int tcarbo;
	int tsugar;
	int asugar;

	// t = total , a = added
	// Alice: Add more parameters here, like name, and build the argument list

		// added more parameters and built
		databaseEntry(name, image, calories, totalfat, sfat, transfat, cholesterol, sodium, tcarbo, tsugar, asugar) {
			this.name = name;
			this.image = image;
			this.calories = calories;
			this.totalfat = totalfat;
			this.sfat = sfat;
			this.transfat = transfat;
			this.cholesterol = cholesterol;
			this.sodium = sodium;
			this.tcarbo = tcarbo;
			this.tsugar = tsugar;
			this.asugar= asugar;
		}

//	databaseEntry(name) {
//		this.name = name;
//	}
}

class database {
	List allEntries = new List();

	database(){
		// Alice: Manually create the entries
		// this.addEntry( 'carrot', image?, 90 );
		this.addEntry("1 Egg (large)", "image?",	75,	5,	1.6,	0,	195,	65,	1,0,	0);
		this.addEntry("1 Milk (cup, whole)", "image?",	148,	8,	4.6,	0,	24,	32.2,	12,	12,	0);
		this.addEntry("1 Butter (tbs)", "image?",	102,	12,	7,	0.5,	31,	2,	0,	0,	0);
		this.addEntry("1 Yogurt (cup, plain, whole milk)", "image?",	150,	0.98,	0.25,	0,	12,	88,	9,	8,	0);
		this.addEntry("1 Banana (medium)", "image?",	105,	0.4,	0.1,	0,	0,	1,	27,	14,	0);
		this.addEntry("1 Applesauce (cup, unsweetened)", "image?",	103,	0.2,	0,	0,	0,	5,	27,	23,	0);
		this.addEntry("1 Silken Tofu (cup)", "image?",	188,	12,	1.8,	0,	0,	18,	4.6,	0,	0);
		this.addEntry("1 Sour Cream (tbs)",	 "image?", 23,	2.4,	1.4,	0,	6,	10,	0.3,	0.3,	0);
		this.addEntry("1 Buttermilk (cup)", "image?",	99,	2.2,	1.3,	0,	10,	257, 12,	12,	0);
		this.addEntry("1 Half and Half (tbs)", "image?",	20,	1.75,	1,	0,	7.5,	12.5,	0.5,	1,	0,);
	}

	// Alice: If you add more parameters to databaseEntry, you have to change this as well

		// added more parameters
		addEntry(name, image, calories , totalfat, sfat, transfat, cholesterol, sodium, tcarbo, tsugar, asugar) {
			databaseEntry newEntry = new databaseEntry(name, image, calories, totalfat, sfat, transfat, cholesterol, sodium, tcarbo, tsugar, asugar);
			allEntries.add(newEntry);
		}

	/*addEntry(name){
		databaseEntry newEntry = new databaseEntry(name);
		allEntries.add(newEntry);
	}*/

	int getLength() { return allEntries.length; }
	databaseEntry getEntry(int i) { return allEntries[i]; }
}