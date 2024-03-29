import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCarousel extends StatelessWidget {

  final List items;
  final Function onTapHandler;
  final Function onPageChanged;
  final bool infiniteScroll;
  
  CustomCarousel({
    this.items, 
    this.onTapHandler, 
    this.onPageChanged,
    this.infiniteScroll = true
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        CarouselSlider.builder(
          itemCount: items.length,
          options: CarouselOptions(
            autoPlay: false,
            viewportFraction: 0.6,
            aspectRatio: 2.75,
            enableInfiniteScroll: this.infiniteScroll,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) => this.onPageChanged(index),
            scrollDirection: Axis.horizontal,
          ),
          itemBuilder: (context, index, realIndex) {
            return InkWell(
              onTap: () => this.onTapHandler(index),
              child: Container(
                width: 200,
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Material(
                    borderRadius: BorderRadius.circular(16),
                    elevation: 8.0,
                    color: items[index].isSelected ? Theme.of(context).primaryColorLight : Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text(
                        items[index].title, 
                        overflow: TextOverflow.ellipsis, 
                        maxLines: 2, 
                        style: TextStyle(
                          fontSize: 16, 
                          color: Colors.black, 
                          fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                      SizedBox(height: 4),
                      Text(
                        items[index].subtitle, 
                        style: TextStyle(color: items[index].isSelected ? Colors.white : Colors.black),
                        textAlign: TextAlign.center)
                    ],),
                  ),
              ),
            );
          },
        ),
      ],)
    );
  }
}