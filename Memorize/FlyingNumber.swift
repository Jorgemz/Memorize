//
//  FlyingNumber.swift
//  Memorize
//
//  Created by JG on 27/09/23.
//

import SwiftUI

struct FlyingNumber: View {
   var number: Int

    var body: some View {
       if number != 0 {
          Text(number, format: .number)
       }

    }
}

#Preview {
    FlyingNumber(number: 5)
}
