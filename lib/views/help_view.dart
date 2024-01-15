import 'package:flutter/material.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (screenWidth < 600) {
              return buildColumn();
            } else {
              return buildRow();
            }
          },
        ),
      ),
    );
  }

  Widget buildColumn() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/logo.jpg'),
          const SizedBox(height: 16.0),
          buildRichText(),
        ],
      ),
    );
  }

  Widget buildRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Image.asset('assets/images/logo.jpg'),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          flex: 2,
          child: buildRichText(),
        ),
      ],
    );
  }

  Widget buildRichText() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 18,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'ABOUT\n',
          ),
          TextSpan(
            text:
                'LaserSlides is a very simple, dirty and quick OSC (Open Sound Control) application which lets you modify OSC messages on your phone/tablet, ready to be shown for your laser presentations. '
                'This Android application controls the BEYOND laser software by Pangolin. (or any other OSC controlled software or hardware)\n\n'
                '(C) Pangolin Laser Systems, Inc. (Pangolin.com)\n\n'
                'OSC is a protocol for networking sound synthesizers, computers and other media devices usually for show control or musical performance.\n\n'
                'HELP\n\n'
                'On the BEYOND application, we must go to OSC settings and look for the ip shown. Once we know the ip, we must go to the “network” button on the LaserSlides app and put the ip that we have seen at BEYOND.\n\n'
                'On the label, we have to put the name we want to see at the button. '
                'On the button pressed field, we are going to put the BEYOND PATH where the image we want to display is stored. '
                'First and foremost, we must know how BEYOND PATH works, the first cell is the 0 0, and the first row goes from 0 0, to 0 9. The second row 0 10, to 0 19 and so on. '
                'Once we know this, the command we have to use is: beyond/general/startcue 0 0 (for the first cell)\n'
                'There are other default commands as blackout: beyond/master/blackout\n\n'
                'All the OSC commands references can be found at ',
          ),
          TextSpan(
            text: 'https://wiki.pangolin.com/beyond:osc_commands \n',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(
            text: 'LaserSlides is based on QuickOSC\n',
          ),
        ],
      ),
    );
  }
}
