//
//  CGRect.swift
//  Fridge Helper
//
//  Created by Penn on 30/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

extension CGRect {
    static let titleLabelFrame = CGRect(x: CGFloat.width*1/10, y: CGFloat.height*0.13, width: CGFloat.width*0.9, height: CGFloat.height/3)
    
    static let PPFacebookLoginButtonFrame = CGRect(x: CGFloat.PPLoginButtonPositionX, y: CGFloat.PPFacebookLoginButtonPositionY, width: CGFloat.PPLoginButtonWidth, height: CGFloat.PPLoginButtonHeight)
    
    static let PPGoogleLoginButtonFrame = CGRect(x: CGFloat.PPLoginButtonPositionX, y: CGFloat.PPGoogleLoginButtonPositionY, width: CGFloat.PPLoginButtonWidth, height: CGFloat.PPLoginButtonHeight)
    
    static let PPAppleLoginButtonFrame = CGRect(x: CGFloat.PPLoginButtonPositionX, y: CGFloat.PPAppleLoginButtonPositionY, width: CGFloat.PPLoginButtonWidth, height: CGFloat.PPLoginButtonHeight)
    
    static let PPSloganLabelFrame = CGRect(x: CGFloat.PPSloganLabelPositionX, y: CGFloat.PPSloganLabelPositionY, width: CGFloat.PPSloganLabelWidth, height: CGFloat.PPSloganLabelHeight)
    
    static let PPBarButtonFrame = CGRect(x: CGFloat.PPSettingBarButtonPositionX, y: CGFloat.PPSettingBarButtonPositionY, width: CGFloat.PPSettingBarButtonWidth, height: CGFloat.PPSettingBarButtonHeight)
    
    static let PPProfileImageViewFrame = CGRect(x: CGFloat.PPProfileImageViewPositionX, y: CGFloat.PPProfileImageViewPositionY, width: CGFloat.PPProfileImageViewWidth, height: CGFloat.PPProfileImageViewHeight)
    
    static let PPUsernameLabelFrame = CGRect(x: CGFloat.PPUsernameLabelPositionX, y: CGFloat.PPUsernameLabelPositionY, width: CGFloat.PPUsernameLabelWidth, height: CGFloat.PPUsernameLabelHeight)
    
    static let PPCalendarCollectionViewFrame = CGRect(x: CGFloat.PPCalendarCollectionViewPositionX, y: CGFloat.PPCalendarCollectionViewPositionY, width: CGFloat.PPCalendarCollectionViewWidth, height: CGFloat.PPCalendarCollectionViewHeight)
    
    static let PPNotReachableLabelFrame = CGRect(x: CGFloat.PPNotReachableLabelPositionX, y: CGFloat.PPNotReachableLabelPositionY, width: CGFloat.PPNotReachableLabelWidth, height: CGFloat.PPNotReachableLabelHeight)
    
    static let PPFridgeItemCountLabelFrame = CGRect(x: CGFloat.PPFridgeItemCountLabelPositionX, y: CGFloat.PPFridgeItemCountLabelPositionY, width: CGFloat.PPFridgeItemCountLabelWidth, height: CGFloat.PPFridgeItemCountLabelHeight)
    
    static let PPShoppingListCountLabelFrame = CGRect(x: CGFloat.PPShoppingListCountLabelPositionX, y: CGFloat.PPShoppingListCountLabelPositionY, width: CGFloat.PPShoppingListCountLabelWidth, height: CGFloat.PPShoppingListCountLabelHeight)
    
    static let PPRecipeCountLabelFrame = CGRect(x: CGFloat.PPRecipeCountLabelPositionX, y: CGFloat.PPRecipeCountLabelPositionY, width: CGFloat.PPRecipeCountLabelWidth, height: CGFloat.PPRecipeCountLabelHeight)
    
