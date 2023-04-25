import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:world_time/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  late String status;
  String LOADING = "Loading";
  String SUCCESS = "Success";
  String ERROR = "Some Error Occurred";

  void setUpWorldTime() async{
    /// Creates the asiaTime object
    AsiaTime asiaTime = AsiaTime("Kolkata", "kolkata.png", "Asia/Kolkata");

    /// Set status to locading before starting API call
    setState(() {
      status = LOADING;
    });

    /// API call
    await asiaTime.getTime();


    if(asiaTime.time == null) {
      /// If time is null after the API call then some error has occurred
      setState(() {
        status = ERROR;
      });
    }else{
      /// If time is not null after the API call then request was successful
      /// So we set the status to success and navigate to homepage
      setState(() {
        status = SUCCESS;
      });
      if (context.mounted){
        Navigator.pushReplacementNamed(context, "/home", arguments: {
          'location' : asiaTime.location,
          'flag' : asiaTime.flag,
          'time' : asiaTime.time,
          'isDay' : asiaTime.isDay
        });
      }
    }
  }

  /// When the app is started we call the setUpWorldTime();
  @override
  void initState() {
    super.initState();
    setUpWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// When data is loading then Spinner is displayed
            if (status == LOADING) const SpinKitFoldingCube(
              color: Colors.cyan,
              size: 50.0,
            ),
            /// If request was unsuccessful then Error message is displayed
            if (status == ERROR)  Center(child: Text(ERROR)),
          ],
        ),
    );
  }
}
