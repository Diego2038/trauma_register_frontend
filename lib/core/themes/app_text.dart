import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_size_text.dart';

class H1 extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color color;
  final FontWeight fontWeight;
  final int? maxLines;

  const H1({
    super.key,
    required this.text,
    this.textAlign,
    this.color = AppColors.black,
    this.fontWeight = FontWeight.w300,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: AppSizeText.h1,
        color: color,
        fontWeight: FontWeight.w300,
      ),
      maxLines: maxLines,
    );
  }
}

class H2 extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color color;
  final FontWeight fontWeight;
  final int? maxLines;

  const H2({
    super.key,
    required this.text,
    this.textAlign,
    this.color = AppColors.black,
    this.fontWeight = FontWeight.w300,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: AppSizeText.h2,
        color: color,
        fontWeight: fontWeight,
      ),
      maxLines: maxLines,
    );
  }
}

class H3 extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color color;
  final FontWeight fontWeight;
  final int? maxLines;

  const H3({
    super.key,
    required this.text,
    this.textAlign,
    this.color = AppColors.black,
    this.fontWeight = FontWeight.w300,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: AppSizeText.h3,
        color: color,
        fontWeight: fontWeight,
      ),
      maxLines: maxLines,
    );
  }
}

class H4 extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color color;
  final FontWeight fontWeight;
  final int? maxLines;

  const H4({
    super.key,
    required this.text,
    this.textAlign,
    this.color = AppColors.black,
    this.fontWeight = FontWeight.w300,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: AppSizeText.h4,
        color: color,
        fontWeight: fontWeight,
      ),
      maxLines: maxLines,
    );
  }
}

class H5 extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color color;
  final FontWeight fontWeight;
  final int? maxLines;

  const H5({
    super.key,
    required this.text,
    this.textAlign,
    this.color = AppColors.black,
    this.fontWeight = FontWeight.w300,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: AppSizeText.h5,
        color: color,
        fontWeight: fontWeight,
      ),
      maxLines: maxLines,
    );
  }
}

class H6 extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color color;
  final FontWeight fontWeight;
  final int? maxLines;

  const H6({
    super.key,
    required this.text,
    this.textAlign,
    this.color = AppColors.black,
    this.fontWeight = FontWeight.w300,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: AppSizeText.h6,
        color: color,
        fontWeight: fontWeight,
      ),
      maxLines: maxLines,
    );
  }
}

class NormalText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color color;
  final FontWeight fontWeight;
  final int? maxLines;

  const NormalText({
    super.key,
    required this.text,
    this.textAlign,
    this.color = AppColors.black,
    this.fontWeight = FontWeight.w300,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: AppSizeText.normal,
        color: color,
        fontWeight: fontWeight,
      ),
      maxLines: maxLines,
    );
  }
}

class HeaderText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color color;
  final FontWeight fontWeight;
  final int? maxLines;

  const HeaderText({
    super.key,
    required this.text,
    this.textAlign,
    this.color = AppColors.black,
    this.fontWeight = FontWeight.w300,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: AppSizeText.header,
        color: color,
        fontWeight: fontWeight,
      ),
      maxLines: maxLines,
    );
  }
}
