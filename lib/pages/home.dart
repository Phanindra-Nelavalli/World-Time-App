import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data ={};
  
  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    String bgImage = data['isDay'] ? 'day.png' : 'night.png' ;
    Color bgColor = data['isDay'] ? Colors.blue : Colors.indigo ;
    print(data);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/$bgImage'),fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,160,0,0),
            child: Column(
              children: [
                TextButton.icon(
                  style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () async{
                    dynamic result  = await Navigator.pushNamed(context, '/location');
                    if(result!=null){
                      setState(() {
                        data = {
                          'time':result['time'],
                          'isDay':result['isDay'],
                          'flag':result['flag'],
                          'location':result['location']
                        };
                      });
                    }
                  },
                  icon: Icon(Icons.edit_location),
                  label: Text("Edit Location"),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(backgroundImage: AssetImage('assets/${data['flag']}'),),
                    SizedBox(width: 16,),
                    Text("${data['location']}",style: TextStyle(fontSize: 38.0,color: Colors.white),),
                  ],
                ),
                SizedBox(height: 20),
                Text("${data['time']}",style: TextStyle(fontSize: 56.0,color: Colors.white),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
