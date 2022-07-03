import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

import '../components/pass_tile.dart';
import '../models/models.dart';

class PassItemScreen extends StatefulWidget {
  final Function(PassItem) onCreate;
  final Function(PassItem, int) onUpdate;
  final PassItem? originalItem;
  final int index;
  final bool isUpdating;

  static MaterialPage page({
    PassItem? item,
    int index = -1,
    required Function(PassItem) onCreate,
    required Function(PassItem, int) onUpdate,
  }) {
    return MaterialPage(
      name: FooderlichPages.passItemDetails,
      key: ValueKey(FooderlichPages.passItemDetails),
      child: PassItemScreen(
        originalItem: item,
        index: index,
        onCreate: onCreate,
        onUpdate: onUpdate,
      ),
    );
  }

  const PassItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
    this.index = -1,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  @override
  _PassItemScreenState createState() => _PassItemScreenState();
}

class _PassItemScreenState extends State<PassItemScreen> {

  final _nameController = TextEditingController();
  String _name = '';
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.amber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              final passItem = PassItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: _nameController.text,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              
              );

              if (widget.isUpdating) {
                widget.onUpdate(passItem, widget.index);
              } else {
                widget.onCreate(passItem);
                final db = Provider.of<PassManager>(context, listen: false).db;
                db.add(passItem);
              }
            },
          )
        ],
        elevation: 0.0,
        title: Text(
          'Selling a pass',
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildNameField(),
            const SizedBox(height: 10.0),
            buildDateField(context),
            const SizedBox(height: 16.0),
            buildTimeField(context),
            const SizedBox(height: 26.0),
            PassTile(
              item: PassItem(
                id: 'previewMode',
                name: _name,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer\'s Name',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: 'Enter the name of the buyer',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
          ),
        ),
      ],
    );
  }


  Widget buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                final currentDate = DateTime.now();
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );

                setState(() {
                  if (selectedDate != null) {
                    _dueDate = selectedDate;
                  }
                });
              },
            ),
          ],
        ),
        Text('${DateFormat('yyyy-MM-dd').format(_dueDate)}'),
      ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time of Day',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                setState(() {
                  if (timeOfDay != null) {
                    _timeOfDay = timeOfDay;
                  }
                });
              },
            ),
          ],
        ),
        Text('${_timeOfDay.format(context)}'),
      ],
    );
  }

 

  @override
  void initState() {
    super.initState();
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _name = originalItem.name;
      _nameController.text = originalItem.name;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = date;
    }

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
