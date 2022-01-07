import 'package:dicertur_quistococha/src/bloc/provider_bloc.dart';
import 'package:dicertur_quistococha/src/models/ticket_model.dart';
import 'package:dicertur_quistococha/src/pages/tabs/bloc_contador_qr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CobroTicket extends StatefulWidget {
  final String idTicket;
  const CobroTicket({Key? key, required this.idTicket}) : super(key: key);

  @override
  _CobroTicketState createState() => _CobroTicketState();
}

class _CobroTicketState extends State<CobroTicket> {
   

  @override
  Widget build(BuildContext context) {
    final ticketBloc = ProviderBloc.ticket(context);
    ticketBloc.getTicketsForID(widget.idTicket.toString());


    final  ContadorQrBloc ? provider = Provider.of<ContadorQrBloc>(context, listen: false);
    return WillPopScope(
      onWillPop:()async{
        provider!.changeValorQr(0);
        return false;
      },
      child: StreamBuilder(
        stream: ticketBloc.ticketIdStream,
        builder: (context, AsyncSnapshot<List<TicketModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              return Scaffold(appBar: AppBar(), body: Container());
            } else {
              return Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Text('No existen Tickets'),
                ),
              );
            }
          } else {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }
}
