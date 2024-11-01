//
//  Constans.swift
//  Flight
//
//  Created by Ugur Cakmakci on 14.04.2024.
//

import UIKit

public enum DateType: String {
    case yyyyMMdd = "yyyy-MM-dd"
    case ddMMyyyy = "dd/MM/yyyy"
    case ddMMyyyyHHmmssWithSlash = "dd/MM/yyyy HH:mm:ss"
    case ddMMyyyyWithDot = "dd.MM.yyyy"
    case ddMMyyyyHHmm = "dd.MM.yyyy HH:mm"
    case ddMMyyyyHHmmss = "dd.MM.yyyy HH:mm:ss"
    case d
    case dd
    case M
    case MM
    case MMM
    case MMMM
    case yyyy
    case hh
    case h_h = "HH"
    case hHmm = "HH:mm"
    case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
    case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
    case dd__mm__yyyy = "dd-mm-yyyy"
    case dd_mm_yyyy = "dd / mm / yyyy"
    case dd_MMMM_yyyy = "dd MMMM yyyy"
    case yyyyMMddTHHmmssSSSSSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
    case yyyyMMddTHHmmssSSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case yyyyMMddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
    case yyyyMMddTHHmmssSSS = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    case ddMMMM = "dd MMMM"
    case mm_yyyy = "MM-yyyy"
    case yyyyMM = "yyyyMM"
    case yyMMdd = "yyMMdd"
    case ddMMM = "dd MMM"
    case EEEE = "EEEE"
    case ddMMMHHmm = "dd MMMM, HH:mm"
    case ddMMMyyyy = "dd MMMM, yyyy"
    case MMMyyyy = "MMMM, yyyy"
    case YYYYMMDDZ = "YYYYMMDD'T'HHMMSS'Z"
}

var leftRightIconPadding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 30)
var leftRightPadding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
var leftRightPadding10 = UIEdgeInsets(top: 0, left: 10, bottom: 0, right:10)
var leftPadding30 = UIEdgeInsets(top: 0, left: 30, bottom: 0, right:0)
var cornerRadius10: CGFloat = 10
var cornerRadius9: CGFloat = 9
var cornerRadius6: CGFloat = 6
var cornerRadius4: CGFloat = 4
var cornerRadius8: CGFloat = 8
var constantBorderWidth: CGFloat = 1.2
