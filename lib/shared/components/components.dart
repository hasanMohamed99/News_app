import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/news_app/web_view/web_view_screen.dart';

Widget defaultTextFormField({
  required String label,
  required TextEditingController controller,
  required TextInputType type,
  required validator,
  border,
  bool obscureText = false,
  Icon? prefixIcon,
  Icon? suffixIcon,
  onFieldSubmitted,
  onChanged,
  suffixPressed,
  onTap,
  enabled,
}) =>
    TextFormField(
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
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: suffixIcon,
              )
            : null,
      ),
    );

Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );

Widget buildArticleItem(article, context, {Brightness? currentBrightness}) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            SizedBox(
              width: 120.0,
              height: 120.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: '${article["urlToImage"]}',
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    size: MediaQuery.of(context).size.width /
                        MediaQuery.of(context).size.height *100,
                  ),
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
                        article['title'].toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: currentBrightness == Brightness.light? Colors.black: Colors.white,
                        ) ,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      article['publishedAt'].toString().substring(0, 10),
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

void navigateTo(context, Widget widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, Widget widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );
