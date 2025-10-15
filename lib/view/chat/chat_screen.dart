// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/providers/chat_provider.dart';
import 'package:medical_user_app/models/chat_model.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String riderId;
  // final String riderName;
  // final String? riderImage;

  const ChatScreen({
    super.key,
    required this.userId,
    required this.riderId,
    // required this.riderName,
    // this.riderImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late ChatProvider _chatProvider;

  @override
  void initState() {
    super.initState();
    _chatProvider = Provider.of<ChatProvider>(context, listen: false);
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    await _chatProvider.initializeChat(
      userId: widget.userId,
      riderId: widget.riderId,
    );
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    _messageController.clear();
    
    final success = await _chatProvider.sendMessage(
      userId: widget.userId,
      riderId: widget.riderId,
      message: message,
      senderType: 'user',
    );

    if (success) {
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          if (chatProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              // Messages List
              Expanded(
                child: _buildMessagesList(chatProvider),
              ),
              // Error Message
              if (chatProvider.error.isNotEmpty)
                _buildErrorMessage(chatProvider),
              // Message Input
              _buildMessageInput(chatProvider),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 2,
      shadowColor: Colors.black26,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      title:const Row(
        children: [
          // CircleAvatar(
          //   radius: 18,
          //   backgroundColor: Colors.blue[100],
          //   backgroundImage: widget.riderImage != null 
          //       ? NetworkImage(widget.riderImage!) 
          //       : null,
          //   child: widget.riderImage == null
          //       ? Text(
          //           widget.riderName.isNotEmpty 
          //               ? widget.riderName[0].toUpperCase()
          //               : 'R',
          //           style: const TextStyle(
          //             fontWeight: FontWeight.bold,
          //             color: Colors.blue,
          //           ),
          //         )
          //       : null,
          // ),
           SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   widget.riderName,
                //   style: const TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                Text(
                  'Chat',
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.phone),
      //     onPressed: () {
      //       // Handle call functionality
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(content: Text('Calling rider...')),
      //       );
      //     },
      //   ),
      //   IconButton(
      //     icon: const Icon(Icons.more_vert),
      //     onPressed: () {
      //       // Handle more options
      //     },
      //   ),
      // ],
    );
  }

  Widget _buildMessagesList(ChatProvider chatProvider) {
    if (chatProvider.messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No messages yet',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start a conversation with your delivery partner',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: chatProvider.messages.length,
      itemBuilder: (context, index) {
        final message = chatProvider.messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isFromUser = message.isFromUser;
    final isFromRider = message.isFromRider;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isFromUser 
            ? MainAxisAlignment.end 
            : MainAxisAlignment.start,
        children: [
          // if (isFromRider) ...[
          //   CircleAvatar(
          //     radius: 14,
          //     backgroundColor: Colors.blue[100],
          //     backgroundImage: widget.riderImage != null 
          //         ? NetworkImage(widget.riderImage!) 
          //         : null,
          //     child: widget.riderImage == null
          //         ? Text(
          //             widget.riderName.isNotEmpty 
          //                 ? widget.riderName[0].toUpperCase()
          //                 : 'R',
          //             style: const TextStyle(
          //               fontSize: 12,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.blue,
          //             ),
          //           )
          //         : null,
          //   ),
          //   const SizedBox(width: 8),
          // ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: isFromUser 
                    ? Colors.blue[600] 
                    : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isFromUser ? 18 : 4),
                  bottomRight: Radius.circular(isFromUser ? 4 : 18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: isFromUser 
                    ? CrossAxisAlignment.end 
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.message,
                    style: TextStyle(
                      color: isFromUser ? Colors.white : Colors.black87,
                      fontSize: 15,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      color: isFromUser 
                          ? Colors.white.withOpacity(0.7)
                          : Colors.grey[500],
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // if (isFromUser) ...[
          //   const SizedBox(width: 8),
          //   CircleAvatar(
          //     radius: 14,
          //     backgroundColor: Colors.green[100],
          //     child: const Icon(
          //       Icons.person,
          //       size: 16,
          //       color: Colors.green,
          //     ),
          //   ),
          // ],
        ],
      ),
    );
  }

  Widget _buildErrorMessage(ChatProvider chatProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red[700], size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              chatProvider.error,
              style: TextStyle(
                color: Colors.red[700],
                fontSize: 14,
              ),
            ),
          ),
          TextButton(
            onPressed: () => chatProvider.clearError(),
            child: Text(
              'Dismiss',
              style: TextStyle(color: Colors.red[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput(ChatProvider chatProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Attachment button
            // Container(
            //   decoration: BoxDecoration(
            //     color: Colors.grey[100],
            //     shape: BoxShape.circle,
            //   ),
            //   child: IconButton(
            //     icon: Icon(Icons.attach_file, color: Colors.grey[600]),
            //     onPressed: () {
            //       // Handle file attachment
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(content: Text('File attachment coming soon')),
            //       );
            //     },
            //   ),
            // ),
            const SizedBox(width: 12),
            
            // Message input field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Type your message...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Send button
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[600],
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: chatProvider.isSending
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(Icons.send, color: Colors.white),
                onPressed: chatProvider.isSending ? null : _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (messageDate == today) {
      // Today: show time only
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      // Other days: show date and time
      return '${dateTime.day}/${dateTime.month} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}