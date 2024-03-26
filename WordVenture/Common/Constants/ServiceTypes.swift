//
//  RepositoryTypes.swift
//  WordVenture
//
//  Created by Yu Takahashi on 3/25/24.
//

typealias AuthServiceImpl = AuthService<AuthRepositoryImpl, UserDataRepositoryImpl>
typealias WordbookServiceImpl = WordbookService<AuthRepositoryImpl, WordbookRepositoryImpl>
typealias OpenAIServiceImpl = OpenAIService<OpenAIRepositoryImpl>
typealias UnsplashServiceImpl = UnsplashService<UnsplashRepositoryImpl>
typealias IAPServiceImpl = IAPService<IAPRepositoryImpl>
