import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:permission_handler/permission_handler.dart';

class DemoGpsScreen extends StatefulWidget {
  @override
  _MonitorScreenState createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<DemoGpsScreen> {
  bool _accelAvailable = false;
  bool _gyroAvailable = false;
  List<double> _accelData = List.filled(3, 0.0);
  List<double> _gyroData = List.filled(3, 0.0);
  StreamSubscription? _accelSubscription;
  StreamSubscription? _gyroSubscription;

  @override
  void initState() {
    super.initState();
    _checkAccelerometerStatus();
    _checkGyroscopeStatus();
  }

  @override
  void dispose() {
    _stopAccelerometer();
    _stopGyroscope();
    super.dispose();
  }

  void _checkAccelerometerStatus() async {
    await SensorManager()
        .isSensorAvailable(Sensors.ACCELEROMETER)
        .then((result) {
      setState(() {
        _accelAvailable = result;
      });
    });
  }

  Future<void> _startAccelerometer() async {
    if (_accelSubscription != null) return;
    if (_accelAvailable) {
      final stream = await SensorManager().sensorUpdates(
        sensorId: Sensors.ACCELEROMETER,
        interval: Sensors.SENSOR_DELAY_FASTEST,
      );
      _accelSubscription = stream.listen((sensorEvent) {
        setState(() {
          _accelData = sensorEvent.data;
        });
      });
    }
  }

  void _stopAccelerometer() {
    if (_accelSubscription == null) return;
    _accelSubscription?.cancel();
    _accelSubscription = null;
  }

  void _checkGyroscopeStatus() async {
    await SensorManager().isSensorAvailable(Sensors.GYROSCOPE).then((result) {
      setState(() {
        _gyroAvailable = result;
      });
    });
  }

  Future<void> _startGyroscope() async {
    if (_gyroSubscription != null) return;
    if (_gyroAvailable) {
      final stream =
          await SensorManager().sensorUpdates(sensorId: Sensors.GYROSCOPE);
      _gyroSubscription = stream.listen((sensorEvent) {
        setState(() {
          _gyroData = sensorEvent.data;
        });
      });
    }
  }

  void _stopGyroscope() {
    if (_gyroSubscription == null) return;
    _gyroSubscription?.cancel();
    _gyroSubscription = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Sensors '),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: AlignmentDirectional.topCenter,
        child: Column(
          children: <Widget>[
            const Text(
              "Accelerometer Test",
              textAlign: TextAlign.center,
            ),
            Text(
              "Accelerometer Enabled: $_accelAvailable",
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 16.0)),
            Text(
              "[0](X) = ${_accelData[0]}",
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 16.0)),
            Text(
              "[1](Y) = ${_accelData[1]}",
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 16.0)),
            Text(
              "[2](Z) = ${_accelData[2]}",
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 16.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  child: const Text("Start"),
                  color: Colors.green,
                  onPressed:
                      _accelAvailable ? () => _startAccelerometer() : null,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                MaterialButton(
                  child: const Text("Stop"),
                  color: Colors.red,
                  onPressed:
                      _accelAvailable ? () => _stopAccelerometer() : null,
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 16.0)),
            const Text(
              "Gyroscope Test",
              textAlign: TextAlign.center,
            ),
            Text(
              "Gyroscope Enabled: $_gyroAvailable",
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 16.0)),
            Text(
              "[0](X) = ${_gyroData[0]}",
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 16.0)),
            Text(
              "[1](Y) = ${_gyroData[1]}",
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 16.0)),
            Text(
              "[2](Z) = ${_gyroData[2]}",
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 16.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  child: const Text("Start"),
                  color: Colors.green,
                  onPressed: _gyroAvailable ? () => _startGyroscope() : null,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                MaterialButton(
                  child: const Text("Stop"),
                  color: Colors.red,
                  onPressed: _gyroAvailable ? () => _stopGyroscope() : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
