import 'package:app/entities/get_plant_dto.dart';
import 'package:app/theme/typography_styles.dart';
import 'package:flutter/material.dart';

class PlantItem extends StatelessWidget {
  final GetPlantDto plant;
  const PlantItem({required this.plant, super.key});

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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(plant.name, style: TypographyStyles.label2(),),
                  Row(
                    children: [
                      getWaterLevel(),
                      const SizedBox(width: 5,),
                      Text("${plant.currentMoisturePercentage}% - Ideal ${plant.idealMoisturePercentage}%"),
                    ],
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getWaterLevel(){
    double idealLevelOffsetUpper = 1.1;
    double idealLevelOffsetDown = 0.9;
    double limitLevelOffsetUpper = 1.2;
    double limitLevelOffsetDown = 0.8;
    double extremeLevelOffsetUp = 1.3;
    double extremeLevelOffsetDown = 0.7;

    var moisture = plant.currentMoisturePercentage;
    var ideal = plant.idealMoisturePercentage;

    String tooMuchWater = "assets/icons/too_much_water.png";
    String waterLimit = "assets/icons/water_limit.png";
    String idealWater = "assets/icons/ideal_water.png";
    String noWater = "assets/icons/no_water.png";

    String asset = "";

    if (moisture >= ideal * extremeLevelOffsetUp) {
      asset = tooMuchWater;
    } else if (moisture >= ideal * limitLevelOffsetUpper) {
      asset = waterLimit;
    } else if (moisture >= ideal * idealLevelOffsetDown && moisture <= ideal * idealLevelOffsetUpper) {
      asset = idealWater;
    } else if (moisture >= ideal * limitLevelOffsetDown) {
      asset = waterLimit;
    } else if (moisture < ideal * extremeLevelOffsetDown) {
      asset = noWater;
    } else {
      asset = waterLimit; // Caso esteja entre o nível extremo e o limite inferior.
    }

    return Image.asset(asset, width: 20, height: 20,);
  }
}
