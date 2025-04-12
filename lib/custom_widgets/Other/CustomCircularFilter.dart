import 'package:flutter/material.dart';

import '../../../custom_widgets/Buttons/CustomFilledButton.dart';

class CustomCircularFilter extends StatefulWidget {
  final List<Map<String,dynamic>> filters;
  final void Function(dynamic value) onChanged;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool withCount;
  final int value;
  CustomCircularFilter({super.key, required this.filters, this.fontWeight, this.fontSize, required this.onChanged, required this.value}) : withCount = false;
  CustomCircularFilter.count({super.key, required this.filters, this.fontWeight, this.fontSize, required this.onChanged, required this.value}) : withCount = true;

  @override
  State<CustomCircularFilter> createState() => _CustomCircularFilterState();
}

class _CustomCircularFilterState extends State<CustomCircularFilter> {
   List<Map<String,dynamic>> _filters = [];

  int _choosedFilter = 0;

  @override
  void initState() {
    super.initState();
    _choosedFilter = widget.value;
    _filters = widget.filters;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: Material(
        color: Colors.transparent,
        child: ListView.builder(
          clipBehavior: Clip.hardEdge,
          scrollDirection: Axis.horizontal,
          itemCount: _filters.length,
          itemBuilder: (context, i) {
            return Padding(
              padding: i != _filters.length ? EdgeInsets.only(right: 5) : EdgeInsets.zero,
              child: AnimatedSwitcher(
                switchOutCurve: Curves.easeIn,
                switchInCurve: Curves.easeOut,
                duration: Duration(milliseconds: 300),
                child: _choosedFilter == i
                    ? CustomFilledButton.min(
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight,
                  borderRadius: 50,
                  key: Key("value"),
                  text: widget.withCount ? "${_filters[i]['name']} (${_filters[i]['count']})" : _filters[i]['name'],
                  textColor: Colors.white,
                  backgroundColor: Color(0xFF0065FF),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  callback: (){

                  },
                )
                    : CustomFilledButton.min(
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight,
                  borderRadius: 50,
                  key: Key("value2"),
                  text: widget.withCount ? "${_filters[i]['name']} (${_filters[i]['count']})" : _filters[i]['name'],
                  textColor: Color(0xFF363636),
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  callback: (){
                    _choosedFilter = i;
                    widget.onChanged(_choosedFilter);
                    setState(() {});
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
