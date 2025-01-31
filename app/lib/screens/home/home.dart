import 'package:app/theme/typography_styles.dart';
import 'package:app/wigets/plant_item.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 200,
          child: Row(
            children: [
              Image.asset("assets/logo/icon.png", width: 20, height: 20,),
              const SizedBox(width: 10,),
              Text("Planty", style: TypographyStyles.headline3(),)
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            PlantItem()
          ],
        ),
      ),
    );
  }
}
