import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = 'Loading....';

  void setUpWorldTime() async {
    WorldTime instance =
        WorldTime(url: 'Asia/Kolkata', location: 'India', flag: 'india.png');
    await instance.getData();
    Navigator.pushNamed(context, '/home',arguments: {
      'location' : instance.location,
      'flag' : instance.flag,
      'time' : instance.time,
      'isDay': instance.isDayTime
    });
  }

  @override
  void initState() {
    super.initState();
    setUpWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDualRing(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}