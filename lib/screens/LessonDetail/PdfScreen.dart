

import 'package:flutter/material.dart';
import 'package:lettutor/screens/LessonDetail/LessonDetail.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatefulWidget {
   const PdfScreen({Key? key, required this.document}) : super(key: key);
   final Item document;
   @override
   State<PdfScreen> createState() => _PdfScreenState();
 }

 class _PdfScreenState extends State<PdfScreen> {
   @override
   Widget build(BuildContext context) {
     return  Scaffold(
        appBar: AppBar(
          title: Text(widget.document.expandedValue!),
        ),
       body: Container(
         child: SfPdfViewer.network(widget.document.url!),
       ),
     );
   }
 }
