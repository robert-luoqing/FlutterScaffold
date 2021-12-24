import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:section_view/section_view.dart';
import '../../common/controlls/scaffold.dart';

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
    for (var item in _allCountries) {
      var rng = new Random();
      item["height"] = 40.0 + rng.nextInt(40);
    }
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
              child: SectionView<AlphabetHeader, Map>(
                source: filterCountries,
                onFetchListData: (header) => List<Map>.from(header.items),
                enableSticky: true,
                alphabetAlign: Alignment.center,
                alphabetInset: const EdgeInsets.all(4.0),
                // physics: const ClampingScrollPhysics(),
                headerBuilder: getDefaultHeaderBuilder((d) => d.alphabet),
                alphabetBuilder: getDefaultAlphabetBuilder((d) => d.alphabet),
                tipBuilder: getDefaultTipBuilder((d) => d.alphabet),
                refreshBuilder:
                    (isRefreshing, onRefresh, isBouncePhysic, child) {
                  if (isBouncePhysic) {
                    return SectionViewBouncingScrollRefresh(
                      isRefreshing: isRefreshing,
                      onRefresh: onRefresh,
                    );
                  } else {
                    return RefreshIndicator(
                        onRefresh: onRefresh, child: child ?? Container());
                  }
                },
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 2));
                },
                itemBuilder:
                    (context, itemData, itemIndex, headerData, headerIndex) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: SizedBox(
                      height: itemData["height"] as double,
                      child: ListTile(
                          title: Text(itemData["countryName"] as String),
                          trailing: Text(itemData["phoneCode"] as String)),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
