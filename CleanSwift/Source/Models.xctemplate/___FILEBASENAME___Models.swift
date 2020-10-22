import UIKit

enum ___VARIABLE_sceneName___ {
    // MARK: - Request (UI -> interactor)

    /// UI Lifecycle event forwarding
    enum Event {
        case viewDidLoad
    }

    /// Table view lifecycle event (data source or delegate forwarding)
    //enum TableEvent {
    //    /// Forwarding of the UITableViewDataSource `func tableView(_:commit:forRowAt:)`.
    //    /// Indicates that data source (view model) has to be updated
    //    case commit(editingStyle: UITableViewCell.EditingStyle, indexPath: IndexPath)
    //    /// Forwarding of the UITableViewDataSource `func tableView(_:moveRowAt:to:)`.
    //    /// Indicates that data source (view model) has to be updated
    //    case move(rowAt: IndexPath, to: IndexPath)
    //
    //    case didSelectRow(at: IndexPath)
    //    case didDeselectRow(at: IndexPath)
    //}

    /// User's request / action
    struct Request {
    }

    // MARK: - Response (interactor -> presenter)

    /// Received notification to display.
    ///
    /// Notification is a Response without the Request. It pushes the info to the presenter.
    /// It might be triggered with:
    /// - remote/local notification
    /// - notification about some event/change reported by the system like authorization status change of some service
    /// - notification about change of some observed value
    enum Notification {
        //case invitation(displayName: String, accept: (Bool) -> Void)
    }

    /// The response of the Interactor on an event or request
    enum Response {
        case reloadData
        //case deselectRow(at: IndexPath)
    }

    // MARK: - View Model (presenter -> UI)

    /// Model to display
    struct ViewModel {

    }

    /// Update of the part of the UI
    enum Update {
        //case deselectRow(at: IndexPath, animated: Bool)
    }

    // MARK: Use cases

    //enum Something {
    //    struct Request {
    //    }
    //    struct Response {
    //    }
    //    struct ViewModel {
    //    }
    //}
}