    static let PPPopupViewFrame = CGRect(x: CGFloat.PPPopupViewPositionX, y: CGFloat.PPPopupViewPositionY, width: CGFloat.PPPopupViewWidth, height: CGFloat.PPPopupViewHeight)
    
    static let PPPopupWindowViewFrame = CGRect(x: CGFloat.PPPopupWindowViewPositionX, y: CGFloat.PPPopupWindowViewPositionY, width: CGFloat.PPPopupWindowViewWidth, height: CGFloat.PPPopupWindowViewHeight)
    
    static let PPPopupWindowViewTopLeftCornerButtonFrame = CGRect(x: CGFloat.PPPopupWindowViewTopLeftCornerButtonPositionX, y: CGFloat.PPPopupWindowViewTopLeftCornerButtonPositionY, width: CGFloat.PPPopupWindowViewTopLeftCornerButtonWidth, height: CGFloat.PPPopupWindowViewTopLeftCornerButtonHeight)
    
    static let PPPopupWindowViewTopRightCornerButtonFrame = CGRect(x: CGFloat.PPPopupWindowViewTopRightCornerButtonPositionX, y: CGFloat.PPPopupWindowViewTopRightCornerButtonPositionY, width: CGFloat.PPPopupWindowViewTopRightCornerButtonWidth, height: CGFloat.PPPopupWindowViewTopRightCornerButtonHeight)
    
    static let PPProfilePopupWindowTitleLabelFrame = CGRect(x: CGFloat.PPProfilePopupWindowTitleLabelPositionX, y: CGFloat.PPProfilePopupWindowTitleLabelPositionY, width: CGFloat.PPProfilePopupWindowTitleLabelWidth, height: CGFloat.PPProfilePopupWindowTitleLabelHeight)
    
    static let PPProfilePopupWindowSubtitleLabelFrame = CGRect(x:CGFloat.PPProfilePopupWindowSubtitleLabelPositionX, y: CGFloat.PPProfilePopupWindowSubtitleLabelPositionY, width: CGFloat.PPProfilePopupWindowSubtitleLabelWidth, height: CGFloat.PPProfilePopupWindowSubtitleLabelHeight)
    
    static let PPProfilePopupWindowContenTextViewFrame = CGRect(x:CGFloat.PPProfilePopupWindowContenTextViewPositionX, y: CGFloat.PPProfilePopupWindowContenTextViewPositionY, width: CGFloat.PPProfilePopupWindowContenTextViewWidth, height: CGFloat.PPProfilePopupWindowContenTextViewHeight)
    
    static let PPProfilePopupWindowPreviousButtonFrame = CGRect(x: CGFloat.PPProfilePopupWindowPreviousButtonPositionX, y: CGFloat.PPProfilePopupWindowPreviousButtonPositionY, width: CGFloat.PPProfilePopupWindowPreviousButtonWidth, height: CGFloat.PPProfilePopupWindowPreviousButtonHeight)
    
    static let PPProfilePopupWindowNextButtonFrame = CGRect(x: CGFloat.PPProfilePopupWindowNextButtonPositionX, y: CGFloat.PPProfilePopupWindowNextButtonPositionY, width: CGFloat.PPProfilePopupWindowNextButtonWidth, height: CGFloat.PPProfilePopupWindowNextButtonHeight)
    
    static let PPFridgeItemListCollectionViewFrame = CGRect(x: CGFloat.PPFridgeItemListCollectionViewPositionX, y: CGFloat.PPFridgeItemListCollectionViewPositionY, width: CGFloat.PPFridgeItemListCollectionViewWidth, height: CGFloat.PPFridgeItemListCollectionViewHeight)
    
    static let PPFridgeItemListCellNameLabelFrame = CGRect(x: CGFloat.PPFridgeItemListCellNameLabelPositionX, y: CGFloat.PPFridgeItemListCellNameLabelPositionY, width: CGFloat.PPFridgeItemListCellNameLabelWidth, height: CGFloat.PPFridgeItemListCellNameLabelHeight)
    
