import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sajilo_dokan/domain/model/product_comment.dart';
import 'package:sajilo_dokan/domain/repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';

class ProductDetailsController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  ProductDetailsController(
      {this.apiRepositoryInterface, this.localRepositoryInterface});

  RxInt selectedImage = 0.obs;
  int get index => selectedImage.value;

  RxBool initbool = true.obs;
  RxInt productid = 0.obs;

  var comments = <ProductComment>[].obs;
  RxBool isCommentsLoad = false.obs;

  PhotoViewScaleStateController controllerState;

  @override
  void onReady() async {
    super.onReady();
    controllerState = PhotoViewScaleStateController();
    final token = await localRepositoryInterface.getToken();
    getComments(productid.value, token);
  }

  void goBack() {
    controllerState.scaleState = PhotoViewScaleState.initial;
  }

  void setInit(bool fab) {
    initbool(fab);
  }

  void clickFavorite() {
    initbool(!initbool.value);
  }

  Future<void> makeFavorite(int id) async {
    final token = await localRepositoryInterface.getToken();
    var result = await apiRepositoryInterface.makeFavorite(token, id);
    print('fab btn called');

    if (result == true) {
      clickFavorite();
      Get.snackbar(
          initbool.value
              ? 'Add item to favorit list successfully!'
              : 'Remove from favorite',
          '',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          borderRadius: 0,
          backgroundColor: Colors.black.withOpacity(0.8),
          isDismissible: true,
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(5)
          // animationDuration: Duration(seconds: 1),
          // duration: Duration(seconds: 2),
          );
    }
  }

  Future<void> getComments(int id, String token) async {
    String token = await localRepositoryInterface.getToken();
    isCommentsLoad(true);
    var data = await apiRepositoryInterface.getComments(token, id);
    print(id);
    print('GetComment call');
    print(data);
    if (data != null) {
      comments(data);
    } else {
      comments(null);
    }
    isCommentsLoad(false);
  }

  void likeBtn(int commentId, int productId) async {
    var token = await localRepositoryInterface.getToken();
    print(commentId);
    var result = await apiRepositoryInterface.likeComment(token, commentId);
    print(result);
    if (result == true) {
      await getComments(productId, token);
    }
  }

  void dislikeBtn(int commentId, int productId) async {
    var token = await localRepositoryInterface.getToken();
    print(commentId);
    var result = await apiRepositoryInterface.dislikeComment(token, commentId);
    print(result);
    if (result == true) {
      await getComments(productId, token);
    }
  }
}
