import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Models/user_db.dart';
import 'package:my_app/Pages/HomePage/MainHome/widgets/sliver_app_bar.dart';
import 'package:my_app/State/function_states.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          stops: [0.0, 1.0, 1.5],
          colors: [
            Color(0xFF08051a),
            Color(0xFF07041b),
            Color(0xFF081631),
          ],
        ),
      ),
      child: StreamProvider<UserModel>.value(
        initialData: Provider.of<FirebaseFunctions>(context).initialData(),
        value: Provider.of<FirebaseFunctions>(context).userInfo(),
        child: Consumer<UserModel>(
          builder: (context, UserModel document, child) {
            return CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  expandedHeight: 120,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: SliverBar(
                      name: document.name,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
