import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
// import 'package:flutter_masked_text/flutter_masked_text.dart';

class CityDropdown extends StatefulWidget {
  @override
  _CityDropDownState createState() => _CityDropDownState();
}

class _CityDropDownState extends State<CityDropdown> {
  //  static final List<String> _dropdownItems = <String>['India', 'USA'];
  static final List<CountryModel> _dropdownItems = <CountryModel>[
    CountryModel(city: 'India'),
    CountryModel(city: 'USA')
  ];
  // static List<CountryModel> _dropdownItems = List();
  final formKey = new GlobalKey<FormState>();

  CountryModel _dropdownValue;

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     _dropdownItems.add(CountryModel(city: 'India'));
  //     _dropdownItems.add(CountryModel(city: 'USA'));
  //     // _dropdownValue = _dropdownItems[0];
  //     // phoneController.text = _dropdownValue.countryCode;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(4), child: _buildCountry());
  }

  Widget _buildCountry() {
    return FormField(
      builder: (FormFieldState state) {
        return DropdownButtonHideUnderline(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InputDecorator(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  // hintText: 'Choose City',
                  hintText: AppLocalizations.of(context).translate('City_Str'),
                  hintStyle: TextStyle(
                    fontFamily: locator<PrefsService>().appLanguage == 'en'
                        ? 'en'
                        : 'ar',
                  ),
                ),
                isEmpty: _dropdownValue == null,
                child: DropdownButton<CountryModel>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  value: _dropdownValue,
                  isDense: true,
                  onChanged: (CountryModel newValue) {
                    print('value change');
                    print(newValue);
                    setState(() {
                      _dropdownValue = newValue;
                      // phoneController.text = _dropdownValue.countryCode;
                    });
                  },
                  items: _dropdownItems.map((CountryModel value) {
                    return DropdownMenuItem<CountryModel>(
                      value: value,
                      child: Text(
                        value.city,
                        style: TextStyle(
                          fontFamily:
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'en'
                                  : 'ar',
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CountryModel {
  final String city;

  CountryModel({
    this.city,
  });
}
