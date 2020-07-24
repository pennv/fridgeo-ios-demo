//
//  CGFloat.swift
//  Fridge Helper
//
//  Created by Penn on 24/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

extension CGFloat {
    
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    
    // PPButton properties
    static let PPButtonBorderWidth = CGFloat(1)
    static let PPButtonFontSize = CGFloat(15)
    // PPLoginButton properties
    static let PPLoginButtonPositionX = width*1/10
    static let PPFacebookLoginButtonPositionY = height*0.48
    static let PPGoogleLoginButtonPositionY = height*0.58
    static let PPAppleLoginButtonPositionY = height*0.68
    static let PPLoginButtonWidth = width*0.8
    static let PPLoginButtonHeight = height/15
    static let PPLoginButtonCornerRadius = height*0.033
    
    // PPSloganLabel properties
    static let PPSloganLabelPositionX = width*1/10
    static let PPSloganLabelPositionY = height*0.05
    static let PPSloganLabelWidth = width*0.9
    static let PPSloganLabelHeight = height/3
    
    // PPSpinner properties
    static let PPSpinnerPositionX = width/2
    static let PPSpinnerPositionY = height*0.36
    
    // PPBarButton properties
    static let PPSettingBarButtonPositionX = CGFloat(0)
    static let PPSettingBarButtonPositionY = CGFloat(0)
    static let PPSettingBarButtonWidth = CGFloat(50)
    static let PPSettingBarButtonHeight = CGFloat(0)
    
    // PPSettingBarButton properties
    static let PPSettingBarButtonImageSize = width*0.07
    
    // PPCloseBarButton properties
    static let PPCloseBarButtonImageSize = width*0.05
    
    // PPProfileImageView properties
    static let PPProfileImageViewWidth = width/4.5
    static let PPProfileImageViewPositionY = height/70
    static let PPProfileImageViewHeight = PPProfileImageViewWidth
    static let PPProfileImageViewPositionX = (width - PPProfileImageViewWidth)*0.9
    static let PPProfileImageViewCornerRadius = PPProfileImageViewHeight/2
    
    // PPUsernameLabel properties
    static let PPUsernameLabelPositionX = width - (PPProfileImageViewPositionX + PPProfileImageViewWidth)
    static let PPUsernameLabelWidth = (width - PPUsernameLabelPositionX*3 - PPProfileImageViewWidth)
    static let PPUsernameLabelHeight = PPProfileImageViewHeight
    static let PPUsernameLabelPositionY = PPProfileImageViewPositionY
    
    // PPCalendarCollectionView properties
    static let PPCalendarCollectionViewPositionX = width*0.05
    static let PPCalendarCollectionViewPositionY = height/2.9
    static let PPCalendarCollectionViewWidth = width*0.9
    static let PPCalendarCollectionViewHeight = width/7*5.65
    static let PPCalendarCollectionViewCornerRadius = height/40
    
    // PPNotReachableLabel properties
    static let PPNotReachableLabelPositionX = width*0.1
    static let PPNotReachableLabelPositionY = height*0.3
    static let PPNotReachableLabelWidth = width*0.8
    static let PPNotReachableLabelHeight = height/3
    
    // PPFridgeItemCountLabel properties
    static let PPFridgeItemCountLabelPositionX = width*0.05
    static let PPFridgeItemCountLabelPositionY = height*0.21
    static let PPFridgeItemCountLabelWidth = width*0.3
    static let PPFridgeItemCountLabelHeight = height/10
    
    // PPShoppingListCountLabel properties
    static let PPShoppingListCountLabelPositionX = width*0.05 + PPFridgeItemCountLabelWidth
    static let PPShoppingListCountLabelPositionY = PPFridgeItemCountLabelPositionY
    static let PPShoppingListCountLabelWidth = PPFridgeItemCountLabelWidth
    static let PPShoppingListCountLabelHeight = PPFridgeItemCountLabelHeight
    
    // PPRecipeCountLabel properties
    static let PPRecipeCountLabelPositionX = width*0.05 + PPFridgeItemCountLabelWidth + PPShoppingListCountLabelWidth
    static let PPRecipeCountLabelPositionY = PPFridgeItemCountLabelPositionY
    static let PPRecipeCountLabelWidth = PPFridgeItemCountLabelWidth
    static let PPRecipeCountLabelHeight = PPFridgeItemCountLabelHeight
    
    // PPPopupView properties
    static let PPPopupViewPositionX = CGFloat(0)
    static let PPPopupViewPositionY = CGFloat(0)
    static let PPPopupViewWidth = width
    static let PPPopupViewHeight = height
    
    // PPPopupWindowView properties
    static let PPPopupWindowViewPositionX = width*0.05
    static let PPPopupWindowViewPositionY = height/4
    static let PPPopupWindowViewWidth = width*0.9
    static let PPPopupWindowViewHeight = height/2
    static let PPPopupWindowViewCornerRadius = height/40
    static let PPPopupWindowViewShadowOpacity = Float(0.23)
    
    // PPPopupWindowViewTopLeftCornerButton properties
    static let PPPopupWindowViewTopLeftCornerButtonPositionX = CGFloat(0)
    static let PPPopupWindowViewTopLeftCornerButtonPositionY = CGFloat(0)
    static let PPPopupWindowViewTopLeftCornerButtonWidth = PPPopupWindowViewWidth/7
    static let PPPopupWindowViewTopLeftCornerButtonHeight = PPPopupWindowViewTopLeftCornerButtonWidth
    static let PPPopupWindowViewTopLeftCornerButtonImageSize = PPPopupWindowViewWidth/16
    
    // PPPopupWindowViewRightCornerButton properties
    static let PPPopupWindowViewTopRightCornerButtonPositionX = PPPopupWindowViewWidth - PPPopupWindowViewTopRightCornerButtonWidth
    static let PPPopupWindowViewTopRightCornerButtonPositionY = CGFloat(0)
    static let PPPopupWindowViewTopRightCornerButtonWidth = PPPopupWindowViewWidth/7
    static let PPPopupWindowViewTopRightCornerButtonHeight = PPPopupWindowViewTopRightCornerButtonWidth
    static let PPPopupWindowViewTopRightCornerButtonImageSize = PPPopupWindowViewWidth/16
    
    // PPProfilePopupWindowTitleLabel properties
    static let PPProfilePopupWindowTitleLabelWidth = PPPopupWindowViewWidth*0.8
    static let PPProfilePopupWindowTitleLabelHeight = PPPopupWindowViewHeight/10
    static let PPProfilePopupWindowTitleLabelPositionX = PPPopupWindowViewWidth*0.1
    static let PPProfilePopupWindowTitleLabelPositionY = PPPopupWindowViewHeight/25
    
    // PPProfilePopupWindowSubtitleLabel properties
    static let PPProfilePopupWindowSubtitleLabelWidth = PPProfilePopupWindowTitleLabelWidth
    static let PPProfilePopupWindowSubtitleLabelHeight = PPProfilePopupWindowTitleLabelHeight
    static let PPProfilePopupWindowSubtitleLabelPositionX = PPPopupWindowViewWidth*0.1
    static let PPProfilePopupWindowSubtitleLabelPositionY = PPProfilePopupWindowTitleLabelPositionY + PPProfilePopupWindowTitleLabelHeight/1.4
    
    // PPProfilePopupWindowContenTextView
    static let PPProfilePopupWindowContenTextViewWidth = PPProfilePopupWindowTitleLabelWidth
    static let PPProfilePopupWindowContenTextViewHeight = (PPPopupWindowViewHeight - PPProfilePopupWindowSubtitleLabelPositionY - PPProfilePopupWindowSubtitleLabelHeight)*0.75
    static let PPProfilePopupWindowContenTextViewPositionX = PPPopupWindowViewWidth*0.1
    static let PPProfilePopupWindowContenTextViewPositionY = (PPProfilePopupWindowSubtitleLabelPositionY + PPProfilePopupWindowSubtitleLabelHeight)*1.1
    
    // PPProfilePopupWindowPreviousButton properties
    static let PPProfilePopupWindowPreviousButtonPositionX = PPPopupWindowViewWidth*0.1
    static let PPProfilePopupWindowPreviousButtonPositionY = (PPProfilePopupWindowContenTextViewHeight + PPProfilePopupWindowContenTextViewPositionY)*1.02
    static let PPProfilePopupWindowPreviousButtonWidth = PPPopupWindowViewWidth*0.35
    static let PPProfilePopupWindowPreviousButtonHeight = height/20
    
    // PPProfilePopupWindowNextButton properties
    static let PPProfilePopupWindowNextButtonPositionX = PPPopupWindowViewWidth*0.55
    static let PPProfilePopupWindowNextButtonPositionY = (PPProfilePopupWindowContenTextViewHeight + PPProfilePopupWindowContenTextViewPositionY)*1.02
    static let PPProfilePopupWindowNextButtonWidth = PPPopupWindowViewWidth*0.35
    static let PPProfilePopupWindowNextButtonHeight = height/20
    
    // PPProfilePopupWindowButton properties
    static let PPProfilePopupWindowButtonCornerRadius = PPProfilePopupWindowPreviousButtonHeight*0.5
    static let PPProfilePopupWindowButtonFontSize = CGFloat(20)
    
    
    
    
    
    // PPSearchBar properties
    static let PPSearchBarCornerRadius = CGFloat(18)
    
    // PPCategoryScrollView properties
    static let PPCategoryScrollViewWidth = width
    static let PPCategoryScrollViewHeight = height/24
    static let PPCategoryScrollViewPositionX = CGFloat(0)
    static let PPCategoryScrollViewPositionY = PPCategoryScrollViewHeight/15
    static let PPCategoryScrollViewContentWidth = CGFloat.PPFridgeItemListCollectionViewWidth*0.05
    
    // PPCategoryButton properties
    static let PPCategoryButtonHeight = PPCategoryScrollViewHeight
    static let PPCategoryButtonFontSize = CGFloat(15)
    static let PPCategoryButtonCornerRadius = PPCategoryButtonHeight*0.5
    static let PPCategoryButtonMinimumWidth = CGFloat.width/7
    static let PPCategoryButtonWidthFactor = CGFloat(1.2)
    
    // PPFridgeItemListCollectionView properties
    static let PPFridgeItemListCollectionViewPositionX = width*0.05
    static let PPFridgeItemListCollectionViewPositionY = (PPCategoryScrollViewHeight + PPCategoryScrollViewPositionY)*1.2
    static let PPFridgeItemListCollectionViewWidth = width*0.95
    static let PPFridgeItemListCollectionViewHeight = height
    static let PPFridgeItemListCollectionViewLineSpacing = CGFloat(20)
    static let PPFridgeItemListCollectionViewBottomDistance = height/4.5
    static let PPFridgeItemListCollectionViewTopDistance = height/65
    static let PPFridgeItemListCollectionViewSearchResultPositionY = PPFridgeItemListCollectionViewTopDistance
    
    // FridgeItem cell properties
    static let FridgeItemCellWidth = width*0.9
    static let FridgeItemCellHeight = PPFridgeItemListCollectionViewHeight/8
    static let FridgeItemCellPositionX = CGFloat(0)
    static let FridgeItemCellCornerRadius = width/30
    static let FridgeItemCellShadowOpacity = Float(0.06)

    // PPFridgeItemListCellShoppingCartButton properties
    static let PPFridgeItemListCellShoppingCartButtonPositionX = FridgeItemCellWidth/23
    static let PPFridgeItemListCellShoppingCartButtonPositionY = FridgeItemCellHeight/3.6
    static let PPFridgeItemListCellShoppingCartButtonWidth = PPFridgeItemListCellMinusButtonWidth
    static let PPFridgeItemListCellShoppingCartButtonHeight = PPFridgeItemListCellMinusButtonWidth
    static let PPFridgeItemListCellShoppingCartButtonImageSize = PPFridgeItemListCellQuantityLabelViewWidth/3.5
    
    // PPFridgeItemListCellNameLabel properties
    static let PPFridgeItemListCellNameLabelPositionX = FridgeItemCellWidth/5
    static let PPFridgeItemListCellNameLabelPositionY = FridgeItemCellHeight/5.5
    static let PPFridgeItemListCellNameLabelWidth = FridgeItemCellWidth*0.87 - PPFridgeItemListCellShoppingCartButtonImageSize - PPFridgeItemListCellShoppingCartButtonPositionX - PPFridgeItemListCellNameLabelPositionX
    static let PPFridgeItemListCellNameLabelHeight = FridgeItemCellHeight/4.2
    
    // PPFridgeItemListCellCategoryLabel properties
    static let PPFridgeItemListCellCategoryLabelPositionX = PPFridgeItemListCellNameLabelPositionX
    static let PPFridgeItemListCellCategoryLabelPositionY = (PPFridgeItemListCellNameLabelPositionY + PPFridgeItemListCellNameLabelHeight)*1.3
    static let PPFridgeItemListCellCategoryLabelWidth = FridgeItemCellWidth*0.2
    static let PPFridgeItemListCellCategoryLabelHeight = FridgeItemCellHeight/3
    
    // PPFridgeItemListCellCategoryImageView properties
    static let PPFridgeItemListCellCategoryImageViewPositionX = PPFridgeItemListCellCategoryLabelPositionX + PPFridgeItemListCellCategoryLabelWidth
    static let PPFridgeItemListCellCategoryImageViewPositionY = PPFridgeItemListCellCategoryLabelPositionY + PPFridgeItemListCellCategoryLabelHeight*0.3
    static let PPFridgeItemListCellCategoryImageViewWidth = FridgeItemCellWidth/17
    static let PPFridgeItemListCellCategoryImageViewHeight = PPFridgeItemListCellCategoryImageViewWidth
    
    // PPFridgeItemListCellQuantityLabel properties
    static let PPFridgeItemListCellQuantityLabelPositionX = FridgeItemCellWidth/4*3
    static let PPFridgeItemListCellQuantityLabelPositionY = FridgeItemCellHeight/4
    static let PPFridgeItemListCellQuantityLabelViewWidth = FridgeItemCellWidth/4
    static let PPFridgeItemListCellQuantityLabelViewHeight = FridgeItemCellHeight/2
    
