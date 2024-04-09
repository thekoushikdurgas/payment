import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paymentanalysis/src/pages/models.dart';
import 'package:paymentanalysis/utilities/color.dart';

class HomePage extends StatefulWidget {
  @override
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController colorController = TextEditingController();

  final TextEditingController iconController = TextEditingController();
  List<String> suggestionList = [
    'Reason 1',
    'Reason 2',
    'Reason 3',
    'Reason 4',
    // Add more reasons as needed
  ];
  final TextEditingController reasonController = TextEditingController();
  FocusNode reasonFocusNode = FocusNode();

  ReasonLabel? selectedColor;

  IconLabel? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome to my app!'),
              ElevatedButton(
                onPressed: () {
                  // Handle button press event (e.g., navigate to another screen)
                  Navigator.pushNamed(context, '/details'); // Replace '/details' with the actual route name
                },
                child: const Text('Go to Details'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isDismissible: true,
            context: context,
            elevation: 10,
            barrierColor: TKDColor.overlayColor,
            isScrollControlled: true,
            enableDrag: true,
            backgroundColor: TKDColor.overlaybgColor,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            builder: (BuildContext context) {
              return SizedBox(
                height: 600,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: TKDColor.textColor, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: TKDColor.textColor, width: 1.0),
                          ),
                          labelStyle: TextStyle(color: TKDColor.textColor),
                          hintText: '000.....',
                          hintStyle: TextStyle(color: TKDColor.textColor),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        focusNode: reasonFocusNode,
                        controller: reasonController,
                        decoration: InputDecoration(
                          labelText: 'Reasons',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: TKDColor.textColor, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: TKDColor.textColor, width: 1.0),
                          ),
                          labelStyle: TextStyle(color: TKDColor.textColor),
                          hintText: 'Enter a reason',
                          hintStyle: TextStyle(color: TKDColor.textColor),
                        ),
                      ),
                      Positioned(
                        top: 20, // Adjust the top position as needed
                        left: 0, // Adjust the left position as needed
                        right: 0, // Adjust the right position as needed
                        child: Visibility(
                          visible: reasonFocusNode.hasFocus,
                          child: SizedBox(
                            height: 200,
                            child: ListView.builder(
                              itemCount: suggestionList.length,
                              itemBuilder: (context, index) {
                                final suggestion = suggestionList[index];
                                // Filter the suggestionList based on the text entered in the reasonController
                                final filteredList = suggestionList.where((suggestion) => suggestion.toLowerCase().contains(reasonController.text.toLowerCase()));
                                // Sort the filteredList alphabetically
                                final sortedList = filteredList.toList()..sort();
                                return ListTile(
                                  title: Text(sortedList[index]),
                                  onTap: () {
                                    setState(() {
                                      reasonController.text = sortedList[index]; // Populate the text field with the selected reason
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      DropdownMenu(
                        width: 350,
                        controller: iconController,
                        enableFilter: true,
                        requestFocusOnTap: true,
                        leadingIcon: const Icon(Icons.search),
                        inputDecorationTheme: InputDecorationTheme(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: TKDColor.textColor, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: TKDColor.textColor, width: 1.0),
                          ),
                          labelStyle: TextStyle(color: TKDColor.textColor),
                          hintStyle: TextStyle(color: TKDColor.textColor),
                        ),
                        label: const Text('Freiend'),
                        onSelected: (IconLabel? icon) {
                          debugPrint(icon.toString());
                          setState(() {
                            selectedIcon = icon;
                          });
                        },
                        dropdownMenuEntries: IconLabel.values.map<DropdownMenuEntry<IconLabel>>(
                          (IconLabel icon) {
                            return DropdownMenuEntry<IconLabel>(
                              value: icon,
                              label: icon.label,
                              // leadingIcon: Icon(icon.icon),
                            );
                          },
                        ).toList(),
                      ),
                      // if (selectedColor != null && selectedIcon != null)
                      //   Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: <Widget>[
                      //       Text('You selected a ${selectedColor?.label} ${selectedIcon?.label}'),
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 5),
                      //         child: Icon(
                      //           selectedIcon?.icon,
                      //           color: selectedColor?.color,
                      //         ),
                      //       )
                      //     ],
                      //   )
                      // else
                      //   const Text('Please select a color and an icon.')
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
