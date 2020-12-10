import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:stacked/stacked.dart';
import 'package:trashsmart/Screens/schedule/schedule_viewmodel.dart';
import 'package:trashsmart/Screens/schedule/theme/schedule_app_theme.dart';

class AddScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScheduleViewModel>.reactive(
      viewModelBuilder: () => ScheduleViewModel(),
      builder: (context, model, child) => Theme(
        data: ScheduleAppTheme.buildLightTheme(),
        child: Scaffold(
          body: Stack(children: <Widget>[
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: <Widget>[
                  getAppBarUI(context),
                  scheduleTypeUI(context, model),
                  daysScheduledUI(context, model),
                  paymentModeUI(context, model),
                  locationUI(context, model),
                  bagSizeUI(context, model)
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // Use this as the template
  // ScheduleListView()

  Widget scheduleTypeUI(BuildContext context, ScheduleViewModel model) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(8.0),
            ),
            new Padding(
              padding: new EdgeInsets.all(8.0),
            ),
            new Text(
              'Select Schedule Type',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ChoiceChip(
                  label: Text('One time '),
                  selected: true,
                  onSelected: model.handleScheduleTypeChange(1),
                ),
                ChoiceChip(
                  label: Text('Weekly'),
                  selected: false,
                ),
                ChoiceChip(
                  label: Text('Monthly'),
                  selected: false,
                ),
              ],
            ),
          ]),
    );
  }

  Widget daysScheduledUI(BuildContext context, ScheduleViewModel model) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(8.0),
            ),
            new Text(
              'Days Scheduled',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            new Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                FilterChip(
                  label: Text('Monday'),
                  selected: true,
                  onSelected: model.handleScheduleTypeChange(1),
                ),
                FilterChip(
                  label: Text('Tuesday'),
                  selected: false,
                  onSelected: model.handleScheduleTypeChange(1),
                ),
                FilterChip(
                  label: Text('Wednesday'),
                  selected: false,
                  onSelected: model.handleScheduleTypeChange(1),
                ),
                FilterChip(
                  label: Text('Thursday'),
                  selected: false,
                  onSelected: model.handleScheduleTypeChange(1),
                ),
                FilterChip(
                  label: Text('Friday'),
                  selected: false,
                  onSelected: model.handleScheduleTypeChange(1),
                ),
                FilterChip(
                  label: Text('Saturday'),
                  selected: false,
                  onSelected: model.handleScheduleTypeChange(1),
                ),
                FilterChip(
                  label: Text('Sunday'),
                  selected: false,
                  onSelected: model.handleScheduleTypeChange(1),
                ),
              ],
            ),
          ]),
    );
  }

  Widget paymentModeUI(BuildContext context, ScheduleViewModel model) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(8.0),
            ),
            new Text(
              'Payment Type',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            new Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                ChoiceChip(
                  label: Text('Mobile Money'),
                  selected: true,
                  onSelected: model.handleScheduleTypeChange(1),
                ),
                ChoiceChip(
                  label: Text('In Person'),
                  selected: false,
                ),
              ],
            ),
          ]),
    );
  }

  Widget locationUI(BuildContext context, ScheduleViewModel model) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(8.0),
            ),
            new Text(
              'Pickup Location',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            new Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                ChoiceChip(
                    label: Text('Select Location'),
                    selected: true,
                    onSelected: (bool selected) {
                      showBottomSheetModal(context);
                    }),
                ActionChip(
                  avatar: Icon(Icons.location_on),
                  label: Text('Use Current Location'),
                  onPressed: () {},
                ),
              ],
            ),
          ]),
    );
  }

  Widget getAppBarUI(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ScheduleAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Add Schedule',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bagSizeUI(BuildContext context, ScheduleViewModel model) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                new Text(
                  'Bag Sizes',
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                ChoiceChip(
                  label: Text('Add Bag'),
                  selected: false,
                ),
              ],
            ),
            new Padding(
              padding: new EdgeInsets.all(8.0),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ChoiceChip(
                  label: Text('One time '),
                  selected: true,
                  onSelected: model.handleScheduleTypeChange(1),
                ),
                ChoiceChip(
                  label: Text('Weekly'),
                  selected: false,
                ),
                ChoiceChip(
                  label: Text('Monthly'),
                  selected: false,
                ),
              ],
            ),
          ]),
    );
  }

  showBottomSheetModal(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      expand: true,
      isDismissible: true,
      builder: (context) => Container(
        child: Text("Hello From Bottom Sheet"),
      ),
    );
  }
}
