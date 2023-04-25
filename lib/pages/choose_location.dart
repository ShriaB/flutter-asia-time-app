import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  /// Takes the build context and the index of the list item
  void updateTime(context, index) async{

    /// Gets the asiaTime object from the index
    AsiaTime asiaTime = asiaLocations[index];

    /// API call
    await asiaTime.getTime();

    if(asiaTime.time != null){
      if(context.mounted){
        /// If the call was successful and time is not null
        /// Navigate to home page to display the current time for the selected location
        Navigator.pushReplacementNamed(context, '/home', arguments: {
          'location' : asiaTime.location,
          'flag' : asiaTime.flag,
          'time' : asiaTime.time,
          'isDay' : asiaTime.isDay
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Returns a Scaffold
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Choose your location"),
        backgroundColor: Colors.blue[900],
      ),
      /// Body contains the list of locations
      body: ListView.builder(
        itemCount: asiaLocations.length ,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/${asiaLocations[index].flag}"),
                ),
                title: Text(asiaLocations[index].location) ,
                onTap: () {
                  /// When a list item is tapped we call updateTime()
                  updateTime(context, index);
                },
              )
            ),
          );
        }
      ),
    );
  }
}
