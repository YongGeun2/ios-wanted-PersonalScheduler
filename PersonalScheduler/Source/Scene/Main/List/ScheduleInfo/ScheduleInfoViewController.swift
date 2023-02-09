//
//  ScheduleInfoViewController.swift
//  PersonalScheduler
//
//  Created by Dragon on 23/02/07.
//

import UIKit

class ScheduleInfoViewController: UIViewController {
    
    // MARK: Internal Properties
    
    var mode: ManageMode = .create
    var delegate: DataSendable?
    
    // MARK: Private Properties

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView(mode)
    }
    
    // MARK: Private Properties
    
    private let scheduleInfoView = ScheduleInfoView()
    
    // MARK: Internal Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: Private Methods
    
    private func configureView(_ mode: ManageMode) {
        view = scheduleInfoView
        view.backgroundColor = .systemBackground
        
        switch mode {
        case .create:
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "저장",
                style: .done,
                target: self,
                action: #selector(tapRightBarButtonSaveAction)
            )
        case .edit:
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "수정",
                style: .done,
                target: self,
                action: #selector(tapRightBarButtonEditAction)
            )
        case .read:
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "편집",
                style: .done,
                target: self,
                action: #selector(tapRightBarButtonReadAction)
            )
        }
    }
    
    // MARK: Action Methods
    
    @objc
    private func tapRightBarButtonSaveAction() {
        if let data = scheduleInfoView.saveScheduleData() {
            delegate?.sendData(with: data, mode: .create)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func tapRightBarButtonEditAction() {
        
    }
    
    @objc
    private func tapRightBarButtonReadAction() {
        presentEditModeCheckingAlert()
    }
}

// MARK: - AlertPresentable

extension ScheduleInfoViewController: AlertPresentable {
    func presentEditModeCheckingAlert() {
        let alert = createAlert(
            title: "모드전환",
            message: "프로젝트 정보를 편집하시겠습니까?"
        )
        let firstAlertAction = createAlertAction(
            title: "편집"
        ) { [self] in
            scheduleInfoView.checkDataAccess(mode: .edit)
        }
        let secondAlertAction = createAlertAction(
            title: "취소"
        ) {}
        
        alert.addAction(firstAlertAction)
        alert.addAction(secondAlertAction)
        
        present(alert, animated: true)
    }
    
    func presentDateInputErrorAlert() {
        let alert = createAlert(
            title: "날짜/시간 입력 오류",
            message: "시작 날짜/시간이후 날짜/시간을 선택해주세요."
        )
        let AlertAction = createAlertAction(
            title: "확인"
        ) {}
        
        alert.addAction(AlertAction)
        
        present(alert, animated: true)
    }
}
