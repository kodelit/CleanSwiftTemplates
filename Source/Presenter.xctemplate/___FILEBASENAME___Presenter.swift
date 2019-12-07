import UIKit

protocol ___VARIABLE_sceneName___DisplayLogic: class {
    func display(viewModel: ___VARIABLE_sceneName___.Something.ViewModel)
}

class ___VARIABLE_sceneName___Presenter: ___VARIABLE_sceneName___PresentationLogic {
    weak var viewController: ___VARIABLE_sceneName___DisplayLogic?

    // MARK: - Presentation Logic

    func present(response: ___VARIABLE_sceneName___.Something.Response) {
        let viewModel = ___VARIABLE_sceneName___.Something.ViewModel()
        viewController?.display(viewModel: viewModel)
    }
}
