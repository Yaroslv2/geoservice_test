import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geoservise_test/application/cubit/homepage_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: MediaQuery.of(context).size.height * 0.14,
          title: const CoordFormField(),
        ),
        body: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            if (state is HomepageInitial) {
              return const Center(
                child: Text(
                  "Здесь будет изображение парковки по координатам",
                ),
              );
            }
            if (state is HomePageLoadedSuccess) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      state.imageUrl,
                      scale: 0.75,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;

                        return const CircularProgressIndicator();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Text(
                            "Не удалось найти картинку по данным координатам");
                      },
                    ),
                    Text(
                      "X: ${state.tileCoords["x"]} Y: ${state.tileCoords["y"]}",
                    ),
                  ],
                ),
              );
            }
            if (state is HomePageLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const Center(
              child: Text(
                "Произошла ошибка...",
              ),
            );
          },
        ),
      ),
    );
  }
}

class CoordFormField extends StatefulWidget {
  const CoordFormField({super.key});

  @override
  State<CoordFormField> createState() => _CoordFormFieldState();
}

class _CoordFormFieldState extends State<CoordFormField> {
  final TextEditingController _xCoordController = TextEditingController();
  final TextEditingController _yCoordController = TextEditingController();
  final TextEditingController _zCoordController = TextEditingController();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    return Form(
      key: keyForm,
      child: SizedBox(
        width: double.infinity,
        height: _screenHeight * 0.1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: _screenWidth * 0.26,
              child: TextFormField(
                controller: _xCoordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "X",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Заполните это поле";
                  } else if (double.tryParse(value) == null) {
                    return "Значение не является числом";
                  }

                  return null;
                },
              ),
            ),
            SizedBox(
              width: _screenWidth * 0.26,
              child: TextFormField(
                controller: _yCoordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Y",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Заполните это поле";
                  } else if (double.tryParse(value) == null) {
                    return "Значение не является числом";
                  }

                  return null;
                },
              ),
            ),
            SizedBox(
              width: _screenWidth * 0.26,
              child: TextFormField(
                controller: _zCoordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Z",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Заполните это поле";
                  } else if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
                    return "Значение не является числом или челочисленным значением";
                  } else if (int.parse(value) < 0 || int.parse(value) > 20) {
                    return "Некорректное значение. Значение должно быть в диапазоне от 0 до 20";
                  }

                  return null;
                },
              ),
            ),
            SizedBox(
              width: _screenWidth * 0.15,
              height: _screenHeight * 0.06,
              child: TextButton(
                onPressed: () {
                  if (keyForm.currentState!.validate()) {
                    BlocProvider.of<HomePageCubit>(context).add(
                        double.tryParse(_xCoordController.text),
                        double.tryParse(_yCoordController.text),
                        int.tryParse(_zCoordController.text));
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  "Найти",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
