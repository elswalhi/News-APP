import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/medule/webview/web_view.dart';

Widget defaultFormField
    ({
  @required TextEditingController? controller,
  @required TextInputType? type,
   onSubmit,
   onChange,
   onTap,
  bool isPassword = false,
  @required  validate,
  @required String? label,
  @required IconData? prefix,
  IconData? suffix,
   suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted:onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget BuiltArticleItem(article,context)=>InkWell(
  onTap:(){
    navigateTo(context, WebViewScreen(article['url']));
  } ,
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          width: 120,
  
          height: 120,
  
          decoration: BoxDecoration(
  
              borderRadius: BorderRadius.circular(10),
  
              image: DecorationImage(image: NetworkImage(article['urlToImage']==null? 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/450px-No_image_available.svg.png':article['urlToImage']),
  
                  fit: BoxFit.cover)
  
          ),
  
        ),
  
        const SizedBox(width: 20,),
  
        Expanded(
  
          child: Container(
  
            height: 120,
  
            child: Column(mainAxisSize: MainAxisSize.max,
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              children: [
  
                Expanded(child: Text(article['title'],style:Theme.of(context).textTheme.bodyText1,
  
                  maxLines: 4,overflow: TextOverflow.ellipsis,)),
  
                Text(article['publishedAt'],style: TextStyle(fontSize: 16,color: Colors.grey),)
  
  
  
              ],),
  
          ),
  
        )
  
      ],
  
    ),
  
  ),
);

Widget myDivider()=>Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey,
);

Widget ArticleComponent(list,{bool isSearch=false})=>ConditionalBuilder(
  condition:list.length>0 ,
  fallback: (context)=>isSearch? Container() : Center(child: const CircularProgressIndicator()),
  builder:(context)=> ListView.separated(
      physics:BouncingScrollPhysics() ,
      itemBuilder: (context,index)=>BuiltArticleItem(list[index],context),
      separatorBuilder:(context,index) =>myDivider(),
      itemCount:list.length),
);

void navigateTo(context,Widget)=>Navigator.push(
  context,
  MaterialPageRoute(builder: (context)=>Widget),
);