import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

/// [asiaTime] Map stores the arguments passed to this page
/// [dayTimeImg] URL of the background image based on if it is day or night

class _HomeState extends State<Home> {

  Map asiaTime = {};
  late String dayTimeImg;

  @override
  Widget build(BuildContext context) {

    /// Getting the arguments passed to the page during navigation
    asiaTime = ModalRoute.of(context)?.settings.arguments as Map;

    /// Setting the background image URL
    dayTimeImg = asiaTime['isDay'] ? 'day.jpg' : 'night.jpg';


    return Scaffold(
      body:
        Container(

          /// Setting the background image to the container
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$dayTimeImg'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 130.0, 0.0, 0.0),

            /// Column to display all the widgets
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                /// Button for editing location
                TextButton.icon(
                    onPressed: () {

                      /// On press we go to chooseLocation page
                      Navigator.pushNamed(context, '/location');
                    },
                    icon: Icon(
                        Icons.location_on,
                        color: Colors.grey[50],
                    ),
                    label: Text(
                        "Edit your location",
                        style: TextStyle(
                          color: Colors.grey[50],
                        ),
                    ),
                ),
                const SizedBox(height: 20.0),

                /// Text displayes the selected location
                Center(
                  child: Text(
                    asiaTime['location'],
                    style: const TextStyle(
                      fontSize: 25.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height:20.0,),

                /// Text displays the local time
                Center(
                  child: Text(
                    asiaTime['time'],
                    style: const TextStyle(
                      fontSize: 65.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
