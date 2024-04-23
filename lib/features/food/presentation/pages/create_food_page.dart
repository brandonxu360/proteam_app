import 'package:flutter/material.dart';
import 'package:proteam_app/core/theme/color_style.dart';
import 'package:proteam_app/core/theme/text_style.dart';
import 'package:proteam_app/core/widgets/image_widget.dart';

class CreateFoodPage extends StatefulWidget {
  const CreateFoodPage({super.key});

  @override
  State<CreateFoodPage> createState() => _CreateFoodPageState();
}

class _CreateFoodPageState extends State<CreateFoodPage> {
  // Global key for the form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(
                            color: boneColor,
                            width: 1, 
                          )),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: imageWidget(imageType: ImageType.meal)),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: boneColor,
                          ),
                          child: const Icon(
                            Icons.image,
                            color: blackColor,
                            size: 25,
                          ),
                        ),
                      ),
                    )
                  ])
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Food Details',
                style: Styles.headline1,
              ),
              const Text(
                  'Create your own custom food. Add a name and nutritional information.',
                  style: Styles.bodyText2),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    labelText: 'Name'),
              ),
              const SizedBox(height: 20),
              const Text('Serving Size', style: Styles.headline2),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            labelText: 'Servings')),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            labelText: 'Units')),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Text('Nutrition Facts', style: Styles.headline2),
              const SizedBox(height: 5),
              TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      labelText: 'Calories',
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text('cals'),
                      ))),
              const SizedBox(height: 10),
              TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      labelText: 'Carbs',
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text('g'),
                      ))),
              const SizedBox(height: 10),
              TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      labelText: 'Protein',
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text('g'),
                      ))),
              const SizedBox(height: 10),
              TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      labelText: 'Fat',
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text('g'),
                      ))),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: boneColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: false == true
                        ? const Center(
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                color: blackColor,
                              ),
                            ),
                          )
                        : const Center(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: blackColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
