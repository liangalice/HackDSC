import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MyHomePage extends StatefulWidget {
    MyHomePage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    final TextEditingController _searchbarFilter = new TextEditingController();

    final dio = new Dio();

    String _searchText = "";

    List searchNames = new List();

    List filteredSearchNames = new List();

    Icon _searchIcon = new Icon(Icons.search);

    Widget _appBarTitle = new Text( 'Search Example' );

    _MyHomePageState() {
        _searchbarFilter.addListener(() {
            if (_searchbarFilter.text.isEmpty) {
                setState(() {
                    _searchText = "";
                    filteredSearchNames = searchNames;
                });
            } else {
                setState(() {
                    _searchText = _searchbarFilter.text;
                });
            }
        });
    }

    @override
    void initState() {
        this._getSearchNames();
        super.initState();
    }

    Widget build(BuildContext context) {
        return Scaffold(
                appBar: _buildBar(context),
            body: Container(
                child: _buildList(),
            ),
            resizeToAvoidBottomPadding: false,
        );
    }

    Widget _buildBar(BuildContext context) {
        return new AppBar(
            centerTitle: true,
            title: _appBarTitle,
            leading: new IconButton(
                icon: _searchIcon,
                onPressed: _searchPressed,

            ),
        );
    }

    // Builds the visual for the list
    Widget _buildList() {
        if (!(_searchText.isEmpty)) {
            List tempList = new List();
            for (int i = 0; i < filteredSearchNames.length; i++) {
                if (filteredSearchNames[i]['name'].toLowerCase().contains(_searchText.toLowerCase())) {
                    tempList.add(filteredSearchNames[i]);
                }
            }
                filteredSearchNames = tempList;
            }
            return ListView.builder(
            itemCount: searchNames == null ? 0 : filteredSearchNames.length,
            itemBuilder: (BuildContext context, int index) {
                return new ListTile(
                    title: Text(filteredSearchNames[index]['name']),
                    onTap: () => print(filteredSearchNames[index]['name']),
                );
            },
        );
    }

    // Builds the initial list of items in the database
    void _getSearchNames() async {
        final response = await dio.get('https://swapi.co/api/people');
        List tempList = new List();
        for (int i = 0; i < response.data['results'].length; i++) {
            tempList.add(response.data['results'][i]);
        }

        setState(() {
            searchNames = tempList;
            filteredSearchNames = searchNames;
        });
    }

    // Change the search bar's appearance when it is tapped
    void _searchPressed() {
        setState(() {
            // If the search bar wasn't already selected
            if (this._searchIcon.icon == Icons.search) {
                this._searchIcon = new Icon(Icons.close);
                this._appBarTitle = new TextField(
                    controller: _searchbarFilter,
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search),
                        hintText: 'Search...'
                    ),
                );
            }
            // If the search bar was already selected
            else {
                this._searchIcon = new Icon(Icons.search);
                this._appBarTitle = new Text('Search Example');
                filteredSearchNames = searchNames;
                _searchbarFilter.clear();
            }
        });
    }
}