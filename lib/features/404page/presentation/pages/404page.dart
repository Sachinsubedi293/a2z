import 'package:a2zjewelry/router/app_router.dart';
import 'package:flutter/material.dart';
class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Opps!!!\nPage not found. Please try again.',style: TextStyle(
          color: Colors.red,
          fontSize: 24.0,
        ),),
        SizedBox(height: 20,),
        ElevatedButton(onPressed: (){NavigationService.goLogin();}, child: Text('Go to initial Page'))
          ],
        )
      ),
    );
  }
}