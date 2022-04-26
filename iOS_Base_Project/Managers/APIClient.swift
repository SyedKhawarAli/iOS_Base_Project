//
//  APIClient.swift
//  zytrack_ios
//
//  Created by BrainX Technologies on 3/1/21.
//

import Alamofire
import Foundation

protocol HTTPRequest {
    var endPoint: URL? { get }

    var method: HTTPMethod { get }

    var parameters: Parameters? { get }

    var headers: HTTPHeaders? { get }
}

extension HTTPRequest {
    var parameters: Parameters? { nil }

    var headers: HTTPHeaders? { nil }
}

typealias APIClientResult = Result<Any, ZyTrackError>

class APIClient {
    // MARK: - Class Instances

    static let shared = APIClient()

    // MARK: - Initializers

    private init() {}

    // MARK: - Public Methods

    func performRequest(_ request: HTTPRequest, shouldAddHeader: Bool = true, andCompletion completion: @escaping (APIClientResult) -> Void) {
        guard let url = request.endPoint else {
            completion(.failure(ZyTrackError(message: LocalizedKey.urlNotFound.string)))
            return
        }
        var headers: HTTPHeaders?
        if shouldAddHeader {
            let auth = HTTPHeader(name: "access-token", value: SessionManager.shared.user?.accessToken ?? "")
            let client = HTTPHeader(name: "client", value: SessionManager.shared.user?.client ?? "")
            let uid = HTTPHeader(name: "uid", value: SessionManager.shared.user?.uid ?? "")

            headers = [auth, client, uid]

            request.headers?.forEach { headers?.add($0) }
        }

        let parameterEncoding: ParameterEncoding = request.method == .get ? URLEncoding() : JSONEncoding()

        AF.session.configuration.timeoutIntervalForRequest = 120
        AF.session.configuration.waitsForConnectivity = true
        AF.request(
            url, method: request.method,
            parameters: request.parameters,
            encoding: parameterEncoding,
            headers: headers
        ).responseJSON { response in
            if response.response?.statusCode == 403 {
                NotificationCenter.default.post(name: .blockedUser, object: nil)
                return
            }
            if response.response?.statusCode == 401 && SessionManager.shared.isUserLogin {
                SessionManager.shared.logout()
                //Show login View Controller
                return
            }
            let headers = response.response?.allHeaderFields ?? [:]
            switch response.result {
            case let .success(value):
                completion(.success((headers: headers, body: value)))
            case let .failure(error):
                completion(.failure(ZyTrackError(message: error.errorDescription ??
                        LocalizedKey.somethingWentWrong.string)))
            }
        }
    }

    func downloadRequest(_ request: HTTPRequest, shouldAddHeader: Bool = true, andCompletion completion: @escaping (APIClientResult) -> Void) {
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)

        guard let url = request.endPoint else {
            completion(.failure(ZyTrackError(message: LocalizedKey.urlNotFound.string)))
            return
        }
        var headers: HTTPHeaders?
        if shouldAddHeader {
            let auth = HTTPHeader(name: "access-token", value: SessionManager.shared.user?.accessToken ?? "")
            let client = HTTPHeader(name: "client", value: SessionManager.shared.user?.client ?? "")
            let uid = HTTPHeader(name: "uid", value: SessionManager.shared.user?.uid ?? "")

            headers = [auth, client, uid]

            request.headers?.forEach { headers?.add($0) }
        }

        let parameterEncoding: ParameterEncoding = request.method == .get ? URLEncoding() : JSONEncoding()

        AF.download(
            url,
            method: request.method,
            parameters: request.parameters,
            encoding: parameterEncoding,
            headers: headers,
            to: destination
        ).downloadProgress(closure: { _ in

        }).response(completionHandler: { DefaultDownloadResponse in
            switch DefaultDownloadResponse.result {
            case let .success(value):
                completion(.success((headers: headers, body: value)))
            case let .failure(error):
                completion(.failure(ZyTrackError(message: error.errorDescription ??
                        LocalizedKey.somethingWentWrong.string)))
            }
        })
    }
}
