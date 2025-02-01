import 'package:app/entities/create_plant_dto.dart';
import 'package:app/entities/get_plant_dto.dart';
import 'package:app/screens/home/bloc/plants_bloc.dart';
import 'package:app/shared/toast/toast_service.dart';
import 'package:app/shared/wigets/action_button.dart';
import 'package:app/shared/wigets/custom_text_field.dart';
import 'package:app/theme/typography_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlantEditor extends StatefulWidget {
  final GetPlantDto? plant;

  const PlantEditor({super.key, this.plant});

  @override
  State<PlantEditor> createState() => _PlantEditorState();
}

class _PlantEditorState extends State<PlantEditor> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController moistureController = TextEditingController();
  TextEditingController lightController = TextEditingController();
  TextEditingController tempController = TextEditingController();
  String? sensorPort;

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    moistureController.dispose();
    lightController.dispose();
    tempController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.plant != null) {
      sensorPort = widget.plant!.sensorPort;
    }
    super.initState();
  }

  onSubmit() {
    if(moistureController.text.isEmpty){
      ToastService.showError(message: "Umidade do solo não deve ser nula");
      return;
    }
    if(lightController.text.isEmpty){
      ToastService.showError(message: "Luminosidade não deve ser nula");
      return;
    }
    if(tempController.text.isEmpty){
      ToastService.showError(message: "Temperatura não deve ser nula");
      return;
    }
    if(sensorPort == null || sensorPort!.isEmpty){
      ToastService.showError(message: "Porta do sensor não deve ser nula");
      return;
    }
    BlocProvider.of<PlantsBloc>(context).add(
      CreatePlantEvent(
        plantDto: CreatePlantDto(
            name: nameController.text,
            description: descController.text,
            idealMoisturePercentage: int.parse(moistureController.text),
            idealLightExposure: int.parse(lightController.text),
            idealTemperatureCelsius: int.parse(tempController.text),
            sensorPort: sensorPort!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PlantsBloc, PlantsState>(
        listener: (context, state) {
          if(state is CreatePlantErrorState){
            ToastService.showError(message: state.message);
          }
        },
        builder: (context, state) {
          if(state is CreatingPlantState){
            return const CircularProgressIndicator();
          }
          return Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black,
                            Colors.black.withOpacity(1),
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                          ],
                          stops: const [0, 0.8, 0.9, 1],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: SizedBox(
                          height: 180,
                          width: double.maxFinite,
                          child: Image.asset(
                            "assets/images/suculenta.jpg",
                            fit: BoxFit.fitWidth,
                          )),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          padding: const EdgeInsets.all(10),
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Text(
                          "Adicionar\nplanta",
                          style: TypographyStyles.label1(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Form(
                        key: UniqueKey(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              label: "Nome",
                              hintText: "Minha plantinha",
                              onChanged: (value) {},
                              controller: nameController,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextField(
                              label: "Descrição",
                              hintText: "Cheirosinha e bonitinha",
                              onChanged: (value) {},
                              controller: descController,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextField(
                              label: "Temperatura ideal",
                              hintText: "0 a 45º",
                              onChanged: (value) {},
                              controller: tempController,
                              keyboardType: TextInputType.number,
                              textInputFormatters: [
                                FilteringTextInputFormatter(RegExp(r'[0-9]'),
                                    allow: true),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextField(
                              label: "Luminosidade ideal",
                              hintText: "0 a 20000",
                              onChanged: (value) {},
                              controller: lightController,
                              keyboardType: TextInputType.number,
                              textInputFormatters: [
                                FilteringTextInputFormatter(RegExp(r'[0-9]'),
                                    allow: true),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextField(
                              label: "Umidade do solo ideal",
                              hintText: "0 a 100%",
                              onChanged: (value) {},
                              controller: moistureController,
                              keyboardType: TextInputType.number,
                              textInputFormatters: [
                                FilteringTextInputFormatter(RegExp(r'[0-9]'),
                                    allow: true),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            DropdownButton<String>(
                              isExpanded: false,
                              value: sensorPort,
                              hint: Text(
                                "Porta do sensor",
                                style: TypographyStyles.paragraph3(),
                              ),
                              items: <String>['A0', "A3", "A4", "A5"].map((
                                  value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  sensorPort = value ?? sensorPort;
                                });
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: ActionButton(onTap: onSubmit,),
      ),
    );
  }
}
