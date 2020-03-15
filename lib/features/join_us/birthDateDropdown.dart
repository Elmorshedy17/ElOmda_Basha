import 'package:flutter/material.dart';

class BirthDateDropdown extends StatefulWidget {
  @override
  _BirthDateDropdownState createState() => _BirthDateDropdownState();
}

class _BirthDateDropdownState extends State<BirthDateDropdown> {
  final List<DayModel> _dropdownDayItems = List();
  final List<MonthModel> _dropdownMonthItems = <MonthModel>[
    MonthModel(month: 'January'),
    MonthModel(month: 'February'),
    MonthModel(month: 'March'),
    MonthModel(month: 'April'),
    MonthModel(month: 'May'),
    MonthModel(month: 'June'),
    MonthModel(month: 'July'),
    MonthModel(month: 'August'),
    MonthModel(month: 'September'),
    MonthModel(month: 'October'),
    MonthModel(month: 'November'),
    MonthModel(month: 'December'),
  ];
  final List<YearModel> _dropdownYearItems = List();

  @override
  void initState() {
    super.initState();

    for (var i = 0; i <= 30; i++) {
      _dropdownDayItems.add(DayModel(day: '${i + 1}'));
    }

    for (var i = DateTime.now().year - 70; i <= DateTime.now().year - 15; i++) {
      _dropdownYearItems.add(YearModel(year: '${i + 1}'));
    }
  }

  DayModel _dropdownDayValue;
  MonthModel _dropdownMonthValue;
  YearModel _dropdownYearValue;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 100,
        // padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: _buildDay()),
              // SizedBox(
              //   width: 4,
              // ),
              _buildMonth(),
              // SizedBox(
              //   width: 4,
              // ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: _buildYear()),
            ],
          ),
        ));
  }

  Widget _buildDay() {
    // return FormField(
    //   builder: (FormFieldState state) {
    return DropdownButtonHideUnderline(
      key: Key('day'),
      child:
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   children: <Widget>[
          Container(
        width: MediaQuery.of(context).size.width * 0.21,
        child: InputDecorator(
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            filled: true,
            // hintText: 'Day',
          ),
          isEmpty: _dropdownDayValue == null,
          child: FittedBox(
            child: DropdownButton<DayModel>(
              hint: Text(
                'Day',
                // style: TextStyle(fontSize: 12),
              ),
              icon: Icon(Icons.keyboard_arrow_down),
              value: _dropdownDayValue,
              isDense: true,
              onChanged: (DayModel newValue) {
                print('value change');
                print(newValue);
                setState(() {
                  _dropdownDayValue = newValue;
                });
              },
              items: _dropdownDayItems.map((DayModel value) {
                return DropdownMenuItem<DayModel>(
                  value: value,
                  child: Text(value.day),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      //   ],
      // ),
    );
    //   },
    // );
  }

  Widget _buildMonth() {
    // return FormField(
    //   builder: (FormFieldState state) {
    return DropdownButtonHideUnderline(
      key: Key('month'),
      child:
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   children: <Widget>[
          Container(
        width: MediaQuery.of(context).size.width * 0.36,
        child: InputDecorator(
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            filled: true,
            // hintText: 'Month',
          ),
          isEmpty: _dropdownDayValue == null,
          child: FittedBox(
            child: DropdownButton<MonthModel>(
              hint: Text(
                'Month',
                // style: TextStyle(fontSize: 12),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                // size: 12,
              ),
              value: _dropdownMonthValue,
              isDense: true,
              onChanged: (MonthModel newValue) {
                print('value change');
                print(newValue);
                setState(() {
                  _dropdownMonthValue = newValue;
                });
              },
              items: _dropdownMonthItems.map((MonthModel value) {
                return DropdownMenuItem<MonthModel>(
                  value: value,
                  child: Text(value.month),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      //   ],
      // ),
    );
    //   },
    // );
  }

  Widget _buildYear() {
    // return FormField(
    //   builder: (FormFieldState state) {
    return DropdownButtonHideUnderline(
      key: Key('year'),
      child:
          //  Column(
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   children: <Widget>[
          Container(
        width: MediaQuery.of(context).size.width * 0.25,
        child: InputDecorator(
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            filled: true,
            // hintText: 'Year',
          ),
          isEmpty: _dropdownDayValue == null,
          child: FittedBox(
            child: DropdownButton<YearModel>(
              isExpanded: false,
              hint: Text(
                'Year',
                // style: TextStyle(fontSize: 12),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                // size: 16,
              ),
              value: _dropdownYearValue,
              isDense: true,
              onChanged: (YearModel newValue) {
                print('value change');
                print(newValue);
                setState(() {
                  _dropdownYearValue = newValue;
                });
              },
              items: _dropdownYearItems.map((YearModel value) {
                return DropdownMenuItem<YearModel>(
                  value: value,
                  child: Text(value.year),
                );
              }).toList(),
            ),
          ),
        ),
      ),

      //   ],
      // ),
    );
    //   },
    // );
  }
}

class DayModel {
  final String day;

  DayModel({
    this.day,
  });
}

class MonthModel {
  final String month;

  MonthModel({
    this.month,
  });
}

class YearModel {
  final String year;

  YearModel({
    this.year,
  });
}
