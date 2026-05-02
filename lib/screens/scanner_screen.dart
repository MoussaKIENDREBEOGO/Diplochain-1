import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _hasScanned = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_hasScanned) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final barcode = barcodes.first;
      if (barcode.rawValue != null) {
        setState(() {
          _hasScanned = true;
        });
        
        // Return the scanned value
        Navigator.pop(context, barcode.rawValue);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Scanner le QR Code', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: _controller,
              builder: (context, value, child) {
                switch (value.torchState) {
                  case TorchState.off:
                    return const Icon(LucideIcons.flashlightOff, color: Colors.white);
                  case TorchState.on:
                    return const Icon(LucideIcons.flashlight, color: Colors.yellow);
                  default:
                    return const Icon(LucideIcons.flashlightOff, color: Colors.white);
                }
              },
            ),
            onPressed: () => _controller.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(LucideIcons.refreshCw, color: Colors.white),
            onPressed: () => _controller.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
          ),
          
          // Custom Overlay for scanning area
          Container(
            decoration: ShapeDecoration(
              shape: QrScannerOverlayShape(
                borderColor: AppTheme.primaryGreen,
                borderRadius: 16,
                borderLength: 40,
                borderWidth: 8,
                cutOutSize: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
          ),
          
          const Positioned(
            bottom: 40,
            child: Text(
              'Pointez la caméra vers le QR Code',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                backgroundColor: Colors.black45,
              ),
            ),
          ),
        ],
      ),
      // MOCK SCAN BUTTON FOR TESTING IN EMULATORS
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Mocking a scan result to avoid emulator issues
          Navigator.pop(context, 'DC-2024-001');
        },
        backgroundColor: AppTheme.primaryDark,
        label: const Text('Test Auto-Scan'),
        icon: const Icon(LucideIcons.bug),
      ),
    );
  }
}

class QrScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final double overlayColor;
  final double borderRadius;
  final double borderLength;
  final double cutOutSize;

  const QrScannerOverlayShape({
    this.borderColor = Colors.red,
    this.borderWidth = 3.0,
    this.overlayColor = 150,
    this.borderRadius = 0,
    this.borderLength = 40,
    this.cutOutSize = 250,
  });

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10.0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return getLeftTopPath(rect)
      ..lineTo(rect.right, rect.bottom)
      ..lineTo(rect.left, rect.bottom)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final height = rect.height;
    final borderLengthCalculated = borderLength;

    final backgroundPaint = Paint()
      ..color = Colors.black.withAlpha(overlayColor.toInt())
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final cutOutRect = Rect.fromLTWH(
      rect.left + width / 2 - cutOutSize / 2,
      rect.top + height / 2 - cutOutSize / 2,
      cutOutSize,
      cutOutSize,
    );

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      Path()..addRect(rect),
      Path()..addRRect(RRect.fromRectAndRadius(cutOutRect, Radius.circular(borderRadius))),
    );

    canvas.drawPath(backgroundWithCutout, backgroundPaint);

    final path = Path()
      ..moveTo(cutOutRect.left, cutOutRect.top + borderLengthCalculated)
      ..lineTo(cutOutRect.left, cutOutRect.top + borderRadius)
      ..arcToPoint(Offset(cutOutRect.left + borderRadius, cutOutRect.top), radius: Radius.circular(borderRadius))
      ..lineTo(cutOutRect.left + borderLengthCalculated, cutOutRect.top)
      ..moveTo(cutOutRect.right - borderLengthCalculated, cutOutRect.top)
      ..lineTo(cutOutRect.right - borderRadius, cutOutRect.top)
      ..arcToPoint(Offset(cutOutRect.right, cutOutRect.top + borderRadius), radius: Radius.circular(borderRadius))
      ..lineTo(cutOutRect.right, cutOutRect.top + borderLengthCalculated)
      ..moveTo(cutOutRect.right, cutOutRect.bottom - borderLengthCalculated)
      ..lineTo(cutOutRect.right, cutOutRect.bottom - borderRadius)
      ..arcToPoint(Offset(cutOutRect.right - borderRadius, cutOutRect.bottom), radius: Radius.circular(borderRadius))
      ..lineTo(cutOutRect.right - borderLengthCalculated, cutOutRect.bottom)
      ..moveTo(cutOutRect.left + borderLengthCalculated, cutOutRect.bottom)
      ..lineTo(cutOutRect.left + borderRadius, cutOutRect.bottom)
      ..arcToPoint(Offset(cutOutRect.left, cutOutRect.bottom - borderRadius), radius: Radius.circular(borderRadius))
      ..lineTo(cutOutRect.left, cutOutRect.bottom - borderLengthCalculated);

    canvas.drawPath(path, borderPaint);
  }

  @override
  ShapeBorder scale(double t) {
    return QrScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth * t,
      overlayColor: overlayColor,
      borderRadius: borderRadius * t,
      borderLength: borderLength * t,
      cutOutSize: cutOutSize * t,
    );
  }
}
