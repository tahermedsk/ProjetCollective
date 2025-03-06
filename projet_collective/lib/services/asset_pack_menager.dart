import 'package:asset_delivery/asset_delivery.dart';
import 'dart:io';

class AssetLoader {
  final bool isMockMode = true;  // Switch to true for dev mode, false for prod mode

  // Fetch the asset pack (either locally or remotely)
  Future<void> loadAssetPack(String assetPackName) async {
    if (isMockMode) {
      // Simulating the loading of assets from the local folder
      print("Mock Mode: Asset Pack '$assetPackName' loaded from local resources.");
    } else {
      // In production, fetch the asset pack from Google Play Asset Delivery
      await AssetDelivery.fetch(assetPackName);
      print("Production Mode: Asset Pack '$assetPackName' fetched.");
    }
  }

  // Get the asset file path
  Future<String?> getAssetPath(
      String assetPackName, int count, String namingPattern, String fileExtension) async {
    if (isMockMode) {
      // In dev mode, load assets directly from local folder
      String localPath = '../packages/$assetPackName/$namingPattern$count$fileExtension';
      print("Mock Mode: Returning local path: $localPath");
      return localPath;
    } else {
      // In production, get the actual path from the downloaded asset pack
      return await AssetDelivery.getAssetPackPath(
        assetPackName: assetPackName,
        count: count,
        namingPattern: namingPattern,
        fileExtension: fileExtension,
      );
    }
  }

  // Get the current state of an asset pack
  Future<void> checkAssetPackState(String assetPackName) async {
    if (isMockMode) {
      // In dev mode, simulate the state
      print("Mock Mode: Checking asset pack '$assetPackName' state.");
    } else {
      // In production, fetch the state of the asset pack
      await AssetDelivery.fetchAssetPackState(assetPackName);
      print("Production Mode: Asset Pack '$assetPackName' state fetched.");
    }
  }

  // Set up listener to monitor asset pack status updates
  void listenToAssetPackStatus(Function(Map<String, dynamic>) onUpdate) {
    if (isMockMode) {
      // In dev mode, simulate asset pack status
      print("Mock Mode: Listening to asset pack status.");
    } else {
      // In production, listen to actual status updates
      AssetDelivery.getAssetPackStatus(onUpdate);
    }
  }
}
