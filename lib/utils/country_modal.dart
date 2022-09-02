import 'package:flutter/material.dart';
import 'package:countries/countries.dart';

import '../constants/constants.dart';

/// Returns true when a country should be included in lists / dialogs
/// offered to the user.
typedef ItemFilter = bool Function(Country country);

typedef ItemBuilder = Widget Function(Country country);

class CountryItemWidget extends StatelessWidget {
  final Country country;
  final ValueChanged<Country> onTap;

  const CountryItemWidget(
      this.country, {
        Key? key,
        required this.onTap,
      }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(country),
      child: Row(
        children: [
          CountryFlagWidget(
            country,
            width: 35,
          ),
          SizedBox(width: 10),
          Flexible(
            child: Text('${country.name} (+${country.phoneCode})'),
          ),
        ],
      ),
    );
  }
}

class CountriesSearchWidget extends StatelessWidget {
  final List<Country> allCountries;
  final ValueChanged<List<Country>> onChange;
  final SearchWidgetStyle? style;

  const CountriesSearchWidget({
    Key? key,
    required this.allCountries,
    required this.onChange,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: inputFieldFocusedColor,
      decoration:
      style?.searchInputDecoration ?? InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: "Search",
          fillColor: Colors.grey[300],
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(inputFieldBorderRadius),
          //   borderSide: const BorderSide(
          //     color: inputFieldEnabledColor,
          //     width: inputFieldBorderWidth,
          //   ),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(inputFieldBorderRadius),
          //   borderSide: const BorderSide(
          //     color: inputFieldFocusedColor,
          //     width: inputFieldBorderWidth,
          //   ),
          // ),
      ),
      onChanged: (v) {
        bool searchFilter(Country c) =>
            style?.searchFilter?.call(c, v) ??
                c.name.toLowerCase().startsWith(v.toLowerCase()) ||
                    c.phoneCode.startsWith(v.toLowerCase()) ||
                    c.isoCode.toLowerCase().startsWith(v.toLowerCase()) ||
                    c.iso3Code.toLowerCase().startsWith(v.toLowerCase());
        onChange([
          for (final c in allCountries)
            if (searchFilter(c)) c
        ]);
      },
    );
  }
}

///Predicate to be satisfied in order to add country to search list
typedef SearchFilter = bool Function(Country country, String searchWord);

class SearchWidgetStyle {
  final Color? searchCursorColor;

  final InputDecoration? searchInputDecoration;

  ///Filters the country list for search
  final SearchFilter? searchFilter;

  SearchWidgetStyle({
    this.searchCursorColor,
    this.searchInputDecoration,
    this.searchFilter,
  });
}


void showCountriesBottomSheet(
    BuildContext context, {
      required ValueChanged<Country> onValuePicked,
      ItemBuilder? itemBuilder,
      ItemFilter? itemFilter,
      Comparator<Country>? sortComparator,
      List<Country> priorityList = const [],
      SearchWidgetStyle? searchWidgetStyle,
      Widget? searchEmptyView,
      bool popOnPick = true,
    }) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => CountryBottomSheet(
      onValuePicked: onValuePicked,
      itemBuilder: itemBuilder,
      sortComparator: sortComparator,
      priorityList: priorityList,
      searchWidgetStyle: searchWidgetStyle,
      searchEmptyView: searchEmptyView,
      popOnPick: popOnPick,
    ),
  );
}

class CountryBottomSheet extends StatefulWidget {
  /// Callback that is called with selected Country
  final ValueChanged<Country> onValuePicked;

  /// Filters the available country list
  final ItemFilter? itemFilter;

  /// [Comparator] to be used in sort of country list
  final Comparator<Country>? sortComparator;

  /// List of countries that are placed on top
  final List<Country> priorityList;

  ///Callback that is called with selected item of type Country which returns a
  ///Widget to build list view item inside dialog
  final ItemBuilder? itemBuilder;

  final SearchWidgetStyle? searchWidgetStyle;

  ///The search empty view is displayed if nothing returns from search result
  final Widget? searchEmptyView;

  ///By default the dialog will be popped of the navigator on selection of a value.
  ///Set popOnPick to false to prevent this behaviour.
  final bool popOnPick;

  const CountryBottomSheet({
    Key? key,
    required this.onValuePicked,
    this.itemFilter,
    this.sortComparator,
    this.priorityList = const [],
    this.itemBuilder,
    this.popOnPick = true,
    this.searchWidgetStyle,
    this.searchEmptyView,
  }) : super(key: key);

  @override
  SingleChoiceDialogState createState() {
    return SingleChoiceDialogState();
  }
}

class SingleChoiceDialogState extends State<CountryBottomSheet> {
  late List<Country> _allCountries;

  late List<Country> _filteredCountries;

  @override
  void initState() {
    _allCountries = [
      for (final v in CountriesRepo.countryList)
        if (widget.itemFilter?.call(v) ?? true) v
    ];

    if (widget.sortComparator != null) {
      _allCountries.sort(widget.sortComparator);
    }

    if (widget.priorityList.isNotEmpty) {
      for (final country in widget.priorityList) {
        _allCountries.removeWhere((c) => country.isoCode == c.isoCode);
      }
      _allCountries.insertAll(0, widget.priorityList);
    }

    _filteredCountries = _allCountries;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height / 3 * 2,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor.withAlpha(240),
      ),
      child: Column(
        children: [
          CountriesSearchWidget(
            allCountries: _allCountries,
            onChange: (v) => setState(() => _filteredCountries = v),
            style: widget.searchWidgetStyle,
          ),
          SizedBox(height: 10),
          if (_filteredCountries.isEmpty)
            widget.searchEmptyView ?? Center(child: Text('No country found.'))
          else
            Expanded(
              child: ListView.builder(
                itemCount: _filteredCountries.length,
                itemBuilder: (_, i) => Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: widget.itemBuilder?.call(_filteredCountries[i]) ??
                      CountryItemWidget(
                        _filteredCountries[i],
                        onTap: (v) {
                          widget.onValuePicked(v);
                          if (widget.popOnPick) Navigator.pop(context);
                        },
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
