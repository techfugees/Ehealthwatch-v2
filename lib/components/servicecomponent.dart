import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfugeesapp/data/data.dart';
import 'package:techfugeesapp/models/models.dart';
import 'package:techfugeesapp/theme/theme.dart';

class ServiceComponent extends StatelessWidget {
  final ServicesModel servicemodel;

  const ServiceComponent({Key key, @required this.servicemodel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => servicemodel.onPress(context),
      child: Container(
        width: MediaQuery.of(context).size.width * .4,
        height: MediaQuery.of(context).size.width * .26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.00),
          image: DecorationImage(
            image: CachedNetworkImageProvider(servicemodel.imageurl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.00),
            color: maincolor.withOpacity(.4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 150,
                    child: Text(
                      "${servicemodel.name}",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.raleway(
                          fontSize: fontsize1,
                          textStyle: TextStyle(
                              color: backgroundcolor,
                              fontWeight: FontWeight.bold)),
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