    // PPFridgeItemListCellPlusButton properties
    static let PPFridgeItemListCellPlusButtonPositionX = PPFridgeItemListCellQuantityLabelPositionX + PPFridgeItemListCellQuantityLabelViewWidth/2 - PPFridgeItemListCellPlusButtonWidth/2
    static let PPFridgeItemListCellPlusButtonPositionY = CGFloat(0)
    static let PPFridgeItemListCellPlusButtonHeight = FridgeItemCellHeight*0.4
    static let PPFridgeItemListCellPlusButtonWidth = PPFridgeItemListCellPlusButtonHeight
    static let PPFridgeItemListCellPlusButtonImageSize = PPFridgeItemListCellPlusButtonHeight/3
    
    // PPFridgeItemListCellMinusButton properties
    static let PPFridgeItemListCellMinusButtonPositionX = PPFridgeItemListCellPlusButtonPositionX
    static let PPFridgeItemListCellMinusButtonPositionY = FridgeItemCellHeight - PPFridgeItemListCellPlusButtonHeight
    static let PPFridgeItemListCellMinusButtonWidth = PPFridgeItemListCellPlusButtonWidth
    static let PPFridgeItemListCellMinusButtonHeight = PPFridgeItemListCellMinusButtonWidth
    static let PPFridgeItemListCellMinusButtonImageSize = PPFridgeItemListCellPlusButtonImageSize
    
    // PPFridgeListBorderView properties
    static let PPFridgeListBorderViewWidth = FridgeItemCellWidth/60
    static let PPFridgeListBorderViewHeight = FridgeItemCellHeight*0.5
    static let PPFridgeListBorderViewPositionX = CGFloat(0)
    static let PPFridgeListBorderViewPositionY = FridgeItemCellHeight*0.25
    static let PPFridgeListBorderViewCornerRadius = PPFridgeListBorderViewHeight/6.8
    
    
    
    
    
    // PPCategoryCollectionView properties
    static let PPCategoryCollectionViewPositionX = CGFloat(0)
    static let PPCategoryCollectionViewPositionY = PPPopupWindowViewHeight*0.2
    static let PPCategoryCollectionViewWidth = PPPopupWindowViewWidth
    static let PPCategoryCollectionViewHeight = PPPopupWindowViewHeight*0.6
    static let PPCategoryCollectionViewCellHeight = PPPopupWindowViewHeight*0.15
    
    // PPCategoryCellImageView properties
    static let PPCategoryCellImageViewPositionX = PPCategoryCollectionViewHeight*0.1
    static let PPCategoryCellImageViewPositionY = PPCategoryCollectionViewCellHeight*0.25
    static let PPCategoryCellImageViewHeight = PPCategoryCollectionViewCellHeight*0.5
    static let PPCategoryCellImageViewWidth = PPCategoryCellImageViewHeight
    
    // PPCategoryCellNameLabel properties
    static let PPCategoryCellNameLabelPositionX = (PPCategoryCellImageViewPositionX + PPCategoryCellImageViewWidth)*1.5
    static let PPCategoryCellNameLabelWidth = PPCategoryCollectionViewWidth*0.5
    static let PPCategoryCellNameLabelHeight = PPCategoryCollectionViewCellHeight*0.6
    static let PPCategoryCellNameLabelPositionY = PPCategoryCollectionViewCellHeight*0.2
    
    // PPCategoryCellCloseButton properties
    static let PPCategoryCellCloseButtonPositionX = PPCategoryCollectionViewWidth*0.8
    static let PPCategoryCellCloseButtonPositionY = PPCategoryCollectionViewCellHeight*0.25
    static let PPCategoryCellCloseButtonHeight = PPCategoryCollectionViewCellHeight*0.6
    static let PPCategoryCellCloseButtonWidth = PPCategoryCellCloseButtonHeight
    static let PPCategoryCellCloseButtonImageWidth = PPCategoryCollectionViewCellHeight*0.3
    
    
    
    
    
    
    // PPCategoryNameTextField properties
    static let PPCategoryNameTextFieldPositionX = (PPCategoryTextFieldImageViewPositionX + PPCategoryTextFieldImageViewWidth)*1.2
    static let PPCategoryNameTextFieldPositionY = PPFridgeItemListCellCategoryLabelPositionY*1.4
    static let PPCategoryNameTextFieldWidth = PPPopupWindowViewWidth*0.68
    static let PPCategoryNameTextFieldHeight = height/20
    
    // PPCategoryTextFieldImageView properties
    static let PPCategoryTextFieldImageViewPositionX = PPPopupWindowViewWidth*0.08
    static let PPCategoryTextFieldImageViewPositionY = PPCategoryNameTextFieldPositionY*1.15
    static let PPCategoryTextFieldImageViewWidth = PPCategoryNameTextFieldHeight*0.6
    static let PPCategoryTextFieldImageViewHeight = PPCategoryTextFieldImageViewWidth
    
    // PPCategoryTextFieldWarningLabel properties
    static let PPCategoryTextFieldWarningLabelPositionX = PPCategoryNameTextFieldPositionX
    static let PPCategoryTextFieldWarningLabelPositionY = PPCategoryNameTextFieldPositionY + PPCategoryNameTextFieldHeight
    static let PPCategoryTextFieldWarningLabelWidth = PPCategoryNameTextFieldWidth
    static let PPCategoryTextFieldWarningLabelHeight = height/40
    
    // PPCategoryimageCollectionView properties
    static let PPCategoryimageCollectionViewPositionX = PPPopupWindowViewWidth*0.05
    static let PPCategoryimageCollectionViewPositionY = PPPopupWindowViewHeight*0.36
    static let PPCategoryimageCollectionViewWidth = PPPopupWindowViewWidth*0.9
    static let PPCategoryimageCollectionViewHeight = PPPopupWindowViewHeight*0.44
    static let PPCategoryimageCollectionViewCellHeight = PPPopupWindowViewHeight*0.08
    static let PPCategoryimageCollectionViewCellWidth = PPCategoryimageCollectionViewCellHeight
    
    // PPCategoryImageViewOKButton properties
    static let PPCategoryImageViewOKButtonPositionX = (PPPopupWindowViewWidth - PPCategoryImageViewOKButtonWidth)/2
    static let PPCategoryImageViewOKButtonPositionY = (PPProfilePopupWindowContenTextViewHeight + PPProfilePopupWindowContenTextViewPositionY)*1.02
    static let PPCategoryImageViewOKButtonWidth = PPPopupWindowViewWidth*0.35
    static let PPCategoryImageViewOKButtonHeight = height/20
    
    
    
    
    
    // PPFridgeItemPopupWindowScrollView properties
    static let PPFridgeItemPopupWindowScrollViewPositionX = CGFloat(0)
    static let PPFridgeItemPopupWindowScrollViewPositionY = PPPopupWindowViewHeight*0.2
    static let PPFridgeItemPopupWindowScrollViewWidth = PPPopupWindowViewWidth
    static let PPFridgeItemPopupWindowScrollViewHeight = PPPopupWindowViewHeight*0.6
    
    // PPFridgeItemPopupWindowNameLabel properties
    static let PPFridgeItemPopupWindowNameLabelPositionX = PPPopupWindowViewWidth*0.1
    static let PPFridgeItemPopupWindowNameLabelPositionY = CGFloat(0)
    static let PPFridgeItemPopupWindowNameLabelWidth = PPFridgeItemPopupWindowScrollViewWidth*0.8
    static let PPFridgeItemPopupWindowNameLabelHeight = PPPopupWindowViewHeight/20
    
    // PPFridgeItemPopupWindowTextField property
    static let PPFridgeItemPopupWindowTextFieldPositionX = PPFridgeItemPopupWindowNameLabelPositionX
    static let PPFridgeItemPopupWindowTextFieldPositionY = PPFridgeItemPopupWindowNameLabelPositionY + PPPopupWindowViewHeight/15
    static let PPFridgeItemPopupWindowTextFieldWidth = PPFridgeItemPopupWindowScrollViewWidth*0.8
    static let PPFridgeItemPopupWindowTextFieldHeight = PPPopupWindowViewHeight/18
    
    // Name warning label
    static let PPFridgeItemPopupWindowNameWarningLabelPositionX = PPFridgeItemPopupWindowNameLabelPositionX
    static let PPFridgeItemPopupWindowNameWarningLabelPositionY = PPFridgeItemPopupWindowTextFieldPositionY + PPFridgeItemPopupWindowTextFieldHeight
    static let PPFridgeItemPopupWindowNameWarningLabelWidth = PPFridgeItemPopupWindowScrollViewWidth*0.8
    static let PPFridgeItemPopupWindowNameWarningLabelHeight = height/40
    
    // Quantity label
    static let PPFridgeItemPopupWindowQuantityLabelPositionY = PPFridgeItemPopupWindowTextFieldPositionY + PPPopupWindowViewHeight/8
    
    // Quantity textfield
    static let PPFridgeItemPopupWindowQuantityTextFieldPositionY = PPFridgeItemPopupWindowQuantityLabelPositionY + PPPopupWindowViewHeight/15
    
    // Quantity warning label
    static let PPFridgeItemPopupWindowQuantityWarningLabelPositionY = PPFridgeItemPopupWindowQuantityTextFieldPositionY + PPFridgeItemPopupWindowTextFieldHeight
    
    // Category label
    static let PPFridgeItemPopupWindowCategoryLabelPositionY = PPFridgeItemPopupWindowQuantityTextFieldPositionY +  PPPopupWindowViewHeight/8
    
    // Category textfield
    static let PPFridgeItemPopupWindowCategoryTextFieldPositionY = PPFridgeItemPopupWindowCategoryLabelPositionY + PPPopupWindowViewHeight/15
    
