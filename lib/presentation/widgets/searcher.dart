import 'package:flutter/material.dart';

class Searcher extends StatelessWidget {

  final ValueChanged<String> onSubmit;

  const Searcher({
    super.key,
    required this.onSubmit  
  });

  @override
  Widget build(BuildContext context) {

    // Controla el estado del text field
    final textController = TextEditingController();

    // Controla el focus del text field
    final focusNode = FocusNode();

    final color = Theme.of(context).colorScheme.primary;
    final inputDecoration = InputDecoration(
      hintText: 'Buscar...',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide( color: color ),
      ),
      suffixIcon: IconButton(
        icon: const Icon(Icons.search),
        iconSize: 30,
        onPressed: () {
          final textValue = textController.value.text;
          // chatProvider.sendMessage( textValue );
          onSubmit( textValue );
          textController.clear();
        },
      ),
    );



    return TextFormField(
      controller: textController,
      decoration: inputDecoration,
      focusNode: focusNode,
      onFieldSubmitted: (value) {
        onSubmit( value );
        textController.clear();

        // Se enfoca nuevamente el field
        focusNode.requestFocus();
      },
      onTapOutside: ( event ) => focusNode.unfocus(),
      onChanged: (value) {
        // print(value);
      }
    );
  }
}