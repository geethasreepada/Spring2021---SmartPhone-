//
//  NEUCartModel.swift
//  Yammer
//
//  Created by alkadios on 4/27/21.
//

import Foundation
import UIKit

class PaymentDetailsModel {
    
    var Name: String = ""
    var Semester: String = ""
    var actualFee: String = ""
    var TotalAmountPaid:String = ""
    var NUID:String = ""
    var paymentID: String = ""
    
     
    init(Name:String,NUID:String,Semester:String,actualFee:String,TotalAmountPaid:String,paymentID:String) {
        self.Name = Name
        self.NUID = NUID
        self.Semester = Semester
        self.actualFee = actualFee
        self.TotalAmountPaid = TotalAmountPaid
        self.paymentID = paymentID
    }
    
}
