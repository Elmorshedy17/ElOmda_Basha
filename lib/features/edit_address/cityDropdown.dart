import 'package:flutter/material.dart';
import 'package:momentoo/features/edit_address/dropdown_data.dart';
import 'package:momentoo/features/new_address/dropdown_data.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class CityDropdown extends StatefulWidget {

  var cities;
  CityDropdown(this.cities);

  @override
  _CityDropDownState createState() => _CityDropDownState();
}

class _CityDropDownState extends State<CityDropdown> {


  final formKey = new GlobalKey<FormState>();

  String _mySelection;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FormField(
        builder: (FormFieldState state) {
          return DropdownButtonHideUnderline(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new  InputDecorator(
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
                    hintText: AppLocalizations.of(context).translate(
                        'City_Str'),
                    hintStyle: TextStyle(
                      fontFamily: locator<PrefsService>().appLanguage == 'en'
                          ? 'en'
                          : 'ar',
                    ),
                  ),
                  isEmpty: _mySelection == null,
                  child: DropdownButton(
                    isDense: true,
                    items:
                    widget.cities.map<DropdownMenuItem<String>>((item) {
                      return new DropdownMenuItem(
                        child: new Text(item.name),
                        value: item.id.toString(),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        _mySelection = newVal;
                      });
                      locator<EditDrobDownBloc>().DrobDownvalueSink.add(newVal);

                      print("${locator<EditDrobDownBloc>().currentDrobDownvalue} _mySelection");
                    },
                    value: _mySelection,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}