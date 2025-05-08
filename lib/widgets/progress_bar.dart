import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  
  const CustomProgressBar({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background track
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Progress line
          Positioned(
            left: 0,
            child: Container(
              height: 10,
              width: MediaQuery.of(context).size.width * 0.65, // Adjust percentage based on progress (currently at step 2 of 3)
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.indigo.shade500],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          
          // Step indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalSteps, (index) {
              bool isCompleted = index < currentStep;
              bool isCurrent = index == currentStep - 1;
              
              return Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isCompleted ? 
                    (isCurrent ? Colors.indigo.shade500 : Colors.blue.shade400) : 
                    Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted ? Colors.transparent : Colors.grey.shade300,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: 16,
                    color: isCompleted ? Colors.white : Colors.grey.shade400,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