    static let PPFridgeItemListCellCategoryLabelFrame = CGRect(x: CGFloat.PPFridgeItemListCellCategoryLabelPositionX, y: CGFloat.PPFridgeItemListCellCategoryLabelPositionY, width: CGFloat.PPFridgeItemListCellCategoryLabelWidth, height: CGFloat.PPFridgeItemListCellCategoryLabelHeight)
    
    static let PPFridgeItemListCellCategoryImageViewFrame = CGRect(x: CGFloat.PPFridgeItemListCellCategoryImageViewPositionX, y: CGFloat.PPFridgeItemListCellCategoryImageViewPositionY, width: CGFloat.PPFridgeItemListCellCategoryImageViewWidth, height: CGFloat.PPFridgeItemListCellCategoryImageViewHeight)
    
    static let PPFridgeItemListCellQuantityLabelFrame = CGRect(x: CGFloat.PPFridgeItemListCellQuantityLabelPositionX , y: CGFloat.PPFridgeItemListCellQuantityLabelPositionY, width: CGFloat.PPFridgeItemListCellQuantityLabelViewWidth, height: CGFloat.PPFridgeItemListCellQuantityLabelViewHeight)
    
    static let PPFridgeItemListCellMinusButtonFrame = CGRect(x: CGFloat.PPFridgeItemListCellMinusButtonPositionX , y: CGFloat.PPFridgeItemListCellMinusButtonPositionY, width: CGFloat.PPFridgeItemListCellMinusButtonWidth, height: CGFloat.PPFridgeItemListCellMinusButtonHeight)
    
    static let PPFridgeItemListCellPlusButtonFrame = CGRect(x: CGFloat.PPFridgeItemListCellPlusButtonPositionX, y: CGFloat.PPFridgeItemListCellPlusButtonPositionY, width: CGFloat.PPFridgeItemListCellPlusButtonWidth, height: CGFloat.PPFridgeItemListCellPlusButtonHeight)
    
    static let PPFridgeItemListCellShoppingCartButtonFrame = CGRect(x: CGFloat.PPFridgeItemListCellShoppingCartButtonPositionX, y: CGFloat.PPFridgeItemListCellShoppingCartButtonPositionY, width: CGFloat.PPFridgeItemListCellShoppingCartButtonWidth, height: CGFloat.PPFridgeItemListCellShoppingCartButtonHeight)
    
    static let PPFridgeListBorderViewFrame = CGRect(x: CGFloat.PPFridgeListBorderViewPositionX, y: CGFloat.PPFridgeListBorderViewPositionY, width: CGFloat.PPFridgeListBorderViewWidth, height: CGFloat.PPFridgeListBorderViewHeight)
        
    static let PPCategoryScrollViewFrame = CGRect(x: CGFloat.PPCategoryScrollViewPositionX, y: CGFloat.PPCategoryScrollViewPositionY, width: CGFloat.PPCategoryScrollViewWidth, height: CGFloat.PPCategoryScrollViewHeight)
    
    static let PPCategoryCollectionViewFrame = CGRect(x: CGFloat.PPCategoryCollectionViewPositionX, y: CGFloat.PPCategoryCollectionViewPositionY, width: CGFloat.PPCategoryCollectionViewWidth, height: CGFloat.PPCategoryCollectionViewHeight)
    
    static let PPCategoryCellImageViewFrame = CGRect(x: CGFloat.PPCategoryCellImageViewPositionX, y: CGFloat.PPCategoryCellImageViewPositionY, width: CGFloat.PPCategoryCellImageViewWidth, height: CGFloat.PPCategoryCellImageViewHeight)
    
    static let PPCategoryCellNameLabelFrame = CGRect(x: CGFloat.PPCategoryCellNameLabelPositionX, y: CGFloat.PPCategoryCellNameLabelPositionY, width: CGFloat.PPCategoryCellNameLabelWidth, height: CGFloat.PPCategoryCellNameLabelHeight)
    
    static let PPCategoryCellCloseButtonFrame = CGRect(x: CGFloat.PPCategoryCellCloseButtonPositionX, y: CGFloat.PPCategoryCellCloseButtonPositionY, width: CGFloat.PPCategoryCellCloseButtonWidth, height: CGFloat.PPCategoryCellCloseButtonHeight)

    static let PPCategoryimageCollectionViewFrame = CGRect(x: CGFloat.PPCategoryimageCollectionViewPositionX, y: CGFloat.PPCategoryimageCollectionViewPositionY, width: CGFloat.PPCategoryimageCollectionViewWidth, height: CGFloat.PPCategoryimageCollectionViewHeight)
    
    static let PPCategoryImageViewOKButtonFrame = CGRect(x: CGFloat.PPCategoryImageViewOKButtonPositionX, y: CGFloat.PPCategoryImageViewOKButtonPositionY, width: CGFloat.PPCategoryImageViewOKButtonWidth, height: CGFloat.PPCategoryImageViewOKButtonHeight)
    
    static let PPCategoryNameTextFieldFrame = CGRect(x: CGFloat.PPCategoryNameTextFieldPositionX, y: CGFloat.PPCategoryNameTextFieldPositionY, width: CGFloat.PPCategoryNameTextFieldWidth, height: CGFloat.PPCategoryNameTextFieldHeight)
    
    static let PPCategoryTextFieldImageViewFrame = CGRect(x: CGFloat.PPCategoryTextFieldImageViewPositionX, y: CGFloat.PPCategoryTextFieldImageViewPositionY, width: CGFloat.PPCategoryTextFieldImageViewWidth, height: CGFloat.PPCategoryTextFieldImageViewHeight)
    
    static let PPCategoryTextFieldWarningLabelFrame = CGRect(x: CGFloat.PPCategoryTextFieldWarningLabelPositionX, y: CGFloat.PPCategoryTextFieldWarningLabelPositionY, width: CGFloat.PPCategoryTextFieldWarningLabelWidth, height: CGFloat.PPCategoryTextFieldWarningLabelHeight)
    
    static let PPFridgeItemPopupWindowScrollViewFrame = CGRect(x: CGFloat.PPFridgeItemPopupWindowScrollViewPositionX, y: CGFloat.PPFridgeItemPopupWindowScrollViewPositionY, width: CGFloat.PPFridgeItemPopupWindowScrollViewWidth, height: CGFloat.PPFridgeItemPopupWindowScrollViewHeight)
    
    static let PPPPFridgeItemPopupWindowNameLabelFrame = CGRect(x: CGFloat.PPFridgeItemPopupWindowNameLabelPositionX, y: CGFloat.PPFridgeItemPopupWindowNameLabelPositionY, width: CGFloat.PPFridgeItemPopupWindowNameLabelWidth, height: CGFloat.PPFridgeItemPopupWindowNameLabelHeight)
    
    static let PPFridgeItemPopupWindowTextFieldFrame = CGRect(x: CGFloat.PPFridgeItemPopupWindowTextFieldPositionX, y: CGFloat.PPFridgeItemPopupWindowTextFieldPositionY, width: CGFloat.PPFridgeItemPopupWindowTextFieldWidth, height: CGFloat.PPFridgeItemPopupWindowTextFieldHeight)
    
    static let PPFridgeItemPopupWindowNameWarningLabelFrame = CGRect(x: CGFloat.PPFridgeItemPopupWindowNameWarningLabelPositionX, y: CGFloat.PPFridgeItemPopupWindowNameWarningLabelPositionY, width: CGFloat.PPFridgeItemPopupWindowNameWarningLabelWidth, height: CGFloat.PPFridgeItemPopupWindowNameWarningLabelHeight)
    