    // Category warning label
    static let PPFridgeItemPopupWindowCategoryWarningLabelPositionY = PPFridgeItemPopupWindowCategoryTextFieldPositionY + PPFridgeItemPopupWindowTextFieldHeight
    
    // Date label
    static let PPFridgeItemPopupWindowDateLabelPositionY = PPFridgeItemPopupWindowCategoryTextFieldPositionY +  PPPopupWindowViewHeight/8
    
    // Date textfield
    static let PPFridgeItemPopupWindowDateTextFieldPositionY = PPFridgeItemPopupWindowDateLabelPositionY + PPPopupWindowViewHeight/15
    
    // Date warning label
    static let PPFridgeItemPopupWindowDateWarningLabelPositionY = PPFridgeItemPopupWindowDateTextFieldPositionY + PPFridgeItemPopupWindowTextFieldHeight
    
    // Barcode label
    static let PPFridgeItemPopupWindowBarcodeLabelPositionY = PPFridgeItemPopupWindowDateTextFieldPositionY +  PPPopupWindowViewHeight/8
    
    // Barcode textfield
    static let PPFridgeItemPopupWindowBarcodeTextFieldPositionY = PPFridgeItemPopupWindowBarcodeLabelPositionY +  PPPopupWindowViewHeight/15
    
    // Barcode warning label
    static let PPFridgeItemPopupWindowBarcodeWarningLabelPositionY = PPFridgeItemPopupWindowBarcodeTextFieldPositionY + PPFridgeItemPopupWindowTextFieldHeight
    
    // Note label
    static let PPFridgeItemPopupWindowNoteLabelPositionY = PPFridgeItemPopupWindowBarcodeTextFieldPositionY +  PPPopupWindowViewHeight/8
    
    // Note textfield
    static let PPFridgeItemPopupWindowNoteTextFieldPositionY = PPFridgeItemPopupWindowNoteLabelPositionY +  PPPopupWindowViewHeight/15
    static let PPFridgeItemPopupWindowNoteTextFieldHeight = PPPopupWindowViewHeight/5
    
    // Note warning label
    static let PPFridgeItemPopupWindowNoteWarningLabelPositionY = PPFridgeItemPopupWindowNoteTextFieldPositionY + PPFridgeItemPopupWindowNoteTextFieldHeight
    
    
    
    
    // PPScannerCloseButton properties
    static let PPScannerCloseButtonPositionX = width*0.05
    static let PPScannerCloseButtonPositionY = PPScannerCloseButtonPositionX*3
    static let PPScannerCloseButtonHeight = height/20
    static let PPScannerCloseButtonWidth = PPScannerCloseButtonHeight
    static let PPScannerCloseButtonImageSize = width*0.07
    
    // PPScanningFrameImageView properties
    static let PPScanningFrameImageViewPositionX = width*0.15
    static let PPScanningFrameImageViewPositionY = height*0.25
    static let PPScanningFrameImageViewHeight = height*0.35
    static let PPScanningFrameImageViewWidth = width*0.7
    
    // PPScannerFlashlightButton properties
    static let PPScannerFlashlightButtonPositionX = width/2 - PPScannerFlashlightButtonWidth/2
    static let PPScannerFlashlightButtonPositionY = (PPScanningFrameImageViewPositionY + PPScanningFrameImageViewHeight)*0.85
    static let PPScannerFlashlightButtonHeight = height/20
    static let PPScannerFlashlightButtonWidth = PPScannerCloseButtonHeight
    static let PPScannerFlashlightButtonImageSize = width*0.07
    
    // PPScannerSearchButton properties
    static let PPScannerSearchButtonPositionX = width*0.3
    static let PPScannerSearchButtonPositionY = height*0.8
    static let PPScannerSearchButtonWidth = width*0.2
    static let PPScannerSearchButtonHeight = PPScannerSearchButtonWidth*0.55
    static let PPScannerSearchButtonImageSize = width*0.06
    static let PPScannerSearchButtonCornerRadius = PPScannerSearchButtonHeight/2
    
    // PPScannerAddButton properties
    static let PPScannerAddButtonPositionX = (PPScannerSearchButtonPositionX + PPScannerSearchButtonWidth)*0.999
    static let PPScannerAddButtonPositionY = PPScannerSearchButtonPositionY
    static let PPScannerAddButtonWidth = PPScannerSearchButtonWidth
    static let PPScannerAddButtonHeight = PPScannerSearchButtonHeight
    static let PPScannerAddButtonImageSize = PPScannerSearchButtonImageSize
    static let PPScannerAddButtonCorcerRadius = PPScannerSearchButtonCornerRadius
    
