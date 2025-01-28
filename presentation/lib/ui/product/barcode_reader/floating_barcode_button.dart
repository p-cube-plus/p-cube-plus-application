import 'dart:io';

import 'package:domain/common/extensions/future_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presentation/beacon/beacon_scanner.dart';
import 'package:presentation/common/viewmodel.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/constants/asset_path.dart' as asset;
import 'package:presentation/ui/product/barcode_reader/floating_barcode_button_view_model.dart';
import 'package:presentation/ui/product/barcode_reader/floating_barcode_status.dart';
import 'package:presentation/widgets/default_alert.dart';
import 'package:presentation/widgets/default_progress_indicator_builder.dart';
import 'package:provider/provider.dart';

class FloatingBarcodeButton extends StatelessWidget {
  const FloatingBarcodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FloatingBarcodeButtonViewModel(),
      child: _FloatingBarcodeButton(),
    );
  }
}

class _FloatingBarcodeButton extends StatefulWidget {
  const _FloatingBarcodeButton();

  @override
  State<_FloatingBarcodeButton> createState() => _FloatingBarcodeButtonState();
}

class _FloatingBarcodeButtonState extends State<_FloatingBarcodeButton>
    with ViewModel<FloatingBarcodeButtonViewModel> {
  late ImagePicker imagePicker;
  late BarcodeScanner barcodeScanner;
  late BeaconScanner beaconScanner;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    barcodeScanner = BarcodeScanner(formats: [
      BarcodeFormat.ean13,
      BarcodeFormat.ean8,
    ]);
    beaconScanner = BeaconScanner();
    Future.microtask(() => _setStateListener());
  }

  @override
  void dispose() {
    barcodeScanner.close();
    imageCache.clear();
    imageCache.clearLiveImages();
    super.dispose();
  }

  void _setStateListener() {
    read(context).eventStream.listen((event) {
      switch (event) {
        case FloatingBarcodeStatusOnDismissLoading():
          _dismissLoadingDialog();
        case FloatingBarcodeStatusShowFailedDialog():
          _showFailedDialog(event.message);
        case FloatingBarcodeStatusShowRentDialog():
          _showRentDialog(event.message);
        case FloatingBarcodeStatusShowReturnDialog():
          _showReturnDialog(event.message);
        case FloatingBarcodeStatusOnSuccessReturnDialog():
          _showSuccessReturnDialog();
        case FloatingBarcodeStatusOnSuccessRentDialog():
          _showSuccessRentDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => startBarcodeScan(),
      child: Container(
        width: 64,
        height: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.primary80.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          asset.scan,
          colorFilter: ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
          width: 36,
          height: 36,
        ),
      ),
    );
  }

  Future startBarcodeScan() async {
    Fluttertoast.showToast(
      msg: "대여 또는 반납할 바코드를 찍어주세요.",
      toastLength: Toast.LENGTH_LONG,
    );

    final pickedFile = await imagePicker
        .pickImage(
          source: ImageSource.camera,
          requestFullMetadata: false,
        )
        .getOrNull();
    if (pickedFile == null) return;

    _showLoadingDialog();

    final inputImage = InputImage.fromFilePath(pickedFile.path);
    final barcode = (await barcodeScanner.processImage(inputImage)).firstOrNull;
    final file = File(pickedFile.path);
    await file.delete().getOrNull();

    if (barcode == null) {
      Fluttertoast.showToast(msg: "바코드 인식에 실패했습니다.");
      _dismissLoadingDialog();
      return;
    }

    if (mounted) {
      read(context).fetchProductByBarcode(barcode.rawValue ?? "");
    }
  }

  void _showLoadingDialog() {
    DefaultProgressIndicatorBuilder().build(context);
  }

  void _dismissLoadingDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  void _showFailedDialog(String message) {
    DialogBuilder().build(
      context,
      DefaultAlert(
        title: "물품찾기에 실패했습니다!",
        messageType: MessageType.ok,
        description: message,
      ),
    );
  }

  void _showRentDialog(String message) async {
    var isOk = false;
    await DialogBuilder().build(
      context,
      DefaultAlert(
        title: "해당 물품을 대여하시겠습니까?",
        messageType: MessageType.okCancel,
        okString: "대여하기",
        description: message,
        onTapOk: () {
          isOk = true;
          read(context).rentProduct();
        },
      ),
    );

    if (isOk) {
      _showLoadingDialog();
    }
  }

  void _showReturnDialog(String message) async {
    var isOk = false;
    await DialogBuilder().build(
      context,
      DefaultAlert(
        title: "해당 물품을 반납하시겠습니까?",
        messageType: MessageType.okCancel,
        okString: "반납하기",
        description: message,
        onTapOk: () => isOk = true,
      ),
    );
    if (isOk) {
      _checkBeaconStatus();
    }
  }

  void _checkBeaconStatus() async {
    if (!(await beaconScanner.isBluetoothEnabled())) {
      _showRequestBluetoothDialog();
      return;
    }

    if (!beaconScanner.isBeaconDetected) {
      _showCanNotFoundBeaconDialog();
      return;
    }

    if (!mounted) return;
    _showLoadingDialog();
    read(context).returnProduct();
  }

  void _showRequestBluetoothDialog() async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return PopScope(
          canPop: false,
          child: DefaultAlert(
            title: "블루투스가 꺼져있습니다.",
            description: "블루투스를 켜주세요.",
            messageType: MessageType.ok,
          ),
        );
      },
    );

    final isBluetoothOn = await beaconScanner.isBluetoothEnabled();
    if (isBluetoothOn) {
      Fluttertoast.showToast(msg: "비콘 모니터링을 재시작합니다. 잠시 후 다시 시도해주세요.");
      BeaconScanner().startScanning().getOrNull();
    }
  }

  void _showCanNotFoundBeaconDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return DefaultAlert(
          title: "비콘을 찾을 수 없습니다.",
          description: "블루투스가 켜져있는지,\n또는 주변에 켜져있는 비콘이 있는지\n확인 후 다시 시도해주세요.",
          messageType: MessageType.ok,
          onTapOk: () {
            BeaconScanner().startScanning().getOrNull();
            Fluttertoast.showToast(msg: "비콘 모니터링을 재시작합니다.");
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _showSuccessReturnDialog() {
    _dismissLoadingDialog();
    showDialog(
      context: context,
      builder: (context) {
        return DefaultAlert(
          title: "반납 완료",
          description: "반납을 완료했습니다!",
          messageType: MessageType.ok,
        );
      },
    );
  }

  void _showSuccessRentDialog() {
    _dismissLoadingDialog();
    showDialog(
      context: context,
      builder: (context) {
        return DefaultAlert(
          title: "대여 완료",
          description: "대여를 완료했습니다!",
          messageType: MessageType.ok,
        );
      },
    );
  }
}
