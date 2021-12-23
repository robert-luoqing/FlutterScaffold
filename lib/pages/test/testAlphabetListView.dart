import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../common/controlls/alphabetList/alphabetBindListModel.dart';
import 'package:flutter/services.dart';

import '../../common/controlls/scaffold.dart';

import '../../common/controlls/alphabetList/alphabetListView.dart';
import 'package:flutter/material.dart';

class TestAlphabetListView extends StatefulWidget {
  const TestAlphabetListView({Key? key}) : super(key: key);

  @override
  _TestAlphabetListViewState createState() => _TestAlphabetListViewState();
}

class _TestAlphabetListViewState extends State<TestAlphabetListView> {
  late TextEditingController _textController;
  List<Map<dynamic, dynamic>> _allCountries = [];
  List<AlphabetHeader<Map>> filterCountries = [];

  _loadCountry() async {
    var value = await rootBundle.loadString('assets/data/countryCode.json');
    List<dynamic> _jsonData = json.decode(value);
    _jsonData.sort((a, b) =>
        a["countryName"].toString().compareTo(b["countryName"].toString()));
    _allCountries = List<Map<dynamic, dynamic>>.from(_jsonData);
    this._constructAlphabet(this._allCountries);
  }

  _constructAlphabet(Iterable<Map<dynamic, dynamic>> data) {
    var _countries = convertListToAlphaHeader<Map<dynamic, dynamic>>(
        data,
        (item) =>
            (item["countryName"].toString()).substring(0, 1).toUpperCase());
    this.setState(() {
      this.filterCountries = _countries;
    });
  }

  _didSearch() {
    var keywork = this._textController.text;
    var filterCountries = this._allCountries.where((item) => item["countryName"]
        .toString()
        .toLowerCase()
        .contains(keywork.toLowerCase()));
    this._constructAlphabet(filterCountries);
  }

  @override
  void initState() {
    this._loadCountry();

    _textController = TextEditingController(text: '');
    _textController.addListener(this._didSearch);
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: Text("Test Alphabet List View"),
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
              child: CupertinoSearchTextField(controller: _textController),
            ),
            Expanded(
              flex: 1,
              child: SPAlphabetListView<AlphabetHeader, Map>(
                source: filterCountries,
                onFetchListData: (header) => List<Map>.from(header.items),
                headerBuilder: (context, headerData, headerIndex) {
                  return Container(
                    color: Color(0xFFF3F4F5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      child: Text(
                        headerData.alphabet,
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFF767676)),
                      ),
                    ),
                  );
                },
                itemBuilder:
                    (context, itemData, itemIndex, headerData, headerIndex) {
                  return Container(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: ListTile(
                        title: Text(itemData["countryName"] as String),
                        trailing: Text(itemData["phoneCode"] as String)),
                  ));
                },
                alphabetBuilder:
                    (context, headerData, isCurrent, headerIndex) => isCurrent
                        ? SizedBox(
                            width: 18,
                            height: 18,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(9)),
                                child: Center(
                                    child: Text(
                                  headerData.alphabet,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ))))
                        : Text(
                            headerData.alphabet,
                            style: TextStyle(color: Color(0xFF767676)),
                          ),
                alphabetTipBuilder: (context, headerData) {
                  return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xCC000000)),
                      width: 50,
                      height: 50,
                      child: Center(
                        child: Text(
                          headerData.alphabet,
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ));
                },
              ),
            ),
          ],
        ));
  }
}
