import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presentation/extensions/theme_data_extension.dart';
import 'package:presentation/constants/asset_path.dart' as asset;

class FloatingBarcodeButton extends StatelessWidget {
  FloatingBarcodeButton({super.key});

  final imagePicker = ImagePicker();
  final barcodeScanner =
      BarcodeScanner(formats: [BarcodeFormat.ean13, BarcodeFormat.ean8]);

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
    Fluttertoast.showToast(msg: "바코드를 찍어주세요.");
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;

    final inputImage = InputImage.fromFilePath(pickedFile.path);
    final barcode = (await barcodeScanner.processImage(inputImage)).firstOrNull;
    if (barcode == null) {
      Fluttertoast.showToast(msg: "바코드 인식에 실패했습니다.");
      return;
    }

    Fluttertoast.showToast(msg: "${barcode.rawValue}");
  }
}
