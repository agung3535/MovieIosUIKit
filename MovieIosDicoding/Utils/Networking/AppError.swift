//
//  AppError.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation

enum AppError: LocalizedError {
    
    case errorDecoding
    case invalidUrl
    case unknownError
    case serverError(String)
    
    var errorDesc: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .invalidUrl:
            return "INVALID URL"
        case .serverError(let error):
            return error
        case .unknownError:
            return "Bruhh !! I have no idea to go"
        }
    }
}
