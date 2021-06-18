import 'package:currency_pickers/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:currency_pickers/currency_pickers.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/provider/operation.dart';

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Operation_provider>(
      create: (context) => Operation_provider(),
      child: MaterialApp(
        title: 'Currency Pickers Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => DemoPage(),
        },
      ),
    );
  }
}

class DemoPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DemoPage> {
  Country _selectedDialogCountry =
      CurrencyPickerUtils.getCountryByCurrencyCode('USD');

  Country _selectedFilteredDialogCountry =
      CurrencyPickerUtils.getCountryByCurrencyCode('USD');

  Country selectedCupertinoCountry =
      CurrencyPickerUtils.getCountryByIsoCode('tr');

  Country _selectedFilteredCupertinoCountry =
      CurrencyPickerUtils.getCountryByIsoCode('DE');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Pickers Demo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('CurrencyPickerDropdown'),
                ListTile(title: _buildCurrencyPickerDropdown(false)),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('CurrencyPickerDropdown (filtered)'),
                ListTile(title: _buildCurrencyPickerDropdown(true)),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('CurrencyPickerDialog'),
                ListTile(
                  onTap: _openCurrencyPickerDialog,
                  title: _buildDialogItem(_selectedDialogCountry),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('CurrencyPickerDialog (filtered)'),
                ListTile(
                  onTap: _openFilteredCurrencyPickerDialog,
                  title: _buildDialogItem(_selectedFilteredDialogCountry),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('CurrencyPickerCupertino'),
                ListTile(
                  title: buildCupertinoSelectedItem(selectedCupertinoCountry),
                  onTap: openCupertinoCurrencyPicker,
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('CurrencyPickerCupertino (filtered)'),
                ListTile(
                  title: buildCupertinoSelectedItem(
                      _selectedFilteredCupertinoCountry),
                  onTap: _openFilteredCupertinoCurrencyPicker,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildCurrencyPickerDropdown(bool filtered) => Row(
        children: <Widget>[
          CurrencyPickerDropdown(
            initialValue: 'AR',
            itemBuilder: _buildDropdownItem,
            itemFilter: filtered
                ? (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode)
                : null,
            onValuePicked: (Country country) {
              print("${country.name}");
            },
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Phone"),
            ),
          )
        ],
      );

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CurrencyPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.currencyCode}(${country.isoCode})"),
          ],
        ),
      );

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CurrencyPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Text("+${country.currencyCode}"),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      );

  void _openCurrencyPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: CurrencyPickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration: InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: Text('Select your phone code'),
                onValuePicked: (Country country) =>
                    setState(() => _selectedDialogCountry = country),
                itemBuilder: _buildDialogItem)),
      );

  void _openFilteredCurrencyPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: CurrencyPickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration: InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: Text('Select your phone code'),
                onValuePicked: (Country country) =>
                    setState(() => _selectedFilteredDialogCountry = country),
                itemFilter: (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
                itemBuilder: _buildDialogItem)),
      );

  void openCupertinoCurrencyPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CurrencyPickerCupertino(
            backgroundColor: Colors.black,
            itemBuilder: _buildCupertinoItem,
            pickerSheetHeight: 300.0,
            pickerItemHeight: 75,
            initialCountry: selectedCupertinoCountry,
            onValuePicked: (Country country) {
              var bloc =
                  Provider.of<Operation_provider>(context, listen: false);
              // Currency curr = Currency.create(country.currencyCode, 2);
              // bloc.usd = Currency.create(country.currencyCode, 2);
              // Money lowPrice = Money.fromInt(10335, bloc.usd);
              // print(lowPrice.format('SCC000.000'));
              // print(lowPrice.format('CCC 0.0'));
              // print('country ${country.currencyCode}');
              setState(() => selectedCupertinoCountry = country);
            });
      });

  void _openFilteredCupertinoCurrencyPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CurrencyPickerCupertino(
          backgroundColor: Colors.white,
          pickerSheetHeight: 200.0,
          initialCountry: _selectedFilteredCupertinoCountry,
          onValuePicked: (Country country) =>
              setState(() => _selectedFilteredCupertinoCountry = country),
          itemFilter: (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
        );
      });

  Widget buildCupertinoSelectedItem(Country country) {
    return Row(
      children: <Widget>[
        CurrencyPickerUtils.getDefaultFlagImage(country),
        SizedBox(width: 8.0),
        Text("+${country.currencyCode}"),
        SizedBox(width: 8.0),
        Flexible(child: Text(country.name))
      ],
    );
  }

  Widget _buildCupertinoItem(Country country) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.white,
        fontSize: 16.0,
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 8.0),
          CurrencyPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Text("+${country.currencyCode}"),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      ),
    );
  }
}
