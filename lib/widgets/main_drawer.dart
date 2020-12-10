import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget _createListItem(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: icon != null ? Icon(icon, size: 24) : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 60,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                alignment: Alignment.centerLeft,
                child: Text(
                  'TripPlanner',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )),
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              _createListItem('Home', Icons.home, () {}),
              _createListItem('Notifications', Icons.notifications, () {}),
              _createListItem('To complete', Icons.edit, () {}),
              _createListItem('Historic', Icons.collections, () {}),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              _createListItem('Account', Icons.person, () {}),
              _createListItem('Payment', Icons.payment, () {}),
              _createListItem('Settings', Icons.settings, () {}),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              _createListItem('Help & Comments', null, () {}),
              
            ],
          ),
        ),
      ),
    );
  }
}
