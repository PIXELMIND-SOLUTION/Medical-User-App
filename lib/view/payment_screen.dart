import 'package:flutter/material.dart';
import 'package:medical_user_app/view/card_details_screen.dart';
import 'package:medical_user_app/view/change_address_screen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/services.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPaymentMethod = 0;
  final TextEditingController _notesController = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _transcription = '';
  bool _showNoteInput = false;

  final paymentMethods = [
    {'name': 'Credit/Debit card', 'icon': Icons.credit_card},
    {'name': 'Phonepe', 'icon': Icons.account_balance_wallet},
    {'name': 'Google pay', 'icon': Icons.g_mobiledata},
    {'name': 'Paytm', 'icon': Icons.payment},
    {'name': 'Cash on Delivery', 'icon': Icons.money},
  ];

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  // Initialize speech recognition
  void _initSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'notListening') {
          setState(() => _isListening = false);
        }
      },
      onError: (error) {
        setState(() => _isListening = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      },
    );
    if (!available) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Speech recognition not available')),
      );
    }
  }

  // Start listening for speech
  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _transcription = result.recognizedWords;
              if (result.finalResult) {
                _notesController.text += _transcription + ' ';
                _transcription = '';
                _isListening = false;
              }
            });
          },
        );
      }
    }
  }

  // Stop listening
  void _stopListening() {
    if (_isListening) {
      _speech.stop();
      setState(() => _isListening = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 18),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Delivery address
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              title: const Text(
                'Delivery address',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.black54),
                  SizedBox(width: 4),
                  Text(
                    'Gandhi nagar,1-2-12',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.black54),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeAddressScreen()));
              },
            ),
          ),
      
          const Divider(thickness: 1),
      
          // Order details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Your Order',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '2 Items from ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'Appolo',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '1x ',
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'DOLO, ASPRINE',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      '₹250.00',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
      
          const SizedBox(height: 20),
      
          // Notes section title with toggle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Add notes about your order',
                  style: TextStyle(
                    color: const Color(0XFF000080),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      
          // Notes input section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Text input field with voice button
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F2F6),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: _notesController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Type ',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          contentPadding: const EdgeInsets.all(16),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.edit_note,
                              color: Colors.grey.shade600),
                          suffixIcon: _notesController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear,
                                      color: Colors.grey),
                                  onPressed: () {
                                    setState(() {
                                      _notesController.clear();
                                    });
                                  },
                                )
                              : null,
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
      
                    // Voice note button positioned at top right
                    Positioned(
                      top: 8,
                      right: 8,
                      child: InkWell(
                        onTap: _isListening ? _stopListening : _startListening,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: _isListening
                                ? Colors.red.shade100
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _isListening ? Icons.mic : Icons.mic_none,
                                size: 16,
                                color: _isListening
                                    ? Colors.red
                                    : Colors.deepPurple,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _isListening ? 'Stop' : 'Voice Note',
                                style: TextStyle(
                                  color: _isListening
                                      ? Colors.red
                                      : Colors.grey.shade700,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
      
                // Voice transcription indicator
                if (_transcription.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.mic,
                          size: 14,
                          color: Colors.deepPurple,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _transcription,
                            style: const TextStyle(
                              color: Colors.deepPurple,
                              fontStyle: FontStyle.italic,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
      
          // Payment methods
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment method',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: List.generate(
                      paymentMethods.length,
                      (index) => RadioListTile(
                        title: Row(
                          children: [
                            Text(
                              paymentMethods[index]['name'].toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            _getPaymentIcon(index),
                          ],
                        ),
                        value: index,
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value as int;
                          });
                        },
                        activeColor: Colors.deepPurple,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      
          const Spacer(),
      
          // Proceed button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CardDetailsScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFF5931DD),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Proceed to pay',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _getPaymentIcon(int index) {
  switch (index) {
    case 0: // Credit/Debit card
      return Container(
        width: 32,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Image.asset(
          'assets/icons/card.png',
          fit: BoxFit.contain,
        ),
      );
    case 1: // PhonePe
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          'assets/icons/phone_pay.png',
          fit: BoxFit.contain,
        ),
      );
    case 2: // Google Pay
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              'assets/icons/gp.jpeg',
              fit: BoxFit.contain,
            ),
          ),
        ],
      );
    case 3: // Paytm
      return Container(
        width: 32,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Image.asset(
          'assets/icons/paytm.png',
          fit: BoxFit.contain,
        ),
      );
    case 4: // Cash on Delivery
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          'assets/icons/cash.png',
          fit: BoxFit.contain,
        ),
      );
    default:
      return const SizedBox();
  }
}


}
