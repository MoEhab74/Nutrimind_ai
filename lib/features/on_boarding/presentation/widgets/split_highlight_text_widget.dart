import 'package:flutter/material.dart';

class SplitHighlightText extends StatelessWidget {
  const SplitHighlightText({
    super.key,
    required this.text,
    required this.style,
    required this.highlightStyle,
    this.highlightAfterWordCount = 3,
    this.textAlign = TextAlign.start,
  });

  final String text;
  final TextStyle style;
  final TextStyle highlightStyle;
  final int highlightAfterWordCount;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final words = text.split(' ');

    // Not enough words to split — render everything in the base style.
    if (words.length <= highlightAfterWordCount) {
      return Text(text, textAlign: textAlign, style: style);
    }

    final normalPart = words.take(highlightAfterWordCount).join(' ');
    final highlightedPart = words.skip(highlightAfterWordCount).join(' ');

    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: style,
        children: [
          TextSpan(text: '$normalPart '),
          TextSpan(text: highlightedPart, style: highlightStyle),
        ],
      ),
    );
  }
}