import 'package:flutter/material.dart';

import '../app_color.dart';
import '../app_constant.dart';

class ShowModalBottomSheetForFilter extends StatefulWidget {
  int selectedFilterIndex;
  final Function(String) onFilterSelected; // Callback for selected filter
  ShowModalBottomSheetForFilter({required this.selectedFilterIndex,required this.onFilterSelected});

  @override
  State<ShowModalBottomSheetForFilter> createState() =>
      _ShowModalBottomSheetForFilterState();
}

class _ShowModalBottomSheetForFilterState
    extends State<ShowModalBottomSheetForFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Add Filter',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Column(
                children: List.generate(AppConstant.filterOptionsList.length,
                    (index) {
                  final filterOption = AppConstant.filterOptionsList[index];
                  final isSelected = widget.selectedFilterIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.selectedFilterIndex = index;
                      });
                      widget.onFilterSelected(filterOption.filterOptionName);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            isSelected ? AppColor.ColorDarkBlue : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? AppColor.ColorDarkBlue
                              : AppColor.ColorLightgray,
                          width: isSelected ? 4 : 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          filterOption.filterOptionName,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
