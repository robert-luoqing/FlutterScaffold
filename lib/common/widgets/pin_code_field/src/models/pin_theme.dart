part of pin_code_fields;

class PinTheme {
  /// Colors of the input fields which have inputs. Default is [Colors.green]
  final Color activeColor;

  /// Color of the input field which is currently selected. Default is [Colors.blue]
  final Color selectedColor;

  /// Colors of the input fields which don't have inputs. Default is [Colors.red]
  final Color inactiveColor;

  /// Colors of the input fields if the [PinCodeTextField] is disabled. Default is [Colors.grey]
  final Color disabledColor;

  /// Colors of the input fields which have inputs. Default is [Colors.green]
  final Color activeFillColor;

  /// Color of the input field which is currently selected. Default is [Colors.blue]
  final Color selectedFillColor;

  /// Colors of the input fields which don't have inputs. Default is [Colors.red]
  final Color inactiveFillColor;

  /// Color of the input field when in error mode. Default is [Colors.redAccent]
  final Color errorBorderColor;

  /// textStyle of the input field when in error mode. Default is null
  final TextStyle? errorTextStyle;

  /// Border radius of each pin code field
  final BorderRadius borderRadius;

  /// [height] for the pin code field. default is [50.0]
  final double fieldHeight;

  /// [width] for the pin code field. default is [40.0]
  final double fieldWidth;

  /// Border width for the each input fields. Default is [2.0]
  final double borderWidth;

  /// this defines the shape of the input fields. Default is underlined
  final PinCodeFieldShape shape;

  /// this defines the padding of each enclosing container of an input field. Default is [0.0]
  final EdgeInsetsGeometry fieldOuterPadding;

  /// boxShadow of the input field which is currently selected. Default is null
  final List<BoxShadow>? selectedBoxShadow;

  /// textStyle of the input field which is currently selected. Default is null
  final TextStyle? selectedTextStyle;

  const PinTheme.defaults({
    this.borderRadius = BorderRadius.zero,
    this.fieldHeight = 50,
    this.fieldWidth = 40,
    this.borderWidth = 2,
    this.fieldOuterPadding = EdgeInsets.zero,
    this.shape = PinCodeFieldShape.underline,
    this.activeColor = Colors.green,
    this.selectedColor = Colors.blue,
    this.inactiveColor = Colors.red,
    this.disabledColor = Colors.grey,
    this.activeFillColor = Colors.green,
    this.selectedFillColor = Colors.blue,
    this.inactiveFillColor = Colors.red,
    this.errorBorderColor = Colors.redAccent,
    this.selectedBoxShadow,
    this.selectedTextStyle,
    this.errorTextStyle,
  });

  factory PinTheme(
      {Color? activeColor,
      Color? selectedColor,
      Color? inactiveColor,
      Color? disabledColor,
      Color? activeFillColor,
      Color? selectedFillColor,
      Color? inactiveFillColor,
      Color? errorBorderColor,
      BorderRadius? borderRadius,
      double? fieldHeight,
      double? fieldWidth,
      double? borderWidth,
      PinCodeFieldShape? shape,
      EdgeInsetsGeometry? fieldOuterPadding,
      List<BoxShadow>? selectedBoxShadow,
      TextStyle? selectedTextStyle,
      TextStyle? errorTextStyle}) {
    const defaultValues = PinTheme.defaults();
    return PinTheme.defaults(
      activeColor: activeColor ?? defaultValues.activeColor,
      activeFillColor: activeFillColor ?? defaultValues.activeFillColor,
      borderRadius: borderRadius ?? defaultValues.borderRadius,
      borderWidth: borderWidth ?? defaultValues.borderWidth,
      disabledColor: disabledColor ?? defaultValues.disabledColor,
      fieldHeight: fieldHeight ?? defaultValues.fieldHeight,
      fieldWidth: fieldWidth ?? defaultValues.fieldWidth,
      inactiveColor: inactiveColor ?? defaultValues.inactiveColor,
      inactiveFillColor: inactiveFillColor ?? defaultValues.inactiveFillColor,
      errorBorderColor: errorBorderColor ?? defaultValues.errorBorderColor,
      selectedColor: selectedColor ?? defaultValues.selectedColor,
      selectedFillColor: selectedFillColor ?? defaultValues.selectedFillColor,
      shape: shape ?? defaultValues.shape,
      fieldOuterPadding: fieldOuterPadding ?? defaultValues.fieldOuterPadding,
      selectedBoxShadow: selectedBoxShadow ?? defaultValues.selectedBoxShadow,
      selectedTextStyle: selectedTextStyle ?? defaultValues.selectedTextStyle,
      errorTextStyle: errorTextStyle ?? defaultValues.errorTextStyle,
    );
  }
}
