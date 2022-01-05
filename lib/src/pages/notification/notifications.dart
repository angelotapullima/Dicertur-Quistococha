import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('jwb frwfgb notificationModel'),
      ),
    );
  }
}

class NotificationModel {
  String ? tipo;
  String ? contenido;
  String ? id;

  NotificationModel({
    this.tipo,
    this.contenido,
    this.id,
  });
}
