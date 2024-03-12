

## Description
this package provide you with good ruler picker!
Experience the Ruler Picker smoothly gliding through a swift swipe motion, coming to a natural halt!
Customize the movement of the Ruler Picker by setting acceleration and resistance to achieve your desired behavior.

![](https://velog.velcdn.com/images/icecrao2/post/ce3f18dd-724a-45f7-95a9-612ba081761c/image.gif)

## Getting started

```
flutter pub add moon_ruler_picker
```

## Usage

``` dart
    RulerPicker(
    	width: 300,			// widget's width
        height: 200,		// widget's height
        resistance: 1,		// drag resistance
        acceleration: 1,	// drag acceleration
        callback: (data) {	// data change callback
        	setState(() {
                  _data = data;
            });
        },
        selectedNumber: _data,	// first data
        borderWidth: 2,			// ruler Graduation's width
        pickedBarColor: const Color(0XFF0180BE),	// picked ruler's color
        barColor: const Color(0XFF0180BE).withOpacity(0.3)	// default ruler's color
    ),
```
