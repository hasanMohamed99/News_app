import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/modules/news_app/web_view/web_view_screen.dart';

Widget defaultTextFormField({
  required String label,
  required TextEditingController controller,
  required TextInputType type,
  required validator,
  border, //OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
  bool obscureText = false,
  Icon? prefixIcon,
  Icon? suffixIcon,
  onFieldSubmitted,
  onChanged,
  suffixPressed,
  onTap,
  enabled,
}) => TextFormField(
  enabled: enabled,
  controller: controller,
  keyboardType: type,
  obscureText: obscureText,
  onFieldSubmitted: onFieldSubmitted,
  onChanged: onChanged,
  onTap: onTap,
  validator: validator,
  decoration: InputDecoration(
    border: border,
    labelText: label,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon != null ? IconButton(
      onPressed: suffixPressed,
      icon: suffixIcon,
    ): null,
  ),
);

Widget defaultTextButton({required function,required String text,}) => TextButton(
  onPressed: function,
  child: Text(text.toUpperCase()),
);

Widget myDivider() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
);

Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        SizedBox(
          width: 120.0,
          height: 120.0,
          child:ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl: '${article["urlToImage"]}',
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: SizedBox(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

void navigateTo(context,Widget widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context,Widget widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),(Route<dynamic> route) => false,
);

void showToast ({required String text,required ToastStates state ,textColor}) => Fluttertoast.showToast(
  msg: text,
  textColor: Colors.white,
  backgroundColor: chooseToastColor(state),
  toastLength: Toast.LENGTH_LONG,
);

// ignore: constant_identifier_names
enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color =  Colors.amber;
      break;
  }
  return color;
}

