

## Description
this package provide you with good ruler picker!

![](https://velog.velcdn.com/images/icecrao2/post/ae8d53d6-1bb0-4b3e-8e93-27e797192f9d/image.gif)

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
