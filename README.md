# dynamic_nested_bottom_sheets

A highly customizable, easy-to-use Flutter package for building dynamic, nested modal bottom sheets with support for snapping, stackable sheets, custom backgrounds, adjustable barrier color and dismiss behavior, and much more!.

![demo](https://github.com/user-attachments/assets/367c1e21-ee58-4604-8040-a79a86643866)

## Features

📚 Stack/Nesting Support: Open multiple sheets on top of each other and manage them with a powerful controller.

🛠️ Custom Snap Points: Define multiple snap positions for each sheet.

🎨 Fully Customizable: Adjust sheet background color, border radius, drag handle, and barrier color/opacity.

🧩 isDismissible: Control whether sheets can be dismissed by tapping outside.

🎛️ Callbacks: Easily hook into onOpened, onClosed, and onSnap events.

💪 Draggable & Expandable: Supports DraggableScrollableSheet out of the box for rich interactions.

🚀 Easy Integration: Plug-and-play with your existing Flutter project.

## Getting started

To use this package, add dynamic_nested_bottom_sheets as a dependency in your pubspec.yaml file.

## Usage

Minimal example:

```dart

DynamicBottomSheet.show(
  context: context,
  builder: (context) => YourCustomContent(),
  snapPoints: [0.3, 0.6, 1.0],
  initialSnap: 0.6,
  expand: true,
  barrierColor: Colors.black.withOpacity(0.5),
  backgroundColor: Colors.white,
  isDismissible: true,
);

```



