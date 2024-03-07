import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_generator/feature/prompt/bloc/prompt_bloc.dart';

class CreatePromoptScreen extends StatefulWidget {
  const CreatePromoptScreen({super.key});

  @override
  State<CreatePromoptScreen> createState() => _CreatePromoptScreenState();
}

class _CreatePromoptScreenState extends State<CreatePromoptScreen> {
  TextEditingController controller = TextEditingController();

  final PromptBloc promptBloc =PromptBloc();

  @override
  void initState() {
    promptBloc.add(PromptInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generate Images 🚀"),
      ),
      body: BlocConsumer<PromptBloc, PromptState>(
        bloc: promptBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType){
            case PromptGeneratingImageLoadState:
              return Center(child: CircularProgressIndicator());

            case PromptGeneratingImageErrorState:
              return Center(child: Text("Something went Wrong"),);

            case PromptGeneratingImageSuccessState:
              final successState = state as PromptGeneratingImageSuccessState;
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                                image: MemoryImage(successState.uint8list))
                          ),
                        )),
                    Container(
                      height: 240,
                      padding: const EdgeInsets.all(24),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Enter your prompt", style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),),
                            const SizedBox(height: 20),
                            TextField(
                              controller: controller,
                              cursorColor: Colors.deepPurple,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple),
                                      borderRadius: BorderRadius.circular(12)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12))),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 48,
                              width: double.maxFinite,
                              child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                          Colors.deepPurple)
                                  ),
                                  onPressed: () {
                                    if(controller.text.isNotEmpty){
                                      promptBloc.add(PromptEnteredEvent(prompt: controller.text));
                                    }
                                  },
                                  icon: Icon(
                                    Icons.generating_tokens,
                                  ),
                                  label: Text("Generate")),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );

            default:
              return SizedBox();

          }
        },
      ),
    );
  }
}