    static let PPScannerCloseButtonFrame = CGRect(x: CGFloat.PPScannerCloseButtonPositionX, y: CGFloat.PPScannerCloseButtonPositionY, width: CGFloat.PPScannerCloseButtonWidth, height: CGFloat.PPScannerCloseButtonHeight)
    
    static let PPScannerFlashlightButtonFrame = CGRect(x: CGFloat.PPScannerFlashlightButtonPositionX, y: CGFloat.PPScannerFlashlightButtonPositionY, width: CGFloat.PPScannerFlashlightButtonWidth, height: CGFloat.PPScannerFlashlightButtonHeight)
    
    static let PPScanningFrameImageViewFrame = CGRect(x: CGFloat.PPScanningFrameImageViewPositionX, y: CGFloat.PPScanningFrameImageViewPositionY, width: CGFloat.PPScanningFrameImageViewWidth, height: CGFloat.PPScanningFrameImageViewHeight)
    
    static let PPScannerSearchButtonFrame = CGRect(x: CGFloat.PPScannerSearchButtonPositionX, y: CGFloat.PPScannerSearchButtonPositionY, width: CGFloat.PPScannerSearchButtonWidth, height: CGFloat.PPScannerSearchButtonHeight)
    
    static let PPScannerAddButtonFrame = CGRect(x: CGFloat.PPScannerAddButtonPositionX, y: CGFloat.PPScannerAddButtonPositionY, width: CGFloat.PPScannerAddButtonWidth, height: CGFloat.PPScannerAddButtonHeight)
    
    static let PPScannerPromptLabelFrame = CGRect(x: CGFloat.PPScannerPromptLabelPositionX, y: CGFloat.PPScannerPromptLabelPositionY, width: CGFloat.PPScannerPromptLabelWidth, height: CGFloat.PPScannerPromptLabelHeight)
    
    static let PPShoppingListCellNameLabelFrame = CGRect(x: CGFloat.PPShoppingListCellNameLabelPositionX, y: CGFloat.PPShoppingListCellNameLabelPositionY, width: CGFloat.PPShoppingListCellNameLabelWidth, height: CGFloat.PPShoppingListCellNameLabelHeight)
    
    static let PPShoppingListCellCategoryImageViewFrame = CGRect(x: CGFloat.PPShoppingListCellCategoryImageViewPositionX, y: CGFloat.PPShoppingListCellCategoryImageViewPositionY, width: CGFloat.PPShoppingListCellCategoryImageViewWidth, height: CGFloat.PPShoppingListCellCategoryImageViewHeight)
    
    static let PPShoppingListCellNeedLabelFrame = CGRect(x: CGFloat.PPShoppingListCellNeedLabelPositionX, y: CGFloat.PPShoppingListCellNeedLabelPositionY, width: CGFloat.PPShoppingListCellNeedLabelWidth, height: CGFloat.PPShoppingListCellNeedLabelHeight)
    
    static let PPShoppingListCellTickButtonFrame = CGRect(x: CGFloat.PPShoppingListCellTickButtonPositionX, y: CGFloat.PPShoppingListCellTickButtonPositionY, width: CGFloat.PPShoppingListCellTickButtonWidth, height: CGFloat.PPShoppingListCellTickButtonHeight)
    
    static let PPShppingListPopupWindowNameTextFieldDropDownScrollViewFrame = CGRect(x: CGFloat.PPShppingListPopupWindowNameTextFieldDropDownScrollViewPositionX, y: CGFloat.PPShppingListPopupWindowNameTextFieldDropDownScrollViewPositionY, width: CGFloat.PPShppingListPopupWindowNameTextFieldDropDownScrollViewWidth, height: CGFloat.PPShppingListPopupWindowNameTextFieldDropDownScrollViewHeight)
    
