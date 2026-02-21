import 'package:flutter/material.dart';

class DateRangeSelector extends StatefulWidget {
  final Function(DateTimeRange newRange) assignNewDateRange;

  const DateRangeSelector({super.key, required this.assignNewDateRange});

  @override
  State<DateRangeSelector> createState() => _DateRangeSelectorState();
}

class _DateRangeSelectorState extends State<DateRangeSelector> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime(2027, 1, 1),
  );
  @override
  Widget build(BuildContext context) {
    final startDate = dateRange.start;
    final endDate = dateRange.end;
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text('From'), Text('TO')],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: pickDateRange,
                    child: Text(
                      '${startDate.year}/${startDate.month}/${startDate.day}',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: pickDateRange,
                    child: Text(
                      '${endDate.year}/${endDate.month}/${endDate.day}',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateTimeRange = await showDateRangePicker(
      initialDateRange: dateRange,
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2027, 01, 01),
    );
    if (newDateTimeRange == null) return;
    setState(() {
      dateRange = newDateTimeRange;
      widget.assignNewDateRange(newDateTimeRange);
    });
  }
}
