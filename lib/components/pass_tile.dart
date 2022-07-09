import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/pass_item.dart';



class PassTile extends StatefulWidget {
  final PassItem item;
  PassTile({Key? key,required this.item,})  : super(key: key);

  @override
  State<PassTile> createState() => _PassTileState();
}

class _PassTileState extends State<PassTile> {

  @override
  void initState() {
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: 100,
      
      child: Container(
        color: Color.fromARGB(255, 241, 235, 214),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 5.0,
                  color: Colors.amber,
                ),
                const SizedBox(width: 16.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.name,
                      style: GoogleFonts.lato(
                          fontSize: 21.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4.0),
                    buildDate(),
                    
                  ],
                ),
              ],
            ),
            buildIcon()
             
          ],
        ),
      ),
    );
  }

  Widget buildDate() {
    final dateFormatter = DateFormat('MMMM dd h:mm a');
    final dateString = dateFormatter.format(widget.item.date);
    return Text(
      dateString,
    );
  }

  Widget buildIcon() {
    return widget.item.isComplete ? Icon(Icons.cloud_done) : Icon(Icons.cloud_sync_outlined);
  }
}
