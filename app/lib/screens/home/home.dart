import 'package:app/entities/get_plant_dto.dart';
import 'package:app/screens/home/widgets/led_toggle/led_toggle.dart';
import 'package:app/screens/plant_editor/plant_editor.dart';
import 'package:app/theme/theme_colors.dart';
import 'package:app/theme/typography_styles.dart';
import 'package:app/shared/wigets/plant_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/plants_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    BlocProvider.of<PlantsBloc>(context).add(LoadPlantsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 200,
          child: Row(
            children: [
              Image.asset(
                "assets/logo/icon.png",
                width: 20,
                height: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Planty",
                style: TypographyStyles.headline3(),
              )
            ],
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: LedToggle(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PlantEditor()));
        },
        shape: const CircleBorder(),
        backgroundColor: ThemeColors.primary2,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<PlantsBloc>(context).add(LoadPlantsEvent());
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<PlantsBloc, PlantsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is LoadingPlantsState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ThemeColors.primary1,
                  ),
                );
              }

              if (state is LoadPlantsErrorState) {
                return ListView(
                  // Mantém o RefreshIndicator funcional
                  children: [
                    Center(
                      child: Text(
                        state.message,
                        style: TypographyStyles.paragraph2(),
                      ),
                    )
                  ],
                );
              }

              if (state is LoadedPlantsState) {
                return ListView(
                  children: state.plants.isEmpty
                      ? [
                          Center(
                              child: Text(
                            "Sem plantas cadastradas",
                            style: TypographyStyles.label2(),
                          ))
                        ]
                      : state.plants.map((el) {
                          return PlantItem(plant: el);
                        }).toList(),
                );
              }

              return ListView(); // Garante que sempre há um ListView rolável
            },
          ),
        ),
      ),
    );
  }
}