    static let PPShppingListPopupWindowNameTextFieldDropDownScrollViewLabelFrame = CGRect(x: CGFloat.PPShppingListPopupWindowNameTextFieldDropDownScrollViewLabelPositionX, y: CGFloat.PPShppingListPopupWindowNameTextFieldDropDownScrollViewLabelPositionY, width: CGFloat.PPShppingListPopupWindowNameTextFieldDropDownScrollViewLabelWidth, height: CGFloat.PPShppingListPopupWindowNameTextFieldDropDownScrollViewLabelHeight)
    
    static let PPLogoutButtonFrame = CGRect(x: CGFloat.PPLogoutButtonPositionX, y: CGFloat.PPLogoutButtonPositionY, width: CGFloat.PPLogoutButtonWidth, height: CGFloat.PPLogoutButtonHeight)
    
    static let PPSettingLabelFrame = CGRect(x: CGFloat.PPSettingLabelPositionX, y: CGFloat.PPSettingLabelPositionY, width: CGFloat.PPSettingLabelWidth, height: CGFloat.PPSettingLabelHeight)
    
    static let PPPurchaseViewControllerCrownImageViewFrame = CGRect(x: CGFloat.PPPurchaseViewControllerCrownImageViewPositionX, y: CGFloat.PPPurchaseViewControllerCrownImageViewPositionY, width: CGFloat.PPPurchaseViewControllerCrownImageViewWidth, height: CGFloat.PPPurchaseViewControllerCrownImageViewHeight)
    
    static let PPPurchaseViewControllerLogoImageViewFrame = CGRect(x: CGFloat.PPPurchaseViewControllerLogoImageViewPositionX, y: CGFloat.PPPurchaseViewControllerLogoImageViewPositionY, width: CGFloat.PPPurchaseViewControllerLogoImageViewWidth, height: CGFloat.PPPurchaseViewControllerLogoImageViewHeight)
    
    static let PPPurchaseViewControllerTitleLabelFrame = CGRect(x: CGFloat.PPPurchaseViewControllerTitleLabelPositionX, y: CGFloat.PPPurchaseViewControllerTitleLabelPositionY, width: CGFloat.PPPurchaseViewControllerTitleLabelWidth, height: CGFloat.PPPurchaseViewControllerTitleLabelHeight)
    
    static let PPPurchaseViewControllerBuyButtonFrame = CGRect(x: CGFloat.PPPurchaseViewControllerBuyButtonPositionX, y: CGFloat.PPPurchaseViewControllerBuyButtonPositionY, width: CGFloat.PPPurchaseViewControllerBuyButtonWidth, height: CGFloat.PPPurchaseViewControllerBuyButtonHeight)
    
    static let PPPurchaseViewControllerRestoreLabelFrame = CGRect(x: CGFloat.PPPurchaseViewControllerRestoreLabelPositionX, y: CGFloat.PPPurchaseViewControllerRestoreLabelPositionY, width: CGFloat.PPPurchaseViewControllerRestoreLabelWidth, height: CGFloat.PPPurchaseViewControllerRestoreLabelHeight)
    
    static let PPPurchaseViewControllerTermsLabelFrame = CGRect(x: CGFloat.PPPurchaseViewControllerTermsLabelPositionX, y: CGFloat.PPPurchaseViewControllerTermsLabelPositionY, width: CGFloat.PPPurchaseViewControllerTermsLabelWidth, height: CGFloat.PPPurchaseViewControllerTermsLabelHeight)
    
    static let PPProfileViewGoProButtonFrame = CGRect(x: CGFloat.PPProfileViewGoProButtonPositionX, y: CGFloat.PPProfileViewGoProButtonPositionY, width: CGFloat.PPProfileViewGoProButtonWidth, height: CGFloat.PPProfileViewGoProButtonHeight)
    
    static let PPFridgeListBackgroundImageViewFrame = CGRect(x: CGFloat.PPFridgeListBackgroundImageViewPositionX, y: CGFloat.PPFridgeListBackgroundImageViewPositionY, width: CGFloat.PPFridgeListBackgroundImageViewWidth, height: CGFloat.PPFridgeListBackgroundImageViewHeight)
}