    // PPScannerPromptLabel properties
    static let PPScannerPromptLabelPositionX = width/3
    static let PPScannerPromptLabelPositionY = height*0.71
    static let PPScannerPromptLabelWidth = width/3
    static let PPScannerPromptLabelHeight = height*0.04
    static let PPScannerPromptLabelCorcerRadius = PPScannerPromptLabelHeight/2
    
    
    
    
    
    
    // PPShoppingListCellCategoryImageView
    static let PPShoppingListCellCategoryImageViewPositionX = FridgeItemCellWidth/20
    static let PPShoppingListCellCategoryImageViewPositionY = FridgeItemCellHeight/4 - PPShoppingListCellCategoryImageViewHeight/2
    static let PPShoppingListCellCategoryImageViewWidth = FridgeItemCellWidth/17
    static let PPShoppingListCellCategoryImageViewHeight = PPShoppingListCellCategoryImageViewWidth
    
    // PPShoppingListCellNameLabel
    static let PPShoppingListCellNameLabelPositionX = PPShoppingListCellCategoryImageViewPositionX + PPShoppingListCellCategoryImageViewWidth + FridgeItemCellWidth/20
    static let PPShoppingListCellNameLabelPositionY = FridgeItemCellHeight/4 - PPShoppingListCellNameLabelHeight/2
    static let PPShoppingListCellNameLabelWidth = FridgeItemCellWidth*0.45
    static let PPShoppingListCellNameLabelHeight = FridgeItemCellHeight/4.2
    
    // PPShoppingListCellNeedLabel
    static let PPShoppingListCellNeedLabelPositionX = PPShoppingListCellNameLabelPositionX + PPShoppingListCellNameLabelWidth + FridgeItemCellWidth/20
    static let PPShoppingListCellNeedLabelPositionY = FridgeItemCellHeight/4 - PPShoppingListCellNeedLabelHeight/2
    static let PPShoppingListCellNeedLabelWidth = FridgeItemCellWidth*0.2
    static let PPShoppingListCellNeedLabelHeight = FridgeItemCellHeight/4.2
    
    // PPShoppingListCellTickButton
    static let PPShoppingListCellTickButtonPositionX = PPShoppingListCellNeedLabelPositionX + PPShoppingListCellNeedLabelWidth + (FridgeItemCellWidth - PPShoppingListCellNeedLabelPositionX - PPShoppingListCellNeedLabelWidth)/2 - PPShoppingListCellTickButtonWidth/2
    static let PPShoppingListCellTickButtonPositionY = FridgeItemCellHeight/4 - PPShoppingListCellTickButtonHeight/2
    static let PPShoppingListCellTickButtonWidth = FridgeItemCellHeight/2
    static let PPShoppingListCellTickButtonHeight = PPShoppingListCellTickButtonWidth
    static let PPShoppingListCellTickButtonImageWidth = FridgeItemCellHeight*0.20
    
    // PPShppingListPopupWindowNameTextFieldDropDownScrollView
    static let PPShppingListPopupWindowNameTextFieldDropDownScrollViewPositionX = PPFridgeItemPopupWindowTextFieldPositionX
    static let PPShppingListPopupWindowNameTextFieldDropDownScrollViewPositionY = PPFridgeItemPopupWindowTextFieldPositionY + PPFridgeItemPopupWindowTextFieldHeight
    static let PPShppingListPopupWindowNameTextFieldDropDownScrollViewWidth = PPFridgeItemPopupWindowTextFieldWidth
    static let PPShppingListPopupWindowNameTextFieldDropDownScrollViewHeight = height/6
    
    // PPShppingListPopupWindowNameTextFieldDropDownScrollViewLabel
    static let PPShppingListPopupWindowNameTextFieldDropDownScrollViewLabelPositionX = CGFloat(0)
    static let PPShppingListPopupWindowNameTextFieldDropDownScrollViewLabelPositionY = CGFloat(0)
    static let PPShppingListPopupWindowNameTextFieldDropDownScrollViewLabelWidth = PPShppingListPopupWindowNameTextFieldDropDownScrollViewWidth
    static let PPShppingListPopupWindowNameTextFieldDropDownScrollViewLabelHeight = PPShppingListPopupWindowNameTextFieldDropDownScrollViewHeight/3.5
    
    

    
    
    
    // PPLogoutButton button
    static let PPLogoutButtonPositionX = (width - PPLogoutButtonWidth)/2
    static let PPLogoutButtonPositionY = height/1.5
    static let PPLogoutButtonWidth = width/3
    static let PPLogoutButtonHeight = height/20
    
    // PPSettingLabel
    static let PPSettingLabelPositionX = width*0.07
    static let PPSettingLabelPositionY = height*0.03
    static let PPSettingLabelWidth = width
    static let PPSettingLabelHeight = height/11
    static let PPSettingLabelFontSize = CGFloat(22)
    
    // PPSettingMoveToShoppingListLabel
    static let PPSettingHideItemLabelPositionY = PPSettingLabelPositionY + PPSettingLabelHeight
    
