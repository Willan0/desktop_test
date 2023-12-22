import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/provider/print_provider.dart';
import 'package:desktop_test/utils/extension.dart';
import 'package:desktop_test/widgets/easy_app_bar.dart';
import 'package:desktop_test/widgets/easy_text.dart';
import 'package:provider/provider.dart';

import '../../constant/dimen.dart';

class PrintPage extends StatefulWidget {
  const PrintPage({
    super.key,
  });
  @override
  State<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  bool _isInitialized = false;
  late PrintProvider _printProvider;

  @override
  void didChangeDependencies() async {
    _printProvider = context.watch<PrintProvider>();
    if (!_isInitialized) {
      await _printProvider.searchDevices();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _isInitialized = true;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: PreferredSize(
        preferredSize: Size(getWidth(context), kToolbarHeight),
        child: EasyAppBar(
          text: 'Print Voucher',
          leading: true,
          onPressed: () async {
            context.popScreen();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kAs20x),
        child: Column(
          children: [
            SearchDeviceView(printProvider: _printProvider),
            const Divider(
              thickness: 2,
            ),
            _printProvider.isConnected
                ? const SizedBox()
                : AvailableDeviceView(printProvider: _printProvider)
          ],
        ),
      ),
    );
  }
}

class AvailableDeviceView extends StatelessWidget {
  const AvailableDeviceView({
    super.key,
    required PrintProvider printProvider,
  }) : _printProvider = printProvider;

  final PrintProvider _printProvider;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _printProvider.bluetoothPrint.scanResults,
        builder: (context, snapshot) {
          final devices = snapshot.data ?? [];
          if (devices.isEmpty) {
            return const Center(
              child: EasyText(text: "no devices are found"),
            );
          }
          return SizedBox(
            height: kAs350x,
            child: Column(
              children: [
                const EasyText(text: "Available devices"),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: devices.length,
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          _printProvider.connect = devices[index];
                          _printProvider.bluetoothPrint.connect(devices[index]);
                        },
                        child: ListTile(
                          title: EasyText(text: "${devices[index].name}"),
                          leading: const Icon(Icons.print),
                        )),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class SearchDeviceView extends StatelessWidget {
  const SearchDeviceView({
    super.key,
    required PrintProvider printProvider,
  }) : _printProvider = printProvider;

  final PrintProvider _printProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kAs30x,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _printProvider.isConnected
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EasyText(text: _printProvider.bluetoothDevice?.name ?? ""),
                    IconButton(
                        onPressed: () async {
                          await _printProvider.disconnect();
                        },
                        icon: const Icon(Icons.cancel_rounded))
                  ],
                )
              : const EasyText(text: 'No device is connected'),
          _printProvider.isConnected
              ? const SizedBox()
              : StreamBuilder(
                  stream: _printProvider.bluetoothPrint.isScanning,
                  builder: (context, snapshot) {
                    final isScan = snapshot.data ?? false;
                    if (isScan) {
                      return const Center(
                        child: SizedBox(
                          width: kAs15x,
                          height: kAs15x,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return TextButton(
                        onPressed: () {
                          _printProvider.searchDevices();
                        },
                        child: const EasyText(text: "Refresh"));
                  },
                )
        ],
      ),
    );
  }
}
