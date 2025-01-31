import 'package:app/theme/typography_styles.dart';
import 'package:flutter/material.dart';

class PlantItem extends StatelessWidget {
  const PlantItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink(
        width: double.maxFinite,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0,5),
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Image.asset("assets/logo/icon.png", width: 40, height: 40,),
              const SizedBox(width: 20,),
              Column(
                children: [
                  Text("Testículo", style: TypographyStyles.label2(),)

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getWaterLevel(){

  }
}