    // PPSettingContactLabel
    static let PPSettingContactLabelPositionY = PPSettingHideItemLabelPositionY + PPSettingLabelHeight
    
    // PPSettingTermsLabel
    static let PPSettingTermsLabelPositionY = PPSettingContactLabelPositionY + PPSettingLabelHeight
    
    // PPSettingPrivacyLabel
    static let PPSettingPrivacyLabelPositionY = PPSettingTermsLabelPositionY + PPSettingLabelHeight
    
    // PPSettingPrivacyLabel
    static let PPSetingAttributionLabelPositionY = PPSettingPrivacyLabelPositionY + PPSettingLabelHeight
    
    
    
    
    
    // PPPurchaseViewControllerCrownImageView
    static let PPPurchaseViewControllerCrownImageViewPositionX = (width - PPPurchaseViewControllerCrownImageViewWidth)/2
    static let PPPurchaseViewControllerCrownImageViewPositionY = height*0.08
    static let PPPurchaseViewControllerCrownImageViewWidth = width*0.1
    static let PPPurchaseViewControllerCrownImageViewHeight = PPPurchaseViewControllerCrownImageViewWidth
    
    // PPPurchaseViewControllerLogoImageView
    static let PPPurchaseViewControllerLogoImageViewPositionX = (width - PPPurchaseViewControllerLogoImageViewWidth)/2
    static let PPPurchaseViewControllerLogoImageViewPositionY = (PPPurchaseViewControllerCrownImageViewPositionY + PPPurchaseViewControllerCrownImageViewHeight)*0.96
    static let PPPurchaseViewControllerLogoImageViewWidth = width*0.26
    static let PPPurchaseViewControllerLogoImageViewHeight = PPPurchaseViewControllerLogoImageViewWidth
    
    // PPPurchaseViewControllerTitleLabelView
    static let PPPurchaseViewControllerTitleLabelPositionX = CGFloat(0)
    static let PPPurchaseViewControllerTitleLabelPositionY = (PPPurchaseViewControllerLogoImageViewPositionY + PPPurchaseViewControllerLogoImageViewHeight)*0.78
    static let PPPurchaseViewControllerTitleLabelWidth = width
    static let PPPurchaseViewControllerTitleLabelHeight = height*0.2
    
    // PPPurchaseViewControllerBuyButton
    static let PPPurchaseViewControllerBuyButtonPositionX = width*1/10
    static let PPPurchaseViewControllerBuyButtonPositionY = PPPurchaseViewControllerTitleLabelPositionY*3
    static let PPPurchaseViewControllerBuyButtonWidth = width*0.8
    static let PPPurchaseViewControllerBuyButtonHeight = height/15
    static let PPPurchaseViewControllerBuyButtonCornerRadius = height*0.033
    
    // PPPurchaseViewControllerYearBuyButton
    static let PPPurchaseViewControllerYearBuyButtonPositionY = PPPurchaseViewControllerBuyButtonPositionY*1.17
    
    // PPPurchaseViewControllerTermsLabel
    static let PPPurchaseViewControllerTermsLabelPositionX = PPPurchaseViewControllerBuyButtonPositionX
    static let PPPurchaseViewControllerTermsLabelPositionY = PPPurchaseViewControllerYearBuyButtonPositionY*1.2
    static let PPPurchaseViewControllerTermsLabelWidth = PPPurchaseViewControllerBuyButtonWidth
    static let PPPurchaseViewControllerTermsLabelHeight = PPPurchaseViewControllerBuyButtonWidth
    
    // PPPurchaseViewControllerRestoreLabel
    static let PPPurchaseViewControllerRestoreLabelPositionX = CGFloat(0)
    static let PPPurchaseViewControllerRestoreLabelPositionY = PPPurchaseViewControllerYearBuyButtonPositionY*1.13
    static let PPPurchaseViewControllerRestoreLabelWidth = width
    static let PPPurchaseViewControllerRestoreLabelHeight = height/40
    
    // PPProfileViewGoProButton
    static let PPProfileViewGoProButtonPositionX = PPUsernameLabelPositionX
    static let PPProfileViewGoProButtonPositionY = PPFridgeItemCountLabelPositionY - PPProfileViewGoProButtonHeight*1.5
    static let PPProfileViewGoProButtonWidth = PPUsernameLabelWidth/2.1
    static let PPProfileViewGoProButtonHeight = PPUsernameLabelHeight/2.3
    
    
    
    
    // PPFridgeListBackgroundImageView
    static let PPFridgeListBackgroundImageViewPositionX = (width - PPFridgeListBackgroundImageViewWidth)/2
    static let PPFridgeListBackgroundImageViewPositionY = (height - 200 - PPFridgeListBackgroundImageViewHeight)/2
    static let PPFridgeListBackgroundImageViewWidth = width/4.5
    static let PPFridgeListBackgroundImageViewHeight = PPFridgeListBackgroundImageViewWidth
}
