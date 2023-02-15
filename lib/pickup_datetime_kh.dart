library pickup_datetime_kh;

import 'package:art_buttons_kh/art_buttons_kh.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PickUpDateTimeKh extends StatefulWidget {
  final Color? backgroundColor;
  final DateTime minimumDate;
  final DateTime maximumDate;
  final bool barrierDismissible;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function(DateTime, DateTime) onApplyClick;
  final Function() onCancelClick;
  final double? radius;
  final List<BoxShadow>? boxShadow;
  final Color btnRightBackgroundColor;
  final Color btnLeftBackgroundColor;
  final Color? btnLabelRightColor;
  final Color? btnLabelLeftColor;
  final String? btnLabelRight;
  final String? btnLabelLeft;
  final Color? colorLabel;
  final String? fontFamily;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Widget? header;
  const PickUpDateTimeKh({
    Key? key,
    this.backgroundColor,
    required this.minimumDate,
    required this.maximumDate,
    required this.barrierDismissible,
    this.initialStartDate,
    this.initialEndDate,
    required this.onApplyClick,
    required this.onCancelClick,
    this.radius,
    this.boxShadow,
    required this.btnLeftBackgroundColor,
    required this.btnRightBackgroundColor,
    this.btnLabelRightColor,
    this.btnLabelLeftColor,
    this.colorLabel,
    this.fontFamily,
    this.leftIcon,
    this.rightIcon,
    this.btnLabelRight,
    this.btnLabelLeft,
    this.header,
  }) : super(key: key);

  @override
  State<PickUpDateTimeKh> createState() => _PickUpDateTimeKhState();
}

