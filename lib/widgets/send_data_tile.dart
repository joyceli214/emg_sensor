import 'package:emg_sensor/globals.dart';
import 'package:emg_sensor/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' hide State;

class SendDataTile extends StatefulWidget {
  final Future<void> Function() onSendData;
  const SendDataTile({super.key, required this.onSendData});

  @override
  State<SendDataTile> createState() => _SendDataTileState();
}

class _SendDataTileState extends State<SendDataTile> {
  static const _mongoUri = String.fromEnvironment('MONGO_URI');

  Future<Db> connectDb() async {
    if (_mongoUri.isEmpty) {
      throw StateError(
          'Missing MONGO_URI. Pass it with --dart-define=MONGO_URI=...');
    }
    var db = await Db.create(_mongoUri);
    await db.open();
    return db;
  }

  Future onSendDataPressed() async {
    try {
      var db = await connectDb();
      await db.collection('test').insertOne({
        'deviceId': Globals.deviceId,
        'startTime': Globals.startTime.toString(),
        'endTime': DateTime.now().toString(),
      });
      await widget.onSendData();
      Snackbar.show(ABC.c, "Save Data Success", success: true);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Send Data Error:", e),
          success: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onSendDataPressed,
        child: const Text('End Session and Save Data'));
  }
}
