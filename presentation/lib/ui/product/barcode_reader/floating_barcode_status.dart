sealed class FloatingBarcodeStatus {}

class FloatingBarcodeStatusOnDismissLoading extends FloatingBarcodeStatus {}

class FloatingBarcodeStatusShowFailedDialog extends FloatingBarcodeStatus {
  final String message;
  FloatingBarcodeStatusShowFailedDialog(this.message);
}

class FloatingBarcodeStatusShowRentDialog extends FloatingBarcodeStatus {
  final String message;
  FloatingBarcodeStatusShowRentDialog(this.message);
}

class FloatingBarcodeStatusShowReturnDialog extends FloatingBarcodeStatus {
  final String message;
  FloatingBarcodeStatusShowReturnDialog(this.message);
}

class FloatingBarcodeStatusOnSuccessReturnDialog
    extends FloatingBarcodeStatus {}

class FloatingBarcodeStatusOnSuccessRentDialog extends FloatingBarcodeStatus {}
