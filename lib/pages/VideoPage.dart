import 'package:flutter/material.dart';
import 'package:future/Library/TextStyle.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Library/AppColors.dart';
import 'drawer.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final String realme = 'https://freshporno.net/channels/brazzers/';
  final String samsung = 'https://sxyprn.com/new.html';
  final String redmi = 'https://www.mi.com/in/';
  final String vivo = 'https://www.vivo.com/in/';
  final String oppo = 'https://www.oppo.com/in/';
  final String iphone = 'https://www.apple.com/in/iphone/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Videos',
          style: FontStyle.textLabelWhite,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 125,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(4),
              children: <Widget>[
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        Uri url = Uri.parse(realme);
                        if (!await launchUrl(url)) {
                          return;
                        }
                      },
                      child: ClipOval(
                        child: Image.network(
                          'https://th.bing.com/th/id/OIP.AB8hwZPk4daxp-POGdzXcQHaEJ?pid=ImgDet&rs=1',
                          fit: BoxFit.cover,
                          height: 70,
                          width: 75,
                        ),
                      ),
                    ),
                    const Text(
                      'Realme',
                      style: FontStyle.primaryLabel,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        Uri url = Uri.parse(samsung);
                        if (!await launchUrl(url)) {
                          return;
                        }
                      },
                      child: ClipOval(
                        child: Image.network(
                          'https://th.bing.com/th/id/OIP.D1cnrBHBkPg_ngtdeNsv2wHaE8?w=257&h=180&c=7&r=0&o=5&dpr=1.38&pid=1.7',
                          fit: BoxFit.cover,
                          height: 70,
                          width: 75,
                        ),
                      ),
                    ),
                    const Text(
                      'Samsung',
                      style: FontStyle.primaryLabel,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        Uri url = Uri.parse(redmi);
                        if (!await launchUrl(url)) {
                          return;
                        }
                      },
                      child: ClipOval(
                        child: Image.network(
                          'https://th.bing.com/th/id/OIP.rHAqVkHIakjOPkNx6H2NPQHaHi?w=187&h=190&c=7&r=0&o=5&dpr=1.38&pid=1.7',
                          fit: BoxFit.cover,
                          height: 70,
                          width: 75,
                        ),
                      ),
                    ),
                    const Text(
                      'Redmi',
                      style: FontStyle.primaryLabel,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        Uri url = Uri.parse(vivo);
                        if (!await launchUrl(url)) {
                          return;
                        }
                      },
                      child: ClipOval(
                        child: Image.network(
                          'https://th.bing.com/th/id/OIP.hasGW_6b9p9q2mxg6itmBgHaH9?w=185&h=199&c=7&r=0&o=5&dpr=1.38&pid=1.7',
                          fit: BoxFit.cover,
                          height: 70,
                          width: 75,
                        ),
                      ),
                    ),
                    const Text(
                      'Vivo',
                      style: FontStyle.primaryLabel,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        Uri url = Uri.parse(oppo);
                        if (!await launchUrl(url)) {
                          return;
                        }
                      },
                      child: ClipOval(
                        child: Image.network(
                          'https://th.bing.com/th/id/OIP.UjPJyegUg6dIMcH7T8-gRgHaHa?w=204&h=204&c=7&r=0&o=5&dpr=1.38&pid=1.7',
                          fit: BoxFit.cover,
                          height: 70,
                          width: 75,
                        ),
                      ),
                    ),
                    const Text(
                      'Oppo',
                      style: FontStyle.primaryLabel,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        Uri url = Uri.parse(iphone);
                        if (!await launchUrl(url)) {
                          return;
                        }
                      },
                      child: ClipOval(
                        child: Image.network(
                          'https://th.bing.com/th/id/OIP.8In5iOliXeddVBNk4tahEAHaFj?w=224&h=180&c=7&r=0&o=5&dpr=1.38&pid=1.7',
                          fit: BoxFit.cover,
                          height: 75,
                          width: 75,
                        ),
                      ),
                    ),
                    const Text(
                      'Iphone',
                      style: FontStyle.primaryLabel,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
