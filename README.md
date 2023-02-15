# Pickup datetime kh library

Pickup datetime kh is package let's you add pickup or choose datetime and custom
Pickup datetime kh is opensource library developed by  <a href="https://kimsoer.site/">Voern Kimsoer</a>

## Features

- Choose or pickup datetime
- Custom UI
- Support for customizing
    - Header
    - Color label
    - Background color button

## Installation

1. Add the latest version of package to your pubspec.yaml (and run`dart pub get`):
```yaml
dependencies:
  pickup_datetime_kh: ^0.0.1
```
2. Import the package and use it in your Flutter App.
```dart
import 'package:pickup_datetime_kh/pickup_datetime_kh.dart';
```

##Customization
The Flutter Custom Datetime Kh can customization include:
- `backgroundColor`: Background color
- `header`: The header to add widget.
- `initialStartDate`: Init datetime start
- `initialEndDate`: Init datetime end
- `onApplyClick`: A callback that will be called when the button is pressed.
- `onCancelClick` : Cancel you don't update datetime
- `btnLeftBackgroundColor` : Background color for left button
- `btnRightBackgroundColor` : Background color for right button
- `fontFamily` : Set font family
- `radius` : Set radius


## Example
For example, to create a button with white text, you could use the following code:

```dart
PickUpDateTimeKh(
          header: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                const Text('Select date range', style: TextStyle(fontSize: 14)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(startDate != null ? DateFormat('dd MMM yyyy').format(startDate!) : 'Start', style: const TextStyle(fontSize: 18)),
                    Container(
                      width: 12,
                      height: 2,
                      decoration: BoxDecoration(color: Theme.of(context).iconTheme.color),
                    ),
                    Text(endDate != null ? DateFormat('dd MMM yyyy').format(endDate!) : 'End', style: const TextStyle(fontSize: 18))
                  ],
                ),
              ],
            ),
          ),
          barrierDismissible: true,
          minimumDate: DateTime(2000),
          maximumDate: DateTime.now().add(const Duration(days: 30)),
          initialStartDate: startDate,
          initialEndDate: endDate,
          btnLeftBackgroundColor: Colors.grey,
          onApplyClick: (start, end) {
            setState(() {
              endDate = end;
              startDate = start;
            });
            print("Start Date $startDate");
            print("End Date $endDate");
          },
          btnRightBackgroundColor: Colors.blue,
          onCancelClick: () {
            setState(() {
              endDate = DateTime.now();
              startDate = DateTime.now();
            });
          },
        ),
```
<img src="https://github.com/chhumsovann/flutter_custom_datetime_kh/blob/main/sample_image/sample.jpg"  width="200"/>

