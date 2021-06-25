//
//  IntroductionView.swift
//  Dots and Boxes
//
//  Created by Evaldo Garcia de Souza Júnior on 12/04/21.
//

import SwiftUI

public struct OnboardingMainPage: View {
    @EnvironmentObject var onboarding: Onboarding

    public init() {}
    
    public var body: some View {
        Group {
            if onboarding.page == 0 {
                OnboardingPage1().environmentObject(onboarding)
            } else if onboarding.page == 1 {
                OnboardingPage2().environmentObject(onboarding)
            } else if onboarding.page == 2 {
                OnboardingPage3().environmentObject(onboarding)
            } else if onboarding.page == 3 {
                OnboardingPage4().environmentObject(onboarding)
            } else if onboarding.page == 4 {
                OnboardingPage5().environmentObject(onboarding)
            }
        }
    }
}

