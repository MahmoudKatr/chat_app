import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/cubits/chat_cubit/chat_states.dart';
import 'package:shop_app/features/authentications/login_screen.dart';

import '../../components/widget/chat_bubble.dart';
import '../../constants/constants.dart';
import '../../cubits/chat_cubit/chat_cubit.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'ChatPage';

  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? email;

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
    });
  }

  Future<void> _sendImage() async {
    context.read<ChatCubit>().sendImage(email!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is ChatLoading || email == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ChatError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Error"),
            ),
            body: Center(
              child: Text("Error: ${state.error}"),
            ),
          );
        } else if (state is ChatSuccess) {
          final messages = state.messages;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.grey,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chat",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<ChatCubit>().signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return message.id == email
                          ? ChatBubble(message: message)
                          : ChatBubbleForFriend(message: message);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.image,
                            color: AppColors.darkBlueGreen),
                        onPressed: _sendImage,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          onSubmitted: (data) {
                            if (data.trim().isNotEmpty) {
                              context
                                  .read<ChatCubit>()
                                  .sendMessage(data.trim(), email!);
                              _controller.clear();
                              _scrollController.animateTo(
                                0,
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn,
                              );
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: AppColors.darkBlueGreen),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                final data = _controller.text.trim();
                                if (data.isNotEmpty) {
                                  context
                                      .read<ChatCubit>()
                                      .sendMessage(data, email!);
                                  _controller.clear();
                                  _scrollController.animateTo(
                                    0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.fastOutSlowIn,
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.send,
                                color: AppColors.darkBlueGreen,
                              ),
                            ),
                            hintText: "Send Message",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text("No messages yet."),
            ),
          );
        }
      },
    );
  }
}
