moon ruler picker ui.

## Description
this package provide you with good ruler picker ui.

![](https://velog.velcdn.com/images/icecrao2/post/ae8d53d6-1bb0-4b3e-8e93-27e797192f9d/image.gif)

## Usage
must use with SizedBox!

``` 
    callback 
        -> data change call back method
        -> call back parameter type is double type
    height 
        -> widget's height
    borderWidth
        -> ruler graduation border
```

``` dart
    SizedBox(
      width: 300,
      height: 100,
      child: RulerPicker(
          callback: (data) {
            setState(() {
              _data = data;
            });
          },
          selectedNumber: _data,
          height: 50,
          borderWidth: 2,
          pickedColor: const Color(0XFF0180BE),
          color: const Color(0XFF0180BE).withOpacity(0.3)
      ),
    )
```