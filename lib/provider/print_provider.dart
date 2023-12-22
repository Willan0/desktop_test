import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:desktop_test/main.dart';
import 'package:desktop_test/utils/extension.dart';

class PrintProvider extends ChangeNotifier {
  bool _isDispose = false;
  bool _isConnected = false;
  bool get isConnected => _isConnected;
  BluetoothDevice? _bluetoothDevice;
  BluetoothPrint get bluetoothPrint => _bluetoothPrint;

  BluetoothDevice? get bluetoothDevice => _bluetoothDevice;

  set connect(BluetoothDevice value) {
    _bluetoothDevice = value;
    if (_bluetoothDevice != null) _isConnected = true;
    notifyListeners();
  }

  Future<void> disconnect() async {
    await _bluetoothPrint.disconnect();
    _isConnected = await _bluetoothPrint.isConnected ?? false;
    notifyListeners();
  }

  final BluetoothPrint _bluetoothPrint = BluetoothPrint.instance;

  Future<void> searchDevices() async {
    final bluetoothState = await _bluetoothPrint.isOn;
    if (bluetoothState) {
      _bluetoothPrint.startScan(timeout: const Duration(seconds: 4));
      _bluetoothPrint.state.listen((state) {
        switch (state) {
          case BluetoothPrint.CONNECTED:
            _isConnected = true;
            break;
          case BluetoothPrint.DISCONNECTED:
            _isConnected = false;
            break;
          default:
            break;
        }
      });
      bool isConnect = await _bluetoothPrint.isConnected ?? false;
      if (isConnect) {
        _isConnected = isConnect;
      }
    } else {
      BuildContext? context = MyApp.navigatorKey.currentContext;
      if (context == null) return;
      // ignore: use_build_context_synchronously
      context.showSimpleWarningDialog(context, "Please open bluetooth");
    }
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _bluetoothPrint.disconnect();
    _isDispose = true;
    super.dispose();
  }
}
