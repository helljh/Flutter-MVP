import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvp_game/core/ui/font_styles.dart';
import 'package:mvp_game/core/widget/base_app_bar.dart';

class OpenSourceLicenseScreen extends StatelessWidget {
  const OpenSourceLicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        title: '오픈소스 라이선스',
        centerTitle: true,
        leading: GestureDetector(
          onTap: context.pop,
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<List<LicenseEntry>>(
        future: LicenseRegistry.licenses.toList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final licenses = snapshot.data!;
          final licenseMap = <String, List<String>>{};

          for (final license in licenses) {
            for (final package in license.packages) {
              licenseMap
                  .putIfAbsent(package, () => [])
                  .add(license.paragraphs.map((p) => p.text).join('\n'));
            }
          }

          final entries =
              licenseMap.entries.toList()
                ..sort((a, b) => a.key.compareTo(b.key));

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final packageName = entries[index].key;
              final licenseText = entries[index].value.join('\n\n');

              return ExpansionTile(
                title: Text(packageName, style: FontStyles.smallTextRegular),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      licenseText,
                      style: FontStyles.smallerTextRegular,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
