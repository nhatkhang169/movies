//
//  TrailerViewController.swift
//  movies
//
//  Created by azun on 01/09/2023.
//

import UIKit
import WebKit
import ProgressHUD

class TrailerViewController: BaseViewController {
    private(set) var videoString: String?
    
    convenience init(urlString: String?) {
        self.init(nibName: nil, bundle: nil)
        videoString = urlString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadTrailer()
        dismissHUDAfterTimeout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ProgressHUD.dismiss()
    }
    
    deinit {
        print("denit - TrailerViewController")
    }
    
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        let view = WKWebView(frame: .zero, configuration: configuration)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.navigationDelegate = self
        return view
    }()
    
    private lazy var exitButtonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .label.withAlphaComponent(0.7)
        return view
    }()
    
    private lazy var exitButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.background.strokeColor = .systemBackground
        config.background.strokeWidth = 2
        config.attributedTitle = AttributedString(L10n.MovieTrailer.Button.exit,
                                                  attributes: AttributeContainer([
                                                    .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                                                    .foregroundColor: UIColor.systemBackground
                                                  ]))
        let button = UIButton(configuration: config, primaryAction: UIAction() { [weak self] _ in
            self?.dismiss(animated: true)
        })
        button.configurationUpdateHandler = { $0.updateState(normalColor: .lightGray) }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

// MARK: - WKNavigationDelegate
extension TrailerViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        shouldShowSpinner = false
    }
}

// MARK: - Private
private extension TrailerViewController {
    enum Constants {
        static let buttonHeight = CGFloat(60)
        static let padding = CGFloat(20)
    }
    
    func setupUI() {
        setupWebView()
        setupExitButton()
    }
    
    func setupExitButton() {
        view.addSubview(exitButtonContainer)
        exitButtonContainer.addSubview(exitButton)
        NSLayoutConstraint.activate([
            exitButtonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            exitButtonContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButtonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            exitButton.topAnchor.constraint(equalTo: exitButtonContainer.topAnchor, constant: Constants.padding),
            exitButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            exitButton.leadingAnchor.constraint(equalTo: exitButtonContainer.leadingAnchor, constant: Constants.padding),
            exitButton.centerXAnchor.constraint(equalTo: exitButtonContainer.centerXAnchor),
            exitButton.bottomAnchor.constraint(equalTo: exitButtonContainer.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding),
        ])
    }
    
    func setupWebView() {
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            webView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func loadTrailer() {
        guard let videoString, let url = URL(string: videoString) else { return }
        webView.load(URLRequest(url: url))
    }
    
    func dismissHUDAfterTimeout() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            ProgressHUD.dismiss()
        }
    }
}
