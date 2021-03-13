import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Services/firebase_services/groupServices.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class DisplayGroups extends StatefulWidget {
  @override
  _DisplayGroupsState createState() => _DisplayGroupsState();
}

class _DisplayGroupsState extends State<DisplayGroups> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: StreamBuilder(
        stream: groupServices().getPublicGroups(context),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, index) {
              DocumentSnapshot groups = snapshot.data.docs[index];
              return groupsCard(groups: groups);
            },
          );
        },
      ),
    );
  }
}

// ignore: camel_case_types
class groupsCard extends StatelessWidget {
  const groupsCard({
    Key key,
    @required this.groups,
  }) : super(key: key);

  final DocumentSnapshot groups;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
        left: 8,
        right: 8,
      ),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              groups['groupBanner'],
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: new LinearGradient(
                  end: const Alignment(0.0, -1),
                  begin: const Alignment(0.0, 0.6),
                  colors: <Color>[
                    Colors.black87.withOpacity(0.8),
                    Colors.black54,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 55,
              left: 13,
              child: Text(
                groups["groupName"],
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: CachedNetworkImageProvider(
                  groups["groupImage"],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 10,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xFF7934ff),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FeatherIcons.clock,
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        timeAgo.format(groups['TimeStamp'].toDate()),
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
