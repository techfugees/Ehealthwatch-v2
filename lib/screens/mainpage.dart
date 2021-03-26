import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfugeesapp/components/components.dart';
import 'package:techfugeesapp/data/data.dart';
import 'package:techfugeesapp/theme/theme.dart';

class MainPageWidget extends StatefulWidget {
  final String phone;

  const MainPageWidget({Key key, this.phone}) : super(key: key);

  @override
  _MainPageWidgetState createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'TechFugees',
          style: GoogleFonts.getFont('Raleway',
              fontWeight: FontWeight.bold,
              fontSize: fontsize1,
              color: maincolor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.keyboard_control,
              color: Color(0xFF263238),
              size: 20,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1615961766458-6950a05bba08?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '199',
                          style: GoogleFonts.getFont(
                            'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                          child: Text(
                            'Home Visits',
                            style: GoogleFonts.getFont(
                              'Raleway',
                              color: maincolor,
                              fontSize: fontsize,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '26',
                          style: GoogleFonts.getFont(
                            'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                          child: Text(
                            'Reffarals',
                            style: GoogleFonts.getFont(
                              'Raleway',
                              color: maincolor,
                              fontSize: fontsize,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '15',
                          style: GoogleFonts.getFont(
                            'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                          child: Text(
                            'Emergency Cases',
                            style: GoogleFonts.getFont(
                              'Raleway',
                              color: maincolor,
                              fontSize: fontsize,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20,),

            
                GridView.count(
                  crossAxisCount: 2,
                  primary: false,
                  shrinkWrap: true,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: List.generate(
                    services.length,
                    (index) => ServiceComponent(
                      servicemodel: services[index],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