class _PickUpDateTimeKhState extends State<PickUpDateTimeKh> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 0)),
        boxShadow: widget.boxShadow,
      ),
      child: Column(
        children: <Widget>[
          widget.header ?? Container(),
          DisplayCalendar(
            minimumDate: widget.minimumDate,
            maximumDate: widget.maximumDate,
            initialEndDate: widget.initialEndDate,
            initialStartDate: widget.initialStartDate,
            startEndDateChange: (DateTime startDateData, DateTime endDateData) {
              setState(() {
                startDate = startDateData;
                endDate = endDateData;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
            child: Row(
              children: [
                Expanded(
                  child: ArtButtonsKh(
                    text: widget.btnLabelLeft ?? "Cancel",
                    textColor: widget.btnLabelLeftColor,
                    backgroundColor: widget.btnLeftBackgroundColor,
                    onPressed: () {
                      try {
                        widget.onCancelClick();
                      } catch (_) {}
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ArtButtonsKh(
                    text: widget.btnLabelRight ?? 'Apply',
                    textColor: widget.btnLabelRightColor,
                    backgroundColor: widget.btnRightBackgroundColor,
                    onPressed: () {
                      try {
                        widget.onApplyClick(startDate!, endDate!);
                      } catch (_) {}
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DisplayCalendar extends StatefulWidget {
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function(DateTime, DateTime)? startEndDateChange;
  final Color? colorLabel;
  final String? fontFamily;
  final Widget? leftIcon;
  final Widget? rightIcon;
  const DisplayCalendar({
    Key? key,
    this.minimumDate,
    this.maximumDate,
    this.initialStartDate,
    this.initialEndDate,
    this.startEndDateChange,
    this.colorLabel,
    this.fontFamily,
    this.leftIcon,
    this.rightIcon,
  }) : super(key: key);

  @override
  State<DisplayCalendar> createState() => _DisplayCalendarState();
}

class _DisplayCalendarState extends State<DisplayCalendar> {
  List<DateTime> dateList = <DateTime>[];
  DateTime currentMonthDate = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    setListDateTime(currentMonthDate);
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }
    super.initState();
  }

  void setListDateTime(DateTime monthDate) {
    dateList.clear();
    final DateTime newDate = DateTime(monthDate.year, monthDate.month, 0);
    int previousMothDay = 0;
    if (newDate.weekday < 7) {
      previousMothDay = newDate.weekday;
      for (int i = 1; i <= previousMothDay; i++) {
        dateList.add(newDate.subtract(Duration(days: previousMothDay - i)));
      }
    }
    for (int i = 0; i < (42 - previousMothDay); i++) {
      dateList.add(newDate.add(Duration(days: i + 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 4),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month, 0);
                    setListDateTime(currentMonthDate);
                  });
                },
                icon: widget.leftIcon ?? const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    DateFormat("MMMM yyyy").format(currentMonthDate),
                    style: TextStyle(fontSize: 18, color: widget.colorLabel ?? Theme.of(context).primaryColor, fontFamily: widget.fontFamily),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month + 2, 0);
                    setListDateTime(currentMonthDate);
                  });
                },
                icon: widget.rightIcon ?? const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
          child: Row(
            children: displayLabelDays(widget.fontFamily ?? ""),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8),
          child: Column(
            children: displayDays(),
          ),
        ),
      ],
    );
  }

  List<Widget> displayLabelDays(String fontFamily) {
    final List<Widget> listMonToSun = <Widget>[];
    for (int i = 0; i < 7; i++) {
      listMonToSun.add(
        Expanded(
          child: Center(
            child: Text(
              DateFormat('EEE').format(dateList[i]),
              style: TextStyle(fontSize: 14, fontFamily: fontFamily),
            ),
          ),
        ),
      );
    }
    return listMonToSun;
  }

  List<Widget> displayDays() {
    final List<Widget> daysInMonth = <Widget>[];
    int count = 0;
    for (int i = 0; i < dateList.length / 7; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < 7; i++) {
        final DateTime date = dateList[count];
        listUI.add(
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    child: Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.only(top: 2, bottom: 2, left: isStartDateRadius(date) ? 4 : 0, right: isEndDateRadius(date) ? 4 : 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: startDate != null && endDate != null
                                ? getStartAndEndDate(date) || getRange(date)
                                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                                    : Colors.transparent
                                : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: isStartDateRadius(date) ? const Radius.circular(24.0) : const Radius.circular(0.0),
                              topLeft: isStartDateRadius(date) ? const Radius.circular(24.0) : const Radius.circular(0.0),
                              topRight: isEndDateRadius(date) ? const Radius.circular(24.0) : const Radius.circular(0.0),
                              bottomRight: isEndDateRadius(date) ? const Radius.circular(24.0) : const Radius.circular(0.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                      onTap: () {
                        // remove condition for can select more 1 month
                        // if (currentMonthDate.month == date.month) {
                        if (widget.minimumDate != null && widget.maximumDate != null) {
                          final DateTime newminimumDate = DateTime(widget.minimumDate!.year, widget.minimumDate!.month, widget.minimumDate!.day - 1);
                          final DateTime newmaximumDate = DateTime(widget.maximumDate!.year, widget.maximumDate!.month, widget.maximumDate!.day + 1);
                          if (date.isAfter(newminimumDate) && date.isBefore(newmaximumDate)) {
                            onChangeDateClick(date);
                          }
                        } else if (widget.minimumDate != null) {
                          final DateTime newminimumDate = DateTime(widget.minimumDate!.year, widget.minimumDate!.month, widget.minimumDate!.day - 1);
                          if (date.isAfter(newminimumDate)) {
                            onChangeDateClick(date);
                          }
                        } else if (widget.maximumDate != null) {
                          final DateTime newmaximumDate = DateTime(widget.maximumDate!.year, widget.maximumDate!.month, widget.maximumDate!.day + 1);
                          if (date.isBefore(newmaximumDate)) {
                            onChangeDateClick(date);
                          }
                        } else {
                          onChangeDateClick(date);
                        }
                        // }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: getStartAndEndDate(date) ? Theme.of(context).primaryColor : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${date.day}',
                              style: TextStyle(
                                  color: getStartAndEndDate(date)
                                      ? Colors.white
                                      : currentMonthDate.month == date.month
                                          ? widget.colorLabel
                                          : Colors.grey.withOpacity(0.6),
                                  fontSize: 13,
                                  fontFamily: widget.fontFamily,
                                  fontWeight: getStartAndEndDate(date) ? FontWeight.bold : FontWeight.normal),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 9,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                          color: DateTime.now().day == date.day && DateTime.now().month == date.month && DateTime.now().year == date.year
                              ? getRange(date)
                                  ? Colors.white
                                  : Theme.of(context).primaryColor
                              : Colors.transparent,
                          shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        count += 1;
      }
      daysInMonth.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return daysInMonth;
  }

  bool getRange(DateTime date) {
    if (startDate != null && endDate != null) {
      if (date.isAfter(startDate!) && date.isBefore(endDate!)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool getStartAndEndDate(DateTime date) {
    if (startDate != null && startDate!.day == date.day && startDate!.month == date.month && startDate!.year == date.year) {
      return true;
    } else if (endDate != null && endDate!.day == date.day && endDate!.month == date.month && endDate!.year == date.year) {
      return true;
    } else {
      return false;
    }
  }

  bool isStartDateRadius(DateTime date) {
    if (startDate != null && startDate!.day == date.day && startDate!.month == date.month) {
      return true;
    } else if (date.weekday == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isEndDateRadius(DateTime date) {
    if (endDate != null && endDate!.day == date.day && endDate!.month == date.month) {
      return true;
    } else if (date.weekday == 7) {
      return true;
    } else {
      return false;
    }
  }

  void onChangeDateClick(DateTime date) {
    if (startDate == null) {
      startDate = date;
    } else if (startDate != date && endDate == null) {
      endDate = date;
    } else if (startDate!.day == date.day && startDate!.month == date.month) {
      startDate = null;
    } else if (endDate!.day == date.day && endDate!.month == date.month) {
      endDate = null;
    }
    if (startDate == null && endDate != null) {
      startDate = endDate;
      endDate = null;
    }
    if (startDate != null && endDate != null) {
      endDate = date;
      if (!endDate!.isAfter(startDate!)) {
        final DateTime d = startDate!;
        startDate = endDate;
        endDate = d;
      }
      if (date.isBefore(startDate!)) {
        startDate = date;
      }
      if (date.isAfter(endDate!)) {
        endDate = date;
      }
    }

    /// Selected one day
    if (endDate == null) {
      startDate = startDate;
      endDate = startDate;
    }

    setState(() {
      try {
        widget.startEndDateChange!(startDate!, endDate!);
      } catch (_) {}
    });
  }
}
