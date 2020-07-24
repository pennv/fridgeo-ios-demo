//
//  CalendarSectionController.swift
//  Fridge Helper
//
//  Created by Penn on 11/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import IGListKit
import UIKit

final class CalendarSectionController: ListBindingSectionController<ListDiffable>, ListBindingSectionControllerDataSource, ListBindingSectionControllerSelectionDelegate {

    private var selectedDay: Int = -1

    override init() {
        super.init()
        dataSource = self
        selectionDelegate = self
    }

    // MARK: ListBindingSectionControllerDataSource
    
    // Build data structure (based on model) cell by cell

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
        
        // This "object" is the data passed from view controller
        
        guard let month = object as? Month else { return [] }

        let date = Date()
        let today = Calendar.current.component(.day, from: date)

        var viewModels = [ListDiffable]()

        viewModels.append(MonthTitleViewModel(name: month.name))

        for day in 1..<(month.days + 1) {
            let viewModel = DayViewModel(
                day: day,
                today: day == today,
                selected: day == selectedDay,
                expiredFridgeItems: month.expiringFridgeItems[day] ?? 0
            )
            viewModels.append(viewModel)
        }

        return viewModels
    }
    
    // Render view for each cell

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>,
                           cellForViewModel viewModel: Any,
                           at index: Int) -> UICollectionViewCell & ListBindable {
        let cellClass: UICollectionViewCell.Type
        if viewModel is DayViewModel {
            cellClass = CalendarDayCell.self
        } else {
            cellClass = MonthTitleCell.self
        }
        guard let cell = collectionContext?.dequeueReusableCell(of: cellClass, for: self, at: index) as? UICollectionViewCell & ListBindable else {
            fatalError()
        }
        return cell
    }
    
    // Render view for each cell

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>,
                           sizeForViewModel viewModel: Any,
                           at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { return .zero }
        if viewModel is DayViewModel {
            let square = width / 7.0
            return CGSize(width: square, height: square)
        } else {
            return CGSize(width: width, height: 35.0)
        }
    }

    // MARK: ListBindingSectionControllerSelectionDelegate
    
    // Callback when single cell is selected

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didSelectItemAt index: Int, viewModel: Any) {
        guard let dayViewModel = viewModel as? DayViewModel else { return }
        if dayViewModel.day == selectedDay {
            selectedDay = -1
        } else {
            selectedDay = dayViewModel.day
            NotificationCenter.default.post(name: .calendarCellClicked, object: self, userInfo: ["index" : index])
        }
        update(animated: true)
        // Change the global variable selectedDay in this class
        // then reload entire list
    }

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didDeselectItemAt index: Int, viewModel: Any) {}

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didHighlightItemAt index: Int, viewModel: Any) {}

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didUnhighlightItemAt index: Int, viewModel: Any) {}

}
