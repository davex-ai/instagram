import 'package:flutter/material.dart';
import 'package:instagram/providers/user.dart';
import 'package:instagram/utils/global_variables.dart';
import 'package:provider/provider.dart';

class ResponsiveLayoutScreen extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayoutScreen({super.key, required this.webScreenLayout, required this.mobileScreenLayout});

  @override
  State<ResponsiveLayoutScreen> createState() => _ResponsiveLayoutScreenState();
}

class _ResponsiveLayoutScreenState extends State<ResponsiveLayoutScreen> {

  @override
  void initState() {
    super.initState();
    addData();
  }
  
  void addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refereshUser();
  }
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >  webScreenSize){
        return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;
    },
    );
  }
}
