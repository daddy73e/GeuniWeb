function showAlert() {
    alert("Alert Test")
}
function showConfirm() {
//    confirm("Confirm Test")
    var test = {
//            "title"         : "시난은행",
//            "message"       : "받는분 은행정보 및 계좌번호를 다시 한번 확인해주세요.\n[확인]을 누르면 다음 단계로 이동합니다.",
            "confirmText"   : "확인",
            "cancelText"    : "취소"
        }
    confirm(JSON.stringify(test))
}
function showPrompt() {
    prompt("Prompt Test", "Enter Text Here")
}
function goPrev() {
    history.back()
}
function goNext() {
    history.forward()
}

function openNewSolDeepLinkPage() {
    var value = document.getElementById("newSolPageID").value;
    var params = {
        "ios" : "https://nsol.shinhan.com/link.html?pr_id=" + value
    };
    sendNativeAction("ExternalApp", "startApp", params);
}

function openOldSolDeepLinkPage() {
    var value = document.getElementById("oldSolPageID").value;
    var params = {
        "ios" : "https://sol.shinhan.com/sms.jsp?scrid=" + value
    };
    sendNativeAction("ExternalApp", "startApp", params);
}

function sendNativeAction(serviceName, functionName, params) {
    otcBridge.sh.exec(success, fail, serviceName, functionName, params);
}
function success(data, params) {
    
}
function fail(data, params) {
    
}
function callbackListener(result) {
    
}
function callbackAppEvent(message) {
    alert("app event = " + JSON.stringify(message));
}
//////////////////////////////////////////////////////////////////////////
/* plugin functions */
function sendNativeActionNetworkSuccess() {
    var className = "https";
    var funcName = "conn";
    var data = {
        "dataHeader": {
            "trxCd": "RSMCM0100A01",
            "language": "1",
            "subChannel": "02"
        },
        "dataBody": {
            "svcGS30": "SBANK",
            "uuid1S64": "",
            "macAdr1S32": "",
            "osVerS20": "",
            "appVer": "8.3.1"
        }
    }
    var params = {
        "url": "https://devnsol.shinhan.com/serviceEndpoint/httpDigital",
        "method": "POST",
        "headers": {
            "Content-Type": "application/json"
        },
        "data": JSON.stringify(data)
    };
    sendNativeAction(className, funcName, params);
}
function sendNativeActionNetworkFailure() {
    var className = "https";
    var funcName = "conn";
    var data = {
        "dataHeader": {
            "trxCd": "RSMCM0100A01",
            "language": "1",
            "subChannel": "02"
        },
        "dataBody": {
            "svcGS30": "SBANK",
            "uuid1S64": "",
            "macAdr1S32": "",
            "osVerS20": "",
            "appVer": "8.3.1"
        }
    }
    var params = {
        "url": "https://devnsol.shinhan.com/serviceEndpoint/httpDigita",
        "method": "POST",
        "headers": {
            "Content-Type": "application/json"
        },
        "data": JSON.stringify(data)
    };
    sendNativeAction(className, funcName, params);
}
function pluginHttps_fileDownTransfer() {
    var params = {
        "downUrls": [
            {
                "url": "http://img.shinhan.com/sbank2016/yak/930000025_yak_20170113173113.pdf?1484296464028",
                "name": "0.pdf"
            },
            {
                "url": "http://img.shinhan.com/sbank2016/form/930000158_form_20180629134735.pdf?1530247682972",
                "name": "1.pdf"
            }
        ]
    };
    sendNativeAction("https", "fileDownTransfer", params)
}
function pluginSNSShareKakao() {
    var params = {
        "title": "타이틀", // 타이틀
        "description": "공유 메시지", // 본문
        "imageURL": "https://shinhan.com", // 이미지 주소
        "imageWidth": 160, // 이미지 너비
        "imageHeight": 100, // 이미지 높이
        "imageLink": "https://shinhan.com", // 이미지 클릭 시 링크 주소
        "buttonTitle": "공유하기", // 버튼 타이틀
        "buttonLink": "https://shinhan.com" // 버튼 클릭 시 링크 주소
    };
    sendNativeAction("SNS", "shareKakao", params)
}
function pluginSNSShareFacebook() {
    var params = {
        "linkURL": "https://shinhan.com"
    };
    sendNativeAction("SNS", "shareFacebook", params)
}
function pluginSNSShareScreenshotKakaoScreen() {
    var params = {
        "type": "screen",
        "title": "공유 타이틀",
        "description": "공유 메시지",
        "imageLink": "https://shinhan.com",
        "buttonTitle": "테스트 버튼", // 버튼 타이틀
    };
    sendNativeAction("SNS", "shareScreenshotKakao", params)
}
function pluginSNSShareScreenshotKakaoFullWeb() {
    var params = {
        "type": "fullWeb",
        "title": "공유 타이틀",
        "description": "공유 메시지",
        "imageLink": "https://shinhan.com",
        "buttonTitle": "테스트 버튼", // 버튼 타이틀
    };
    sendNativeAction("SNS", "shareScreenshotKakao", params)
}
function pluginSNS_getInfoFromKakaoAccount() {
    var params = {
    };
    sendNativeAction("SNS", "getInfoFromKakaoAccount", params)
}


function pluginUserPreferenceSetValue() {
    var params = {"key1": "value1", "key2": "value2"};
    sendNativeAction("UserPref", "setValue", params)
}
function pluginUserPreferenceGetValue() {
    var params = {"keys": ["key1", "key2"]};
    sendNativeAction("UserPref", "getValue", params)
}
function pluginCacheDeleteCache() {
    var params = {"allCookie": true, "appCache" : true, "contentCache": true };
    sendNativeAction("Cache", "deleteCache", params)
}
function pluginAccount_getAccountList() {
    var params = {
        "customerNumber" : "123123123"
      }
    
    sendNativeAction("Account", "getAccountList", params)
}
function pluginAccount_setAccountList() {
    var params = {
        "customerNumber" : "123123123",
        "accountList" : {
            "aaa" : "AAA",
            "bbb" : "BBB"
        }
      }
    sendNativeAction("Account", "setAccountList", params)
}
function pluginAccountThemeColor_fetchThemeColor() {
    var params = {
        "accountNumber": "110306310914"
    };
    sendNativeAction("AccountThemeColor", "fetchThemeColor", params)
}

function pluginAdbrix_sendEvent() {
    var params = {
        "eventName": "page_in",
        "extraData": {
            "key1": "value",
            "key2": 3
        }
    };
    sendNativeAction("AdBrix", "sendEvent", params)
}
function pluginAdbrix_signUp() {
    var params = {
        "signType": "1"
    };
    sendNativeAction("AdBrix", "signUp", params)
}

function pluginCertificate_isFindCertificate() {
    var params = {
        "isOnlyCertInfo" : "Y"
    };
    sendNativeAction("JointCert", "isFindCertificate", params)
}
function pluginCertificate_getCertDetailInfo() {
    var params = {
        "index" : 0
    };
    sendNativeAction("JointCert", "getCertDetailInfo", params)
}
function pluginCertificate_checkCertPassword() {
    var params = {
        "password" : "gGDagO0MyTk/gOQE65f4nw=="
    };
    sendNativeAction("JointCert", "checkCertPassword", params)
}
function pluginCertificate_makePKCS7SignedData() {
    var params = {
        "index" : 1,
        "password" : "1234qwer"
    };
    sendNativeAction("JointCert", "makePKCS7SignedData", params)
}
function pluginCertificate_certSign() {
    var params = {
        "certOnly" : true
    };
    sendNativeAction("JointCert", "certSign", params)
}


function pluginCrypto_encryptAES() {
    var params = {
        "PlainText" : "test"
    };
    sendNativeAction("Crypto", "encryptAES", params)
}
function pluginCrypto_decryptAES() {
    var params = {
        "CipherText" : "a9313268ef30a1d8ffb00161ce2a5977"
    };
    sendNativeAction("Crypto", "decryptAES", params)
}
function pluginCrypto_equals() {
    var params = {
        "encType": "client",
        "cipherText": "9fWCG8ahLoQCH31srvkiuw==",
        "plainText": "12345"
    };
    sendNativeAction("Crypto", "equals", params)
}

function pluginGoogleAnalytics_sendScreen() {
    alert("해당 예제는 목업입니다.\n플러그인 구현 후 alert 제거해 주세요");
    var params = {};
    sendNativeAction("GoogleAnalytics", "sendScreen", params)
}
function pluginGoogleAnalytics_sendEvent() {
    alert("해당 예제는 목업입니다.\n플러그인 구현 후 alert 제거해 주세요");
    var params = {};
    sendNativeAction("GoogleAnalytics", "sendEvent", params)
}

function pluginLogin_getLoginInfo() {
    var params = {};
    sendNativeAction("Login", "getLoginInfo", params)
}
function pluginLogin_setLoginInfo() {
    var params = {"cusSungNmS30": "호헹", "cusSungNmS20": "호헤헹"};
    sendNativeAction("Login", "setLoginInfo", params)
}
function pluginLogin_checkLoginType() {
    var params = {};
    sendNativeAction("Login", "checkLoginType", params)
}
function pluginLogin_loginByWeb() {
    var params = {};
    sendNativeAction("Login", "loginByWeb", params)
}
function pluginLogin_unregisterAutoLogin() {
    var params = {};
    sendNativeAction("Login", "unregisterAutoLogin", params)
}
function pluginLogin_checkIfAutoLoginRegistered() {
    var params = {};
    sendNativeAction("Login", "checkIfAutoLoginRegistered", params)
}
function pluginMenu_getAllProgramList() {
    var params = {};
    sendNativeAction("Menu", "getAllProgramList", params)
}
function pluginMirroring_setMirroringYn() {
    var params = { "mirroringYn" : "Y" };
    sendNativeAction("Mirroring", "setMirroringYn", params)
}
function pluginMirroring_getMirroringYn() {
    var params = {};
    sendNativeAction("Mirroring", "getMirroringYn", params)
}

function pluginScraping_request() {
    var params = {
        "tasks": [[
                   {
                       "서비스명": "홈택스_사업장리스트",
                       "인증서": {
                           "인증서파일": "MIIFrjCCBJagAwIBAgIELxUktzANBgkqhkiG9w0BAQsFADBSMQswCQYDVQQGEwJrcjEQMA4GA1UECgwHeWVzc2lnbjEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRowGAYDVQQDDBF5ZXNzaWduQ0EgQ2xhc3MgMzAeFw0yMjA5MjExNTAwMDBaFw0yMzA5MjIxNDU5NTlaMHExCzAJBgNVBAYTAmtyMRAwDgYDVQQKDAd5ZXNzaWduMRQwEgYDVQQLDAtwZXJzb25hbDRJQjEMMAoGA1UECwwDU0hCMSwwKgYDVQQDDCPqsJXsi5zqsr0oKTAwODgwNDAyMDA3MTIxNTE4ODAwMDg3MzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAM/3a9pZVGhU2ziTmCYsFC9bSgc3WH4nreshaf2dm6D1GosWWmi9BaQ2cW8Ao4+sOiNoE9GMMRgG9bJhZ5rrpDvWfQj+SyNjzDnpqFnX+UIzc4SA6bQ6uQpGlTVd78YqcjcxHdtwaiSr01IaAXSqBoO7PE4IclL6eBetTBtzwII0/rfhUwxbhSXaBUVjWz3LQ4FY98Xw0xkwjnBwf8jMYHxwnpY+7ID6iRZvqp/VryMAkTdtrZFElbVG8Fp3ImqPJxSqLkuTjKikCYKOc/S4iAPrdgPxC954e6BnkQmqYt7vIEiO5ZeFpnDIZ/JHbGJPQM6cW4mHixDfIBnisqnLRg8CAwEAAaOCAmswggJnMIGPBgNVHSMEgYcwgYSAFPKHo+bZXhYWck7YwryFOQM3WZDEoWikZjBkMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEWMBQGA1UEAwwNS0lTQSBSb290Q0EgNIICECgwHQYDVR0OBBYEFANPrYvHcIa4am1eSS11rO/SU7e6MA4GA1UdDwEB/wQEAwIGwDCBjAYDVR0gAQH/BIGBMH8wfQYJKoMajJpFAQEEMHAwQAYIKwYBBQUHAgIwNB4yx3QAIMd4yZ3BHLKUACCuCMc1rLDIHMbQxdDBHAAgvByuCdVcACDHeMmdwRzHhbLIsuQwLAYIKwYBBQUHAgEWIGh0dHA6Ly93d3cueWVzc2lnbi5vci5rci9jcHMuaHRtMGgGA1UdEQRhMF+gXQYJKoMajJpECgEBoFAwTgwJ6rCV7Iuc6rK9MEEwPwYKKoMajJpECgEBATAxMAsGCWCGSAFlAwQCAaAiBCAqIU62ZXdJ1A/7w4PDH0MzzN99NwmUlLB0FoVv7LmaczBxBgNVHR8EajBoMGagZKBihmBsZGFwOi8vZHMueWVzc2lnbi5vci5rcjozODkvb3U9ZHA2cDE4ODcsb3U9QWNjcmVkaXRlZENBLG89eWVzc2lnbixjPWtyP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3QwOAYIKwYBBQUHAQEELDAqMCgGCCsGAQUFBzABhhxodHRwOi8vb2NzcC55ZXNzaWduLm9yZzo0NjEyMA0GCSqGSIb3DQEBCwUAA4IBAQA5zp9KqYzPg+vYGMaH+9X/oqjxP0+mawtsl6Y+/GOotg+iE94eJ+6EXiqg1FvX4B+vjOa1xZqkX3O/i6GiFCb9ODk56c/mewo5Xx7HGe7WNJ7s9qWIDHDtCEI5GQU4xIx8kZV/6c+QUQpfyoswlFiAie3Pmhmw/3y+4K+08vBGC7UYcxKEVJ0PXdDVCeCJR0RfcL0jXPPhJYGQPG+psJpiVOAic2ZuUUB/yO8xy8g9kEzSUNF7FuRAqEOjp9abWLYokZxpuJbWgXHx2oU9JDI+EQ1OblSWrpECb/AHeYV3O5heYIQTPSUDfylSJyYvlGWaamcgdavcxQ+VSIpGk19Y",
                           "인증서키파일": "MIIFEDAaBggqgxqMmkQBDzAOBAiK+2x25mZCxwICCAAEggTwBs/m+wG9d4HOsK0uHc6wM48LFb2nIZsWIJZN7J1tb3wZn8pWjnc7/85l7Pq1koPMSivNp34mdpLdhNxkbbv0zuCa6RomyZdC2H59YxY8hu/EKBj7KPYmdgF0Hijnw6dQwMzrlxG5YUMSOKsRE3/gIy1fTcj//51CeSoOmR546ybImEahRkVgu03ZAnpPIJaQB8zxgu6fK8CLfWOyfmButNDM5SySnq/BC4ypqxF0gilJoj3m6WXMlUhm3lRd2q4s3ueoPTYRaLKAOGReyuNWnCDYoxVhhyQkSvggt+rtT7AswCuSzSaquKaWJTMtQFu12mL3sLUj5cQVVQQvctdc5y+Pt5h2SDhrbboD/QYg1S2lDLmVQJl1L7s6hnm7nxj2xI+t0Z2iyJo5FRGEamx6ixO4fWiQgceArt0b/wODYZXkOyQQRweJjJwiC67Ap4ylE36WC9e/m9fLLMj4tJOPjympDCjNdagUy/6dQAWF5hqP0rZrrSpVpVFhHQhGgQIHZBhXguIY67g+4b5czIUOZZ5/2RCfq+CQxxDupERsqiRiw5Allyicy/dOgQpPojGd0sS3Gml2Yy1Se5Ji1jX/gmCLoHv5CL+e8PsDYNHd8TSeUiLuD9W+m94SYPutCV9w8gI7NssuaYBwswXiMul6jzHa6lcsZvcFYiz2Rn8oyH2aKsmUovpgUuu6BzrKSOf44gK+LP2h3qTGZO5467wDHINaetGVoTGfPiYOEDdJhY3ekq2gljxnUvzSKbNpKzvRnwQ1Otf1ks7I6NyeuGIu0g8E/VWYcJQ4lXHVCGZI7nv9+vIgfYpp+XDmErwMcmJbo6tl2SJ07D4iM+MHpk2JUwbvQCWVEJ8siIdWci0hGaOLdatpi8AmxyuyK9ub2dbo/4UM/l6nvIJ7lzfwTFfZNm7/hx9xVcXiM1yB5Eo4T2TfGbrFG6rxaFavPQ3uSL5XTH5uPzld5jSXM0dLCLUQM1PLimFxkxDUmhfxSKFLrKkMOoAvJ8S+eJ0W8qnYzDpWSJqlC/pNfb/Dkdkz9CkeN9NC8pGm3MOsfuhooIQaICMtMl6ZuzNQUJjCaTZfj7YI+RdGejGibKr/uyPY22OjTTUblMM4Ske+52usaXr8qIa2YsLEchOVWobpTy7XFYxyc9nhrK/urK3sQDlgn1V8nbQxBIL3oRjcxXi5xf2Ja2A7cl86IEzfBG5MnYmFVHcfq2qfPGX3NDrnXYuIuP3PnOp4vqU9UoSz1gYb59TkuEiimumXVv9X9R9yDoAUrQQmlhgue30qSTjS8Id7fosoREKr1NaeY1DfFGQXb7KyGicge7tPVlhFhYT3KZytifMQN/SKRrsrEApt0sOEgf6oppQxliliJPXnt5dgH3ef77W0mvfm8/bTBQ1EhdWpoKFhorPFIT889ofHMoMVfVrelGzzLIIb2BBZqHDaiwtZ0fj7cYQ/1CeqjRd4jo+wAl/jnRC4hAoX3FqApFQpxnqnxz/qPqT/kpIGEq4AoCvLPulJVY5B0iHQEdF47WL+paaMBpn1FDVHnGBUrdFbP3P77DVAp3heMUmkXlpKQSWm99OSIyiiZh5XoY5CMCwrXIWKX0R5CWIyoL4W5LksVYz0Ltps2BtDB1Zv+q8PnJ94iZ2qriK8fhyslE/RuOnpTIIgs1Poma2JIIaJvdQ+0PxJAw==",
                           "비밀번호": "1q2w3e4r!!"
                       }
                   }
                   ]]
    };
    
    /*var params = {
        "tasks": [[
            {
                "서비스명": "내보험다보여_보장내역및분석통계",
                "계약자": "1",
                "계약내용조회": "Y",
                "패스워드": "Hsdfasdf5&",
                "jobId": "내보험다보여_보장내역및분석통계",
                "계약상태": "",
                "아이디": "sdfsdf"
            }
            
            //
            {
                "서비스명": "건강보험_건강검진결과조회_신한은행",
                "인증서": {
                    "인증서파일_enc": "t773k06Rg4hlup40VlFiZJBLDpnxd6u0hr2og4UspJwBQ9tj7mawzf%2BfaZF2gBUe;j%2FkTj9lQFRwA7I5MV%2FElooMCjuEKfoW2MPI3JlYCTHDSVVHfIB%2FKK74JZv22nCtnb6N4GXWrolyQwm%2F%2BYhKL5%2FFDN%2BfcgD6rwzyoks9zbTQ2xj%2FB1X9Ja5OOz2m79D8mk75drVEcvS1%2FnwggOlOl9nqXtWp%2BjpPPMRPvxkhpgpvbYqfbo%2FzfHboUWndofZC17S%2F42VLnKH%2BrUsVFArMTlVQXjXv2VdGbbd%2FAaCE77MZI2DHx1%2Fm1rsjbb9siOjFILkL%2BAYq1kL%2Bl5DEzAiZluRuxSsyRD3cIZvodYuij6b%2B2c3J6%2BDRgtLvFOPKh9WnVYg0c4zjxf5QTrMxKHrYOmcjs44%2FAV0mbPA51u%2FPdyP%2BY%2Ba2hAklyXgej%2Fzn6J4jfMfhBKQdvPrNPN91Av47nU7rstypfSpBpap1KZIem77UuErZXj%2Bb5oKx0RGaleTppzyGceTlU4E7XW3%2B%2BR8gx%2BwYvv%2B3aXA6FVXqla%2FtGm1YBJMbW8wu%2F5qxVFZxTnR%2BfeQv61lY6WrcAuG62ZzR53YldhEpigYD1USY4lxu4o3C5oOVZ%2BAox%2BEDdzt%2FYvA7zWY0KMMJGvtbcCbvt0WcdUsgzYG2ZYXrGUjPU5Cy05ObMdV2E0xaaIeRi22koCmHOQ5H%2FmaXWD7R1Hz7QDWRFKJvLQ1A%2F%2F1WjuL6d6pMZWiRGz8QVcrqh6FmJItphnese0DWQPFmdpTobGmQlaevCLtSLWEAyOo19aN5Asvwl69yodfwkfi3bARQ1fMUntRO3yKBJpChklqjfl0eXp%2F89VGw1%2BNGR0YH4o0m5%2BKYXd%2BRjubriPDlaCaa22dI1yQn8w3YTDVsJX5A9rE26idxo0OpOg15XTDNAePy8ebBZchhVtIrwFBoTVUuP4NAcjPdUndlsNJ4nACU5uWTl73QAob60xvsqUm0rBWKtDHZDB98BTUh2gA%2BCHgfAPGObtVKgu6FRnbc8xnRvtt2XyYeG9IvTF7gkbYbgtS7YlYoumo3ZE7X%2FgziO058UV2l%2FvpvyaomcONVT1mn95aHVND%2FgR%2B%2F3uK2OMMwjBs2YqBmoe%2BZJvdsFNp7PmnqHSa6hisgoOuBj5gXv%2BXhhxwqCg2BYUnupoFHHiPNzoXDBvzJfQvrfC8L6YtzDp45%2FOVuIQ%2BbKJFFsNhokNMknOXqMzm7%2FLRTHdcz2N9eMEuY%2BeIZBcLHbTPQu5rr8f7GNp0uY0KpZJ%2FNkQesFyHpAQaXOYdi8C%2B%2B4fugvfBn1Q%2FxaQq0HiqS5mGJw2zxIperP%2BG8oUzkr7tBArpEnuGxs5lYd%2F1Bg4Swp6C5sGYVNrjo%2BZcu3O5ROYxXjKIF%2FlkBaIhy59Ylk=",
                    "인증서키파일_enc": "x73SYttpF5l9a7vZXpy2XUtm3Cf9Fq2F%2FMw%2F3L7wZ3EBQ9tj7mawzf%2BfaZF2gBUe;22QRelg70pSkBzaKelk2tCzDJkFaMtvY9wQYbhIDCJW7gQIhSrwn76qsTKwBmEsn9LsGNYq3dzMxOMHTTwbXmPqn2Vm3x49ZPJHunh6TU%2Fy2RAm4LQEWCot%2FaRye4h1eh96fQIva%2B6BXZq0GyJaXNz%2Fk7FQab%2Fk5zebz45ZIAMsY1vMztKwr4BqT5Y0Mk8rRSElIi1OjyKtbV%2FNvqhxm2BOOajRKIQJ0V0nYcQZKql0UWyX5MV5dK977zop79xIx0yrWKQAHPIIa27DrYGdoM6ZPwGvUvMYQ10n6nu9KnHGvwn40ejEYVl%2FGKQJFTXN2hjwuVRPdNit%2Fy0v8rZ91yglkI7SoXemnj2y4TFS3Qb%2Bk%2BmtP%2FxaXk4aRsK6FbtWySvcFAfePhF0xMpTsFLQSFU8XqNOpWd2kx3vTcIdvVd8%2B%2BAAf6F9nzDXoH42DdeWYX%2BNdemfNbjnEidF8TLXkhOF00dUspT%2FKgZQaEY1M3nYFbyz7owJImYGlpX626LzLuSnTaUb%2Fo56Hl5r2RPlDvNZvjOYkU0yPtVcoqUlO4xPamyqft9Bv8wqQX5IYqMVxGM33iTcApvkxlRHVQwrVCthslMQUoRviMyZnim2aN1pcpG%2Fyvo4%2B5KBWz%2Faq3mRWJEyGPeaVYXzwJRTHOuwDfjunWY9pQO4Tsb3yoD%2BOjW4uBsDFCEVcuPa%2BOisotuHCmiWpN7uJ0aGI2wAWGoN5dRWjmXhZgusxtn1MJ3%2BArUn9AY%2Fua3vZbRlsVyDmSN0uGvgta89JJ1vqxYnJlq5AtCHj7YMEH6eWMokaVKrCprsvzqRPkUyFFeHzl9HKgRTGth1pkotNiL5GuGGbN%2BEfjmfnizywRGvr6dG6%2BLNmetsXMTmpVWG9QiK8kxYXrqKgcgYXqA0%2FdOu%2Bo0UgSP5sRuqTuZHx2xS5mCW8E99F01lFABhE8R2n%2BJ03h7OqZwuMKUPBlhIU8bts9kWVP00WCumFufbzIGjtu91mqSJ1AjGv0da4j8jZFISdx4ZWiuAYSQ75CQ%2FVNIoshaDFx87tY%2FmorwtEqXeTRJvxCpU6jhPvqMBAiV%2FPqAhBxKTOVD%2FYDmGm8Bkfrqian63GZMJjOIYKEXlOt%2FMltqm7%2FsNi6gcsk%2F383gKbuc4LPH5Ples90WbtpVGCkRhub0eNzuDTJXCOJfrGv3DNYHtaXex9u8lFDaMjVy%2B5gjlZesf8pm%2BEQ==",
                    "비밀번호_enc": "xge%2BGgOHqLwj637mawzf%2BfaZF2gBUe;8mmxTKGSGzRGlDMzo83D9Q=="
                },
                "타임아웃": "300",
                "주민번호": "800414",
                "jobId": "건강보험_건강검진결과조회"
            },
            {
                "서비스명": "건강보험_납부확인서_신한은행",
                "인증서": {
                    "인증서파일": "1UdDwEB/wQEAwIGwDCBjAYDVR0gAQH/BIGBMH8wfQYJKoMajJpFAQEEMHAwQAYIKwYBBQUHAgIwNB4yx3QAIMd4yZ3BHLKUACCuCMc1rLDIHMbQxdDBHAAgvByuCdVcACDHeMmdwRzHhbLIsuQwLAYIKwYBBQUHAgEWIGh0dHA6Ly93d3cueWVzc2lnbi5vci5rci9jcHMuaHRtMGgGA1UdEQRhMF+gXQYJKoMajJpECgEBoFAwTgwJ67CV7KCV6ri4MEEwPwYKKoMajJpECgEBATAxMAsGCWCGSAFlAwQCAaAiBCBQ3iF2nvamdL7ICVpeI4DPb4cQzJrouqW5wXSV7ZW9ajBzBgNVHR8EbDBqMGigZqBkhmJsZGFwOi8vZHMueWVzc2lnbi5vci5rcjozODkvb3U9ZHA1cDEwMDM2MCxvdT1BY2NyZWRpdGVkQ0Esbz15ZXNzaWduLGM9a3I/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDA4BggrBgEFBQcBAQQsMCowKAYIKwYBBQUHMAGGHGh0dHA6Ly9vY3NwLnllc3NpZ24ub3JnOjQ2MTIwDQYJKoZIhvcNAQELBQADggEBACRJr/61mcEyH2O+NLs7dB6FbcGCh8+ZrJMpw2B5NMFv/UNquN44/1a3JAvDFm7aLkfahIEw+/Wx6ldi1GK2JjNmSQjYrVbsdHZx0pP2mHFkErWQbPnpB+jY8ZP8tMsvh0BlKoyuiJdO6YY3cM2ozo8PYMzlkQ8WSP0bjGnQh1dI0NcKTLjM/INXC3Zddo9cr41p6AAanQ7Ifu5vVZMe2G65bYoydRDmiSXYxy307dc42H5eXeMmmIeZGGGSDt0I6Mb48ZtXlCeo/CyatF2wveoPGSvovia1aOIjHzgzP6C/oS4dxdMGhM9NSom/StNRv5IrDwsFMc8kHgM5XgNlIl8=",
                    "인증서키파일": "yqKMiYJQnTLCz2c4TOSGhUbpceF/AzCVzUAeaAbjUL6ybMu8wJy71Fhhq8EoSwxyAPNdbTFTTO2toWgsaOYZMGspOOdeZZTq4elYBUTFoR42NY5S6eB6jr/cnv/ChRW66O55sQQnkjn3Fwsw9ocGOrV+/AbHb2jzjDgdSrKVZLRcMuZ7+uRPu6dDvV4ALt3xUX+vP0axTGCCrAg+6bcZjPMji4M95OUvtq7rDT1dvyYbN7oLRPNO/McjNjrn01l6UA0XAmby3rYwzmBUCycLeeaE+M04INFq5g3br3C7z5FspZpEddVOMMKWkD/dBiv4Bn16lqa28ikvxLuKrxqr0//v75WEcxBJPFRp83T6A77Ra7ECR94OqM0s9l4RouM8Txp9ko2O0HtsaKGVuRUGrFmNyfbng4rc77ghXASrpQrvz1wCncny0zl4KL4BRtuRd8ckOgR/cFXUOa1RjoJcVp/nx2hJFZ7QLm/Yrrvv9XiSiOVjpSBhchcOt+iN6CZIXiN5EhWCKCin54OlKuR1lC+wcSaGTVYkN3MPXKSmHTk//32A6W0DWIs+d+lYsNlGhC7r0VM2GXvXYCCpvggVTD8IFpKSTkQYFH8MCFa6PQmIhPw==",
                    "비밀번호": "qqqqqqqq&"
                },
                "타임아웃": "300",
                "주민번호": "8211111111111",
                "사용목적": "2",
                "조회시작년월": "202201",
                "조회종료년월": "202202",
                "jobId": "납부확인서"
            }
        ]]
    };*/
    sendNativeAction("Scraping", "request", params)
}
function pluginScraping_stop() {
    var params = {};
    sendNativeAction("Scraping", "stop", params)
}
function pluginScraping_joinToEncryptString() {
    var params = {
        "items": [
            {
                "encType":"plain",
                "value":"12"
            },
            {
                "encType":"client",
                "value":"gGDagO0MyTk/gOQE65f4nw=="
            }
        ]
    };
    
    sendNativeAction("Scraping", "joinToEncryptString", params)
}
function pluginScraping_fetchEncSSN() {
    var params = {
    };
    
    sendNativeAction("Scraping", "fetchEncSSN", params)
}



function pluginScraping_requestNSave() {
    
    // 신한플러스 확인
    /*var params = {
        "useProgress": false,
        "scrapingSignType":"SSign",
        "tasks":[
            {
                "SCRAP_DATA":{
                    "타임아웃": "120000",
                    "서비스명": "홈택스_소득금액증명_신한은행",
                    "주민번호": "8000001231231",
                    "이름": "홍길동",
                    "증명구분": "2",
                    "주소공개여부": "N",
                    "주민등록번호공개여부": "N",
                    "사용용도": "99",
                    "제출처": "99",
                    "PDF포함여부": "Y",
                    "원문데이터포함여부": "",
                    "조회시작년도": "2020",
                    "조회종료년도": "2021",
                    "휴대폰앞자리": "010",
                    "휴대폰중간자리": "1231",
                    "휴대폰끝자리": "1233",
                    "PDF포함여부": "Y",
                    "개인정보공개여부": "N",
                    "로그인방식": "SH_simple"
                },
                "SEND_DATA":{"DOC_PRD_CD":"711120000","DOC_BPR_SEND_LEVEL":"1","DOC_REQ_NO":"99999","DOC_TRANS_YN":"Y","DOC_BPR_SEND_YN":"Y","DOC_BPR_INF_KIND":"LOAN","organName":"국세청","docName":"부가가치세과세표준증명","docId":"NTS_VAT_GWASE","DOC_KIND":"NTS_VAT_GWASE"},
                "DOC_KIND":"NTS_VAT_GWASE"
            }
        ]};*/
            /*,
                {"SCRAP_DATA":{"서비스명":"정부24_지방세납세증명","기관코드":"906","기관명":"정부24","타임아웃":"120","구분":"01","사업자번호":"","법인등록번호":"","주소1":"대전광역시","주소2":"동구","주소3":"판교1길 3","주소검색방법":"0","주민등록번호공개여부":"1","사용목적":"","휴대폰앞자리":"010","휴대폰중간자리":"8333","휴대폰끝자리":"","로그인구분":"1","이름":"","PDF포함여부":"Y","개인정보공개여부":"N","DOC_KIND":"GOV24_JIBANGSENAB","휴대폰뒷자리":"7075","주민번호":"7810302841011","이름":"강시경","인증서":{"인증서경로":"","인증서파일":"MIIFrjCCBJagAwIBAgIELxUktzANBgkqhkiG9w0BAQsFADBSMQswCQYDVQQGEwJrcjEQMA4GA1UECgwHeWVzc2lnbjEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRowGAYDVQQDDBF5ZXNzaWduQ0EgQ2xhc3MgMzAeFw0yMjA5MjExNTAwMDBaFw0yMzA5MjIxNDU5NTlaMHExCzAJBgNVBAYTAmtyMRAwDgYDVQQKDAd5ZXNzaWduMRQwEgYDVQQLDAtwZXJzb25hbDRJQjEMMAoGA1UECwwDU0hCMSwwKgYDVQQDDCPqsJXsi5zqsr0oKTAwODgwNDAyMDA3MTIxNTE4ODAwMDg3MzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAM/3a9pZVGhU2ziTmCYsFC9bSgc3WH4nreshaf2dm6D1GosWWmi9BaQ2cW8Ao4+sOiNoE9GMMRgG9bJhZ5rrpDvWfQj+SyNjzDnpqFnX+UIzc4SA6bQ6uQpGlTVd78YqcjcxHdtwaiSr01IaAXSqBoO7PE4IclL6eBetTBtzwII0/rfhUwxbhSXaBUVjWz3LQ4FY98Xw0xkwjnBwf8jMYHxwnpY+7ID6iRZvqp/VryMAkTdtrZFElbVG8Fp3ImqPJxSqLkuTjKikCYKOc/S4iAPrdgPxC954e6BnkQmqYt7vIEiO5ZeFpnDIZ/JHbGJPQM6cW4mHixDfIBnisqnLRg8CAwEAAaOCAmswggJnMIGPBgNVHSMEgYcwgYSAFPKHo+bZXhYWck7YwryFOQM3WZDEoWikZjBkMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEWMBQGA1UEAwwNS0lTQSBSb290Q0EgNIICECgwHQYDVR0OBBYEFANPrYvHcIa4am1eSS11rO/SU7e6MA4GA1UdDwEB/wQEAwIGwDCBjAYDVR0gAQH/BIGBMH8wfQYJKoMajJpFAQEEMHAwQAYIKwYBBQUHAgIwNB4yx3QAIMd4yZ3BHLKUACCuCMc1rLDIHMbQxdDBHAAgvByuCdVcACDHeMmdwRzHhbLIsuQwLAYIKwYBBQUHAgEWIGh0dHA6Ly93d3cueWVzc2lnbi5vci5rci9jcHMuaHRtMGgGA1UdEQRhMF+gXQYJKoMajJpECgEBoFAwTgwJ6rCV7Iuc6rK9MEEwPwYKKoMajJpECgEBATAxMAsGCWCGSAFlAwQCAaAiBCAqIU62ZXdJ1A/7w4PDH0MzzN99NwmUlLB0FoVv7LmaczBxBgNVHR8EajBoMGagZKBihmBsZGFwOi8vZHMueWVzc2lnbi5vci5rcjozODkvb3U9ZHA2cDE4ODcsb3U9QWNjcmVkaXRlZENBLG89eWVzc2lnbixjPWtyP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3QwOAYIKwYBBQUHAQEELDAqMCgGCCsGAQUFBzABhhxodHRwOi8vb2NzcC55ZXNzaWduLm9yZzo0NjEyMA0GCSqGSIb3DQEBCwUAA4IBAQA5zp9KqYzPg+vYGMaH+9X/oqjxP0+mawtsl6Y+/GOotg+iE94eJ+6EXiqg1FvX4B+vjOa1xZqkX3O/i6GiFCb9ODk56c/mewo5Xx7HGe7WNJ7s9qWIDHDtCEI5GQU4xIx8kZV/6c+QUQpfyoswlFiAie3Pmhmw/3y+4K+08vBGC7UYcxKEVJ0PXdDVCeCJR0RfcL0jXPPhJYGQPG+psJpiVOAic2ZuUUB/yO8xy8g9kEzSUNF7FuRAqEOjp9abWLYokZxpuJbWgXHx2oU9JDI+EQ1OblSWrpECb/AHeYV3O5heYIQTPSUDfylSJyYvlGWaamcgdavcxQ+VSIpGk19Y","인증서키파일":"MIIFEDAaBggqgxqMmkQBDzAOBAiK+2x25mZCxwICCAAEggTwBs/m+wG9d4HOsK0uHc6wM48LFb2nIZsWIJZN7J1tb3wZn8pWjnc7/85l7Pq1koPMSivNp34mdpLdhNxkbbv0zuCa6RomyZdC2H59YxY8hu/EKBj7KPYmdgF0Hijnw6dQwMzrlxG5YUMSOKsRE3/gIy1fTcj//51CeSoOmR546ybImEahRkVgu03ZAnpPIJaQB8zxgu6fK8CLfWOyfmButNDM5SySnq/BC4ypqxF0gilJoj3m6WXMlUhm3lRd2q4s3ueoPTYRaLKAOGReyuNWnCDYoxVhhyQkSvggt+rtT7AswCuSzSaquKaWJTMtQFu12mL3sLUj5cQVVQQvctdc5y+Pt5h2SDhrbboD/QYg1S2lDLmVQJl1L7s6hnm7nxj2xI+t0Z2iyJo5FRGEamx6ixO4fWiQgceArt0b/wODYZXkOyQQRweJjJwiC67Ap4ylE36WC9e/m9fLLMj4tJOPjympDCjNdagUy/6dQAWF5hqP0rZrrSpVpVFhHQhGgQIHZBhXguIY67g+4b5czIUOZZ5/2RCfq+CQxxDupERsqiRiw5Allyicy/dOgQpPojGd0sS3Gml2Yy1Se5Ji1jX/gmCLoHv5CL+e8PsDYNHd8TSeUiLuD9W+m94SYPutCV9w8gI7NssuaYBwswXiMul6jzHa6lcsZvcFYiz2Rn8oyH2aKsmUovpgUuu6BzrKSOf44gK+LP2h3qTGZO5467wDHINaetGVoTGfPiYOEDdJhY3ekq2gljxnUvzSKbNpKzvRnwQ1Otf1ks7I6NyeuGIu0g8E/VWYcJQ4lXHVCGZI7nv9+vIgfYpp+XDmErwMcmJbo6tl2SJ07D4iM+MHpk2JUwbvQCWVEJ8siIdWci0hGaOLdatpi8AmxyuyK9ub2dbo/4UM/l6nvIJ7lzfwTFfZNm7/hx9xVcXiM1yB5Eo4T2TfGbrFG6rxaFavPQ3uSL5XTH5uPzld5jSXM0dLCLUQM1PLimFxkxDUmhfxSKFLrKkMOoAvJ8S+eJ0W8qnYzDpWSJqlC/pNfb/Dkdkz9CkeN9NC8pGm3MOsfuhooIQaICMtMl6ZuzNQUJjCaTZfj7YI+RdGejGibKr/uyPY22OjTTUblMM4Ske+52usaXr8qIa2YsLEchOVWobpTy7XFYxyc9nhrK/urK3sQDlgn1V8nbQxBIL3oRjcxXi5xf2Ja2A7cl86IEzfBG5MnYmFVHcfq2qfPGX3NDrnXYuIuP3PnOp4vqU9UoSz1gYb59TkuEiimumXVv9X9R9yDoAUrQQmlhgue30qSTjS8Id7fosoREKr1NaeY1DfFGQXb7KyGicge7tPVlhFhYT3KZytifMQN/SKRrsrEApt0sOEgf6oppQxliliJPXnt5dgH3ef77W0mvfm8/bTBQ1EhdWpoKFhorPFIT889ofHMoMVfVrelGzzLIIb2BBZqHDaiwtZ0fj7cYQ/1CeqjRd4jo+wAl/jnRC4hAoX3FqApFQpxnqnxz/qPqT/kpIGEq4AoCvLPulJVY5B0iHQEdF47WL+paaMBpn1FDVHnGBUrdFbP3P77DVAp3heMUmkXlpKQSWm99OSIyiiZh5XoY5CMCwrXIWKX0R5CWIyoL4W5LksVYz0Ltps2BtDB1Zv+q8PnJ94iZ2qriK8fhyslE/RuOnpTIIgs1Poma2JIIaJvdQ+0PxJAw==","비밀번호":"1q2w3e4r!!"}},"SEND_DATA":{"DOC_PRD_CD":"711120000","DOC_BPR_SEND_LEVEL":"1","DOC_REQ_NO":"99999","DOC_TRANS_YN":"Y","DOC_BPR_SEND_YN":"Y","DOC_BPR_INF_KIND":"LOAN","organName":"정부24","docName":"지방세납세증명서","docId":"GOV24_JIBANGSENAB","DOC_KIND":"GOV24_JIBANGSENAB"},"DOC_KIND":"GOV24_JIBANGSENAB"}*/
             
         
    
    /*var params = {
        "useProgress": false,
        "scrapingSignType": "JointCert", // SSign: 신한인증서, JointCert: 공동인증서, IDPW: 아이디, 패스워드
        "tasks": [
            {
                "SCRAP_DATA":
                {
                    "서비스명":"건강보험_자격득실확인서_신한은행",
                    "기관코드":"904",
                    "기관명":"건강보험공단",
                    "타임아웃":"120",
                    "개인정보공개여부":"N",
                    "DOC_KIND":"NHIS_JAGEOK",
                    "인증서": {
                        "인증서파일": "MIIFrjCCBJagAwIBAgIELyMC3zANBgkqhkiG9w0BAQsFADBSMQswCQYDVQQGEwJrcjEQMA4GA1UECgwHeWVzc2lnbjEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRowGAYDVQQDDBF5ZXNzaWduQ0EgQ2xhc3MgMzAeFw0yMjA5MjkxNTAwMDBaFw0yMzA3MDUxNDU5NTlaMHExCzAJBgNVBAYTAmtyMRAwDgYDVQQKDAd5ZXNzaWduMRQwEgYDVQQLDAtwZXJzb25hbDRJQjEMMAoGA1UECwwDU0hCMSwwKgYDVQQDDCPrsJXsoJXquLgoKTAwODgwNDYyMDIyMDcwNTE4ODAwMjkwMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAI5go0itZV7ec0+QQT8v9bZwUfs/6/4ChXyNCP3wgBkfcQXquEm2vevXtipiKik1SdkQgm6LdtPpqIg/gmecRr5TSq04C705MEBSOmBzG/Zu0inZRddXw0hG9H50pIbSH0c3ytuc/xmqGCu+NEL98REtOY2Jg/ZUMWYfdRpbe2AFNOtB7PaMcUJugVB2TUUEP2LwrMxpMgJGP+9E4QOSzFGPeAy8ljzTeELtB+AcLGagaxWDEsYHddvFNxZ3yGR2EDHNGLoexNKggcVhnH/Gg4xMJF0jGnjoDcULQT123xYEdeh4D+PqOiBa/b+rj6zgzWTFLDhubWUclKRlhVlw66MCAwEAAaOCAmswggJnMIGPBgNVHSMEgYcwgYSAFPKHo+bZXhYWck7YwryFOQM3WZDEoWikZjBkMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEWMBQGA1UEAwwNS0lTQSBSb290Q0EgNIICECgwHQYDVR0OBBYEFNGP1+lu3Cv8RxYb3+uAEAuMV3nOMA4GA1UdDwEB/wQEAwIGwDCBjAYDVR0gAQH/BIGBMH8wfQYJKoMajJpFAQEEMHAwQAYIKwYBBQUHAgIwNB4yx3QAIMd4yZ3BHLKUACCuCMc1rLDIHMbQxdDBHAAgvByuCdVcACDHeMmdwRzHhbLIsuQwLAYIKwYBBQUHAgEWIGh0dHA6Ly93d3cueWVzc2lnbi5vci5rci9jcHMuaHRtMGgGA1UdEQRhMF+gXQYJKoMajJpECgEBoFAwTgwJ67CV7KCV6ri4MEEwPwYKKoMajJpECgEBATAxMAsGCWCGSAFlAwQCAaAiBCCls9K+sIC3t5JWRoaT/Bgmdzzmd1mKep5Ck7qjhzDExTBxBgNVHR8EajBoMGagZKBihmBsZGFwOi8vZHMueWVzc2lnbi5vci5rcjozODkvb3U9ZHA2cDIxOTAsb3U9QWNjcmVkaXRlZENBLG89eWVzc2lnbixjPWtyP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3QwOAYIKwYBBQUHAQEELDAqMCgGCCsGAQUFBzABhhxodHRwOi8vb2NzcC55ZXNzaWduLm9yZzo0NjEyMA0GCSqGSIb3DQEBCwUAA4IBAQAi7zlPN2KN2D6qP7yctaym+INZe07TYKCT2hWuBBUo8rnSCzpRN1L1s/FX3bYm0uKv4IsTilhKZAtqedMJNHylaUAyvmyBpZOCcrcFp/pfcJWg+Om+LV2/JrRhBk+VGKDnOUbELJnKEXOOlgv03uuQD8xkzmD77i9gSOMGGeojGSApRgqAtX0fx6NzCYDR+mR01KXtZAAGCRsIUlBd+bg63vsja412weTw/E/EAQ4/wTuPI/KLZwfQrbzqi+kQik0bRo+1UO7651WSEaC5hVLBUZa3njFd4u7FHL+5bSdMduitBtHth8U0diN+SjGgHI4uv6Rq33rH1oyv3Gk0+PLw",
                        "인증서키파일": "MIIFEDAaBggqgxqMmkQBDzAOBAg8CcgT5s0PsgICCAAEggTw8stLAKbfI6dc/PoWYoniOpjFUILPBO3h/kE9Tg/uXTHs1OsFXHpoIHdJjjJ4etbNsUQtOnSM2tP/8KrBKuVl+gdK/ETqcGxktuqxPXf+knFZ/GjASW8blqjay4OaHj9IxyA09pwDJwNrn9mJDmSBlAfvYyX8jHfDnMaO7DbnQI/mtMH7ajcmNkdOit2QzbXt/o6KT2qACzV+8md4N9/l+56Ln7wd1Xbm22wTVmkReFEQXNuCBOHkZmwUX5Sp4KxeGMKzUxMXvnIiT0NMWF3RAsnXxF1NH0N6kgD1/H4btVzhi88rpsKsgLvDuy2Y5DcXhZvD38GvwCYNNa7aYZhbUJDC0D9m9/BV8Orc2b7NkVezJSnghUHmfKAPTVJbgBoabFsSmG0aIQbTgG5Mj6UzLW3m4USuSEM6fwZk3S8AwcUX+whhWHLx4KadanXLFroG6TVFdQxItr8czBTkDmacVEoD2syM3AY/pB3kkmEgj79iAbwz2gEDzNFZcR8JgVHMorhyz7yswUEV7oeDOcRDlfH54GQYEP78ayxpB7qMXi1S3ecbMWwj8DKWf5UUSM8exK8k7f7HIgSfw7rmptODZCe67mIrsIdW2DswENf2nvJ7+CUYJC9HyvYGM6NLNEW32nIzoxeOPABUsNu6Epvhjnpmw2ZmerHlyCXuo7k5Uul5ieFwl+fdhtm1txttFFuN8iq5cbtfNdM7Hiwe1l7ygA489NyePsJ7uj0L+fTnvz9MMPqWTsNuVg5pn+3coWiEZ3YEgJCCmHRScLYCqNVGQ1A6Y7aiyCFGZh8MzjAAkR9CKCI2utZ+K6T1V6/dHWEj12EgN6WUqAr43kN2tUe9XjpN7IJX05VWx8vMWGgF6gqwzkKEKTpplnePCwkpQC49X03qXNMnMTIvRd7gCk6G8IFwZiuC+YPy28+xSz62GwwKcyu9w1PyNTqjS5j9BR7OBKR7yemCa/JnF+YzP28KPDURzGMkAC4EFMjkrnJ4nECbpBLDWWnlCwjUSOUcueyXc06FMEKTlg8W0m19pi8Jb1PA0GmBRcipwwmiixVfE2wWzEEdcjeq6QudvwZQAzGcDEJSX+wKnCn+MH59TZNs4KlmXAT+gp3Ud7tPdKMdBfhsZ+3omyo6kbiEzUqmXx9KOtUmJP7CCc3GBXVt1OfaQ9CuLw7EdB972UGfhOB7KaLF9m2FQSzFBt2rQI1Y69WqFOlNSSv9VcLY7ZG4vj+v0TTJ8ixcVIDOuUA+F/O/oC/zHK8WohYc5pdJljPOyM6GPi5INpj2lAED61is3+fHTyxXVcxXzFzTqktjexyHJ7uWiYUkErnXA6+g7FhiompTewNtRwo6au8eTOdJXdaVKJE6yHhjfxyE6XipMcnQGf2quUtFbLxQ8zShovhRirrEZ+JdDP/6J6aLRwp23cR8dofwg6xTuWksm/Vj39LXJ9OiPrzcCwEFZn9MVeYAK1kjqPamACSFl1otDprfa1TumnSk698yXowpeUhLu170ujhYCPbiscREHx5zHZRHgTg3WG6hFegs10Kl3PNeylM2/vKBeuCTl645rbTZxBRzKQhe3oQejjkr7oGdbCsq1veScOnTYBNgVWBx8xED8TQoImy95iT5vmVMzY2B95OAdBNnYsF0IY3ob69R51mEB9DA5AU1pQtu4vcwP3FKcm1OQw==",
                        "비밀번호": "1q2w3e4r!!"
                    }
                },
                "SEND_DATA":
                {
                    "DOC_PRD_CD":"612412200",
                    "DOC_BPR_SEND_LEVEL":"1",
                    "DOC_REQ_NO":"99999999",
                    "DOC_TRANS_YN":"Y",
                    "DOC_BPR_SEND_YN":"Y",
                    "DOC_BPR_INF_KIND":"LOAN",
                    "organName":"국민건강보험",
                    "docName":"자격득실확인서",
                    "docId":"NHIS_JAGEOK",
                    "DOC_KIND":"NHIS_JAGEOK"
                },
                "DOC_KIND":"NHIS_JAGEOK"
            },
            {
                "SCRAP_DATA":
                {
                    "서비스명":"건강보험_납부확인서_신한은행",
                    "기관코드":"904",
                    "기관명":"건강보험공단",
                    "타임아웃":"120",
                    "조회시작일":"",
                    "조회종료일":"",
                    "개인정보공개여부":"N",
                    "DOC_KIND":"NHIS_NABBU",
                    "인증서": {
                        "인증서파일": "MIIFrjCCBJagAwIBAgIELyMC3zANBgkqhkiG9w0BAQsFADBSMQswCQYDVQQGEwJrcjEQMA4GA1UECgwHeWVzc2lnbjEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRowGAYDVQQDDBF5ZXNzaWduQ0EgQ2xhc3MgMzAeFw0yMjA5MjkxNTAwMDBaFw0yMzA3MDUxNDU5NTlaMHExCzAJBgNVBAYTAmtyMRAwDgYDVQQKDAd5ZXNzaWduMRQwEgYDVQQLDAtwZXJzb25hbDRJQjEMMAoGA1UECwwDU0hCMSwwKgYDVQQDDCPrsJXsoJXquLgoKTAwODgwNDYyMDIyMDcwNTE4ODAwMjkwMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAI5go0itZV7ec0+QQT8v9bZwUfs/6/4ChXyNCP3wgBkfcQXquEm2vevXtipiKik1SdkQgm6LdtPpqIg/gmecRr5TSq04C705MEBSOmBzG/Zu0inZRddXw0hG9H50pIbSH0c3ytuc/xmqGCu+NEL98REtOY2Jg/ZUMWYfdRpbe2AFNOtB7PaMcUJugVB2TUUEP2LwrMxpMgJGP+9E4QOSzFGPeAy8ljzTeELtB+AcLGagaxWDEsYHddvFNxZ3yGR2EDHNGLoexNKggcVhnH/Gg4xMJF0jGnjoDcULQT123xYEdeh4D+PqOiBa/b+rj6zgzWTFLDhubWUclKRlhVlw66MCAwEAAaOCAmswggJnMIGPBgNVHSMEgYcwgYSAFPKHo+bZXhYWck7YwryFOQM3WZDEoWikZjBkMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEWMBQGA1UEAwwNS0lTQSBSb290Q0EgNIICECgwHQYDVR0OBBYEFNGP1+lu3Cv8RxYb3+uAEAuMV3nOMA4GA1UdDwEB/wQEAwIGwDCBjAYDVR0gAQH/BIGBMH8wfQYJKoMajJpFAQEEMHAwQAYIKwYBBQUHAgIwNB4yx3QAIMd4yZ3BHLKUACCuCMc1rLDIHMbQxdDBHAAgvByuCdVcACDHeMmdwRzHhbLIsuQwLAYIKwYBBQUHAgEWIGh0dHA6Ly93d3cueWVzc2lnbi5vci5rci9jcHMuaHRtMGgGA1UdEQRhMF+gXQYJKoMajJpECgEBoFAwTgwJ67CV7KCV6ri4MEEwPwYKKoMajJpECgEBATAxMAsGCWCGSAFlAwQCAaAiBCCls9K+sIC3t5JWRoaT/Bgmdzzmd1mKep5Ck7qjhzDExTBxBgNVHR8EajBoMGagZKBihmBsZGFwOi8vZHMueWVzc2lnbi5vci5rcjozODkvb3U9ZHA2cDIxOTAsb3U9QWNjcmVkaXRlZENBLG89eWVzc2lnbixjPWtyP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3QwOAYIKwYBBQUHAQEELDAqMCgGCCsGAQUFBzABhhxodHRwOi8vb2NzcC55ZXNzaWduLm9yZzo0NjEyMA0GCSqGSIb3DQEBCwUAA4IBAQAi7zlPN2KN2D6qP7yctaym+INZe07TYKCT2hWuBBUo8rnSCzpRN1L1s/FX3bYm0uKv4IsTilhKZAtqedMJNHylaUAyvmyBpZOCcrcFp/pfcJWg+Om+LV2/JrRhBk+VGKDnOUbELJnKEXOOlgv03uuQD8xkzmD77i9gSOMGGeojGSApRgqAtX0fx6NzCYDR+mR01KXtZAAGCRsIUlBd+bg63vsja412weTw/E/EAQ4/wTuPI/KLZwfQrbzqi+kQik0bRo+1UO7651WSEaC5hVLBUZa3njFd4u7FHL+5bSdMduitBtHth8U0diN+SjGgHI4uv6Rq33rH1oyv3Gk0+PLw",
                        "인증서키파일": "MIIFEDAaBggqgxqMmkQBDzAOBAg8CcgT5s0PsgICCAAEggTw8stLAKbfI6dc/PoWYoniOpjFUILPBO3h/kE9Tg/uXTHs1OsFXHpoIHdJjjJ4etbNsUQtOnSM2tP/8KrBKuVl+gdK/ETqcGxktuqxPXf+knFZ/GjASW8blqjay4OaHj9IxyA09pwDJwNrn9mJDmSBlAfvYyX8jHfDnMaO7DbnQI/mtMH7ajcmNkdOit2QzbXt/o6KT2qACzV+8md4N9/l+56Ln7wd1Xbm22wTVmkReFEQXNuCBOHkZmwUX5Sp4KxeGMKzUxMXvnIiT0NMWF3RAsnXxF1NH0N6kgD1/H4btVzhi88rpsKsgLvDuy2Y5DcXhZvD38GvwCYNNa7aYZhbUJDC0D9m9/BV8Orc2b7NkVezJSnghUHmfKAPTVJbgBoabFsSmG0aIQbTgG5Mj6UzLW3m4USuSEM6fwZk3S8AwcUX+whhWHLx4KadanXLFroG6TVFdQxItr8czBTkDmacVEoD2syM3AY/pB3kkmEgj79iAbwz2gEDzNFZcR8JgVHMorhyz7yswUEV7oeDOcRDlfH54GQYEP78ayxpB7qMXi1S3ecbMWwj8DKWf5UUSM8exK8k7f7HIgSfw7rmptODZCe67mIrsIdW2DswENf2nvJ7+CUYJC9HyvYGM6NLNEW32nIzoxeOPABUsNu6Epvhjnpmw2ZmerHlyCXuo7k5Uul5ieFwl+fdhtm1txttFFuN8iq5cbtfNdM7Hiwe1l7ygA489NyePsJ7uj0L+fTnvz9MMPqWTsNuVg5pn+3coWiEZ3YEgJCCmHRScLYCqNVGQ1A6Y7aiyCFGZh8MzjAAkR9CKCI2utZ+K6T1V6/dHWEj12EgN6WUqAr43kN2tUe9XjpN7IJX05VWx8vMWGgF6gqwzkKEKTpplnePCwkpQC49X03qXNMnMTIvRd7gCk6G8IFwZiuC+YPy28+xSz62GwwKcyu9w1PyNTqjS5j9BR7OBKR7yemCa/JnF+YzP28KPDURzGMkAC4EFMjkrnJ4nECbpBLDWWnlCwjUSOUcueyXc06FMEKTlg8W0m19pi8Jb1PA0GmBRcipwwmiixVfE2wWzEEdcjeq6QudvwZQAzGcDEJSX+wKnCn+MH59TZNs4KlmXAT+gp3Ud7tPdKMdBfhsZ+3omyo6kbiEzUqmXx9KOtUmJP7CCc3GBXVt1OfaQ9CuLw7EdB972UGfhOB7KaLF9m2FQSzFBt2rQI1Y69WqFOlNSSv9VcLY7ZG4vj+v0TTJ8ixcVIDOuUA+F/O/oC/zHK8WohYc5pdJljPOyM6GPi5INpj2lAED61is3+fHTyxXVcxXzFzTqktjexyHJ7uWiYUkErnXA6+g7FhiompTewNtRwo6au8eTOdJXdaVKJE6yHhjfxyE6XipMcnQGf2quUtFbLxQ8zShovhRirrEZ+JdDP/6J6aLRwp23cR8dofwg6xTuWksm/Vj39LXJ9OiPrzcCwEFZn9MVeYAK1kjqPamACSFl1otDprfa1TumnSk698yXowpeUhLu170ujhYCPbiscREHx5zHZRHgTg3WG6hFegs10Kl3PNeylM2/vKBeuCTl645rbTZxBRzKQhe3oQejjkr7oGdbCsq1veScOnTYBNgVWBx8xED8TQoImy95iT5vmVMzY2B95OAdBNnYsF0IY3ob69R51mEB9DA5AU1pQtu4vcwP3FKcm1OQw==",
                        "비밀번호": "1q2w3e4r!!"
                    }
                },
                "SEND_DATA":
                {
                    "DOC_PRD_CD":"612412200",
                    "DOC_BPR_SEND_LEVEL":"1",
                    "DOC_REQ_NO":"99999999",
                    "DOC_TRANS_YN":"Y",
                    "DOC_BPR_SEND_YN":"Y",
                    "DOC_BPR_INF_KIND":"LOAN",
                    "organName":"국민건강보험",
                    "docName":"장기요양보험료납부확인서",
                    "docId":"NHIS_NABBU",
                    "DOC_KIND":"NHIS_NABBU"
                },
                "DOC_KIND":"NHIS_NABBU"
            }
        ]
    };*/
    
    var params = {
        "useProgress": false,
        "scrapingSignType": "JointCert", // SSign: 신한인증서, JointCert: 공동인증서, IDPW: 아이디, 패스워드
        "tasks": [
                  {
                      "SCRAP_DATA": {
                          "서비스명": "정부24_주민등록등본",
                          "기관코드": "906",
                          "기관명": "정부24",
                          "타임아웃": "120",
                          "주소1": "경기도",
                          "주소2": "양주시",
                          "옵션1": "02",
                          "옵션2": "01",
                          "옵션3": "02",
                          "옵션4": "01",
                          "옵션5": "02",
                          "옵션6": "01",
                          "옵션7": "01",
                          "옵션8": "01",
                          "옵션9": "02",
                          "원문데이터포함여부": "",
                          "주소검색": "",
                          "PDF포함여부": "Y",
                          "개인정보공개여부": "Y",
                          "DOC_KIND": "GOV24_JUMIND2",
                          "인증서": {
                              "인증서경로": "",
                              "인증서파일": "nJb83d0gnS6uDi3ZYdciuCfcuAWWR87RjMiLpERIo8kBQ9tj7mawzf+faZF2gBUe;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",
                              "인증서키파일": "JN83G1Os1t7U+4o5jiaE89dfgDbAjnWoL3WQXuhRB+wBQ9tj7mawzf+faZF2gBUe;22QRelg70pSkBzaKelk2tIYHg+c2Tzukz/nhLGQWxaomWWAv2+SIA33FrxhVBoocUKMVVlS0JK6M68CcvCW4CYspbmC0Y9QpDgiZXVlT4K/+llYFqeI0U8sl3H8MfQBKEduKBwmaau/zqDWJj6phqXLPJVkRMN9lD7bZlQd5VcBEzmomTnsUKt9DI0Ib+B7aRSyClgiMAsi/UndYX98Xyv9906RwbUYAHcA034zjLL10FG0WXik0mJ68vqoL1huMOhGKM53nuvaSx3CE0AQIfkM9pmU58mEaUrm0XLYdwxJVZufnlOzB8FfwoOQYoNxWXdvUGyVbyZrt4URoe4J5mquHg/sjKcg0gMQcRluofciuzUpxp/PapwPEiBS2ps4AtuR9DSXlG2yuV71IuoCB2LC5mizTVjAk9boyudF6Buzv1LVn+taujSJSbUA71zgajiLr4gO2pbttqJ/6jqanL5v5ad/hnuJlmaq8HPn0hUcHLEooDqL/uKknGGclI8yws2JVJrlFhUr/7ybFtY5+RA6L5OQDFQKVLiKIl5tuUFQQ7BoEJ+lmkqS/YwzFM1gVkt95fTfwfYy/Nch9f7AsYfgX/cB6zu1L931nWIGT+WrBJ4JOyoBd8VMjjS87yHOsYwd0TUuTgQM9Fk9PR4OCda4r0+YtZtnPycjK67NvHmYYz5lUzN0ESTVZDv7tMVIOBanyS/FELj4mVd05W0vhOPsSc5qO8DfxrnbIdyTrYXraIuDyU1gzgqq1MsRL8kNgFlfiQN+pqX9E6M8AR7Me3KzkBRD4T+gbkgyo+mDSjoG2Pj60Ms3g9WD34YzWUYqclwSCyCG39LOu/H7AacJZ+r0QUoXhuBaRnlIoBqJKGmOM39+WALdX2DXUCBLRoD/vcVCTp+wN4txM0MhpphcMICW4O65wexEll03MA7kVzFCrbtM4YGXx24XfEOoKc3Sn9umx7E6UkzcNqzaXf4Sn6MB9e6jvwRmMgb2Rj0dHtKNWwcD9Wgk3Cv1W5DuSgleLd3Js+qy4dGD02ZU2UHYxP3cNJEHSOURoAdWVYfzHIMsCG96yx4cqlxGg2zlYAx9iuBe3wg8W/0G3An2f6PR3pDpVNfks0mQb1ovjufPZucYyHihbfOH2lraiDT5GMDY/dY3HM5B6Q9Dq+yLz/neCK49fLkWhT4gxd5FghifnlZa9RXrfMQfSKDX02nWILtGhSV0QFDEwCgfANUfJNtYNm07D3iZnKwyTWfieej9xf5vLULiP2KfGxj3lJ9Jo3Tp4DEI1Dk+hN+5FIFvtMIORcgxo0/1iwE6ZKOh7oWexNRzTuHtgVYr0ExjlKVbLIDWUmDnryKp708V3fbTg8gEmNh8NENIqFUs9vpinCMrFFY2oPOFvn7wBwzGOrne1TNcyZXVRrZkHRuWhnVDsoAcQT7p+j9cfw7kCCr1u1iuThGGiUGsZNQ3NsAUboz+TyUFHoDNDW+E2RHT3lPp+Ilz0l7vo3LC/DiKNr/6Qaxtzv9g1lkm4qt31PqUJ0sCTQaB/9p97IHOJRtCcQLagoJiZzPIpZPYFKR1Ov691mOzQtTO6b/S+wio+0/CSVVT8gKxNVOGIaJEoH6WRCuT0d8XKjviu4ylE/xcTgKjI0l4nyCwZBj2dg/7YUp7gUZZVAoSM9tRrxVLm8sJFAmhZNGPNP0E7u7oJ0cTjyh3/frLxCGI+t3pmb7spguoDRBCgp7ztZ6aXI89UhR7U7wD+/FJOayRtAJ4KBzbU9/GcW8ftBYhnMsBiw8+yCOKGbIa5B/DNweflo6R8WBi8zpnNoLKB35oIN0NPewbSPfqDPmps/yhZbTXfBcsLS59YtPePzXudd7p1mtQGK36m8Wk24nkdtK7W1oGN2zSbLtw5iH2kDIWDqqV8G1wkrkbZUbeQeHfZqDZ0hDKJbC0pZbNazCWBaN0Hq4x9l8/uIeEDApNB1YjV5H4qpgDl1aP3UYo9jlFjKaRfDMBi53+dTzl5+6HXWsBPgPJEJpm46OPc3h4w/bxC9XxNNP7epbflkV+hz3R3SEzAabiyEzFdtlfUvaddGLbaJZNOZnQ2OcxcfnMSkuGlGaQuKiOb14moO/gx38RPUrrcGYFmxAixfvTCTOhJE4ccaNGazav3UdjOpAQzM6t/U0lKx/lec/CoMBO+jI7PuS9E+zQIV3KSdVreIMBE+rNnfIWrMXtqqipIzv1IkDNUieHSfcdwhZd2yyy1H5bC5+qRRx+i/JLP//zj/fKK/izfxbqanHt1rCUoYLQQuJ4WT9s8Qb91aiuZ6ToHbDwsvILGYKcv7OVSjnpsrOLnMQ==",
                              "비밀번호": "4KixKF1RVXRUdTYV+sNwBqINGojv6W6qBldM5h3cqMcBQ9tj7mawzf+faZF2gBUe;EKEhFJFqtkU16Iw59Kx+aA=="
                          },
                          "주민번호": "usADSLu6Jp11hNZNpVWbpRr4ieno72RK3sbDga1QSdEBQ9tj7mawzf+faZF2gBUe;zPG97kjj4jfwZSDn7B6cGg=="
                      },
                      "SEND_DATA": {
                          "DOC_PRD_CD": "614221100",
                          "DOC_BPR_SEND_LEVEL": "1",
                          "DOC_REQ_NO": "1132956712",
                          "DOC_TRANS_YN": "Y",
                          "DOC_BPR_SEND_YN": "Y",
                          "DOC_BPR_INF_KIND": "LOAN",
                          "organName": "정부24",
                          "docName": "주민등록등본",
                          "docId": "GOV24_JUMIND",
                          "DOC_KIND": "GOV24_JUMIND2"
                      },
                      "DOC_KIND": "GOV24_JUMIND2"
                  }
        ]
    };
    
    sendNativeAction("Scraping", "requestAndSave", params)
}

function pluginMobileOTP_getVersion() {
    var params = {
        "isIssue" : true
    };
    sendNativeAction("MobileOTP", "getVersion", params)
}
function pluginMobileOTP_issue() {
    var params = {
        "serialNumber": "512088000000001",
        "otpKey1": "AAAAAAAAAAAAAAAAAAAAAEOuq0XGl9zuK+avRrtR4Tg=",
        "otpKey2": "AAAAAAAAAAAAAAAAAAAAAHttB2dTZfkKqYAew4CK/yA="
    };
    sendNativeAction("MobileOTP", "issue", params)
}
function pluginMobileOTP_checkState() {
    var params = {
        "smartOtpVndrS3": "512088000000001",
        "otpSerS12": "otpSerS12",
        "COM_SEC_CHAL1": "5",
        "secrityMdiaInfS1": "31"
    };
    sendNativeAction("MobileOTP", "checkState", params)
}
function pluginMobileOTP_getIssueInfo() {
    var params = {};
    sendNativeAction("MobileOTP", "getIssueInfo", params)
}
function pluginMobileOTP_generate() {
    var params = {
        "otpTime": "D8C59AD8688DC9B62ADE5F8C42137B1C",
        "serialNumber": "512088000000001",
        "isEncrypt": true,
        "journalNo": "2CF24DBA5FB0A30E26E83B2AC5B9E29E1B161E5C1FA7425E73043362938B9824"
    };
    sendNativeAction("MobileOTP", "generate", params)
}
function pluginMobileOTP_getMOTPValidStatus() {
    var params = {
    };
    sendNativeAction("MobileOTP", "getMOTPValidStatus", params)
}
function pluginNavigator_preCheckProgramID() {
    var params = {
        "programId" : "BM1509S0401U01"
    };
    sendNativeAction("Navigator", "preCheckProgramID", params)
}
function pluginNavigator_goNextPage() {
    var params = {
        "programId" : "BM1509S0401U01",
        "data" : ""
    };
    sendNativeAction("Navigator", "goNextPage", params)
}
function pluginNavigator_goNextPage_allAccounts() {
    var params = {
        "programId" : "BM1501S0001F01",
        "data" : ""
    };
    sendNativeAction("Navigator", "goNextPage", params)
}
function pluginNavigator_goNextPage_associate() {
    var params = {
        "programId" : "EXTBRIDGE",
        "data": {
//            "title": "신한카드",
//            "url":  "?url=https%3A%2F%2Fm.shinhancard.com%3Fkey1%3Ddata1%26key2%3Ddata2"
            "title": "신한 마이카",
            "url": "?url=https%3A%2F%2Fmycar.shinhancard.com%2Fconts%2Fhtml%2Flimit%2FADPFM134%2FADPFM134A02.html"
        }
    };
    sendNativeAction("Navigator", "goNextPage", params)
}
function pluginNavigator_goNextPage_Ddang() {
    var params = {
        "programId" : "CO04000000243",
        "data" : ""
    };
    sendNativeAction("Navigator", "goNextPage", params)
}
function pluginNavigator_goNextPageByPost() {
    var params = {
        "url": "https://wapi.dev-zeropaypoint.or.kr/wapi/zpp/webview/v1/point/main",
        "method": "POST",
        "headers": {
            "Content-Type":"application/x-www-form-urlencoded",
            "Authorization":"BTzIaKhkB+sSGiTPNCrd3kG7to/T4LxcPedOf3F+Gh+aUgfIdvL7NKfSfYSkWBrc"
        },
        "data": "saleChannel=088&userNo=7dZa%2BROEEI3N9JWiYDOS7w%3D%3D&zpphash=2aOFjDaOouDjVcnMSI8tUnOnc10XniaP7OquoH6wufQ%3D"
    };
    sendNativeAction("Navigator", "goNextPageByPost", params);
}
function pluginNavigator_goPrevPageWithData() {
    var params = {
        "data" : "test data"
    };
    sendNativeAction("Navigator", "goPrevPageWithData", params)
}
function pluginNavigator_clearAndMove() {
    var params = {
        "programId" : "BM1509S0401U01",
        "data" : ""
    };
    sendNativeAction("Navigator", "clearAndMove", params)
}
function pluginNavigator_goToLogin() {
    var params = {
        "loginType" : "G"
    };
    sendNativeAction("Navigator", "goToLogin", params)
}
function pluginNavigator_goMain() {
    var params = {
        "mainType" : "1",
        "subType" : "2"
    };
    sendNativeAction("Navigator", "goMain", params)
}
function pluginNavigator_logout() {
    var params = {};
    sendNativeAction("Navigator", "logout", params)
}
function pluginNavigator_regStudentId() {
    var params = {
        "mainTitle" : "학생증 체크카드",
        "linkUrl" : "https://newm.shinhancard.com/mob/MOBIDCPHTN/IDCPHT01.shc?z="
    };
    sendNativeAction("Navigator", "regStudentId", params)
}
function pluginNavigator_closeApp() {
    var params = {};
    sendNativeAction("Navigator", "closeApp", params)
}
function pluginNetfunnel_checkNetFunnel() {
    var params = {
        "serviceCode": "service_4",
        "actionCode": "sol_login_1"
    };
    sendNativeAction("Netfunnel", "checkNetFunnel", params)
}
function pluginSecureData_encryptSplit() {
    var params = {
        "dataKey": "hello",
        "plainText": "안녕하세용"
    };
    sendNativeAction("SecureData", "encryptSplit", params)
}
function pluginSecureData_decryptJoin() {
    var params = {
        "dataKey": "hello",
        "halfCipherText": "oQLJfm6rP8hKmfgRgZNSKAfgeOnDlGMieAbzOdbJL6C+qFkru5k7AeWA8EKgmunK"
    };
    sendNativeAction("SecureData", "decryptJoin", params)
}
function pluginSecureData_delete() {
    var params = {
        "dataKeys": ["hello","key1","key2"]
    };
    sendNativeAction("SecureData", "delete", params)
}
function pluginSecureData_contains() {
    var params = {
        "dataKeys": ["key1","key2"]
    };
    sendNativeAction("SecureData", "contains", params)
}
function pluginSplunkMint_sendEvent() {
    var params = {
        "eventName": "testEventName",
        "extraData": {
            "key1": "value",
            "key2": "3",
        }
    };
    sendNativeAction("SplunkMint", "sendEvent", params)
}
function pluginSplunkMint_flush() {
    var params = {};
    sendNativeAction("SplunkMint", "flush", params)
}

function pluginZeropay_sendRequest() {
    var params = {
        "requestType": "400600",
        "qrcodeNo": "100000000",
        "approveNo": "123123",
        "zeroUserKey": "124125125",
        "amount": "1000",
        "accountNo": "12312324125125125",
        "residentNo": "901010",
        "acntAuthToken": "123jkdgadslkjf"
    };
    sendNativeAction("ZeroPay", "sendRequest", params)
}
var pluginZeropay_payOffline = (function () {
    var isQR = true;

    return function () {
        if (isQR) {
            var params = {
                "payOfflineType": "QR",
                "ep_account_no": "110-277-973187",
                "ep_resident_no": "900215",
                "ep_acnt_auth_token": "20220817SL0000000100052100999999",
                "ep_balance": "24,315",
                "native_pass_type": "scan",
            };
        } else {
            var params = {
                "payOfflineType": "QR_DATA",
                "ep_account_no": "110-435-291423",
                "ep_resident_no": "850823",
                "ep_acnt_auth_token": "",
                "ep_balance": "14,786,361",
                "native_pass_type": "scan",
                "qrcodeNo": "1-ZP-201811000263-M201811000000021--5bmu"
            };
        }
        sendNativeAction("ZeroPay", "payOffline", params)
        isQR = !isQR;
    }
})();
function pluginCapture_captureAndSaveToAlbum() {
    var params = {
        "type" : "screen" // "fullWeb"
    };
    sendNativeAction("Capture", "captureAndSaveToAlbum", params)
}
function pluginCapture_savePngImageToAppCache() {
    var params = {
        "imgData" : base64ImageString
    };
    sendNativeAction("Capture", "savePngImageToAppCache", params)
}
function pluginCapture_captureAndSaveToAppCache() {
    var params = {
        "type" : "fullWeb" // "screen"
    };
    sendNativeAction("Capture", "captureAndSaveToAppCache", params)
}
function pluginCapture_captureToBase64() {
    var params = {
        "isResize" : true
    };
    sendNativeAction("Capture", "captureToBase64", params)
}
function pluginLocation_getCurrentLocation() {
    var params = {};
    sendNativeAction("Location", "getCurrentLocation", params)
}
function pluginLocation_isPermissionForLocation() {
    var params = {};
    sendNativeAction("Location", "isPermissionForLocation", params)
}
function pluginBarcodeCreateBarcode() {
    var params = {"type": "code128", "data" : "https://shinhan.com" };
    sendNativeAction("Barcode", "createBarcode", params)
}

function pluginHash_getSHA256() {
    var params = { "originData": "AAAAAA" };
    sendNativeAction("Hash", "getSHA256", params)
}
function pluginHash_getMD5() {
    var params = { "originData": "SOL_SHINHAN_2018" };
    sendNativeAction("Hash", "getMD5", params)
}

function pluginPopup_makeToast() {
    var params = { "message": "Toast message" };
    sendNativeAction("Popup", "makeToast", params)
}
function pluginPopup_showCutomSpinner() {
    var params = {
        "title" : "예약시간 선택",
        "labels": ["오전 7~8시","오전 9~10시", "오전 11~12시", "오후 1~2시", "오후 3~4시", "오후 5~6시", "오후 7~8시", "오후 9~10시"]
    };
    sendNativeAction("Popup", "showCutomSpinner", params)
}
//////////////////////////////////////////////////////////////////////////
function callbackListener(message) {
    var response = document.getElementById("response")
    response.value = JSON.stringify(message, null, 4)
}

function getClipboardText() {
    var params = {
        "isEncrypt": true
    };
    otcBridge.sh.exec(success, fail, "Clipboard", "getClipboardText", params);
}
function setClipboardText() {
    var data = {
        "copyText" : "clipboard text!!!!",
        "toastText" : "복사되었습니다"
    };
    //var data = {};
    otcBridge.sh.exec(success, fail, "Clipboard", "setClipboardText", data);
}
function goPushSetting() {
    var params = {
//        "option" : "check_only" // go_always, go_if_disabled
        "option" : "go_always"
//        "option" : "go_if_disabled"
    };
    sendNativeAction("ExternalApp", "goPushSetting", params);
}
function startApp() {
    var params = {
        "ios" : "itms-apps://itunes.apple.com/app/id357484932"
    };
    sendNativeAction("ExternalApp", "startApp", params);
}
function searchApp() {
    var params = {
        //"ios" : "itms-apps://itunes.apple.com/app/id357484932"
        "ios" : "youtube://watch?v=someurl"
    };
    sendNativeAction("ExternalApp", "searchApp", params);
}
function installApp() {
    var params = {
        "ios" : "357484932"
    };
    sendNativeAction("ExternalApp", "installApp", params);
}
function createCommonShortcut() {
    var params = {
        "screenId" : "IN04010102001",
        "shortcutName" : "신한페이결제",
        "uniqueNum" : "IN04010102001",
        "imgName" : "0",
        "shortcutParam" : "key1=value1&key2=value2"
    };
    sendNativeAction("ExternalApp", "createCommonShortcut", params);
}
function callFinishCallback() {
    var params = {
        "telNo" : "010-7708-9853"
    };
    sendNativeAction("PhoneCall", "callFinishCallback", params);
}
function sendSMSWithCaptureImage() {
    var params = {
        "phoneNum" : "01031288401",
        //"message" : "https://devsol.shinhan.com/api/superPlatform/web/util/certTime.sp",
        "message" : "sendSMSWithCaptureImage Plugin Test",
        "imageYn" : "Y",
    };
    sendNativeAction("SMS", "sendSMSWithCaptureImage", params);
}
function sendSMSWithImage() {
    var params = {
        "phoneNum" : "01031288401",
        //"message" : "https://devsol.shinhan.com/api/superPlatform/web/util/certTime.sp",
        "message" : "sendSMSWithImage Plugin Test",
        "imgUrl" : "https://picsum.photos/200/300",
    };
    sendNativeAction("SMS", "sendSMSWithImage", params);
}

function getSingleContact() {
    var params = {
        "isGetThumbnail" : true
    };
    sendNativeAction("Contacts", "getSingleContact", params);
}
function getAllContacts() {
    var params = {
        "onlyMobile" : false,
        "isGetThumbnail" : true
    };
    sendNativeAction("Contacts", "getAllContacts", params);
}
// Phase 3 Mockup Functions
function pluginWebViewData_fetchData() {
    var params = {};
    sendNativeAction("WebViewData", "fetchData", params);
}
function pluginWebViewData_setValue() {
    var params = {
        "key1" : "value1",
        "key2" : "value2",
        "key3" : "value3"
    };
    sendNativeAction("WebViewData", "setValue", params);
}
function pluginWebViewData_getValue() {
    var params = {
        "keys" : ["key1", "key2", "key3"]
    };
    sendNativeAction("WebViewData", "getValue", params);
}
function pluginAppInfo_getDeviceInfo() {
    var params = {};
    sendNativeAction("AppInfo", "getDeviceInfo", params);
}
function pluginAppInfo_getAppInfo() {
    var params = {};
    sendNativeAction("AppInfo", "getAppInfo", params);
}
var pluginPicture_getPicture = (function () {
    var isAlbum = true;
    return function () {
        var params = {
            "sourceType" : isAlbum ? "album" : "camera",
            "resultType" : "data_and_path",
            "allowEdit" : true,
            "editAspectRatio" : 1.5,
            "maxWidth" : 1600,
            "maxHeight" : 1600,
            "quality" : 80
        };
        sendNativeAction("Picture", "getPicture", params)
        isAlbum = !isAlbum;
    }
})();
var pluginPicture_getDocumentPictures = (function () {
    var isMaxCountFive = true;
    return function () {
        var params = {
            "maxCount": isMaxCountFive ? 5 : 1,
            "cameraGuideText": "자동차 매매 계약서을 촬영해 주세요",
            "documentTitleText": "제출서류",
            "maxWidth" : 1600,
            "maxHeight" : 1600,
            "quality" : 80,
            "useDisplayConfirmPopup": false,
            "documentConfirmMessage": "주민번호 잘 찍어주세요\n\n보이면 넘어가주세요." // 옵션값: 안넣으면 주민번호 가리라는 메시지 팝업
        };
        sendNativeAction("Picture", "getDocumentPictures", params)
        isMaxCountFive = !isMaxCountFive;
    }
})();
function pluginPicture_downloadImageToAlbum() {
    var params = {
        "httpMethod": "GET",
        "imageUrl": "https://res.cloudinary.com/demo/image/upload/e_cartoonify/a_10/e_brightness:20/c_scale,h_250/dpr_2.0/f_auto/q_auto/actor.jpg"
    };
    sendNativeAction("Picture", "downloadImageToAlbum", params);
}
function pluginPicture_scanBill() {
    var params = {};
    sendNativeAction("Picture", "scanBill", params);
}
var pluginPicture_getDocumentOcrPictures = (function () {
    var isMaxCountFive = true;
    return function () {
        var params = {
            "maxCount": isMaxCountFive ? 5 : 1,
            "cameraGuideText": "자동차 매매 계약서을 촬영해 주세요",
            "documentTitleText": "확인서류 제출",
            "maxWidth" : 1600,
            "maxHeight" : 1600,
            "quality" : 80,
            "useDisplayConfirmPopup": true,
            "documentConfirmMessage": "주민번호 잘 찍어주세요\n\n보이면 넘어가주세요." // 옵션값: 안넣으면 주민번호 가리라는 메시지 팝업
        };
        sendNativeAction("Picture", "getDocumentOcrPictures", params)
        isMaxCountFive = !isMaxCountFive;
    }
})();
function pluginPicture_getIDCardPicture() {
    var params = {
        "maskingYn": "N"
    };
    sendNativeAction("Picture", "getIDCardPicture", params);
}
function pluginPicture_getPassportPicture() {
    var params = {
        "maskingYn": "N"
    };
    sendNativeAction("Picture", "getPassportPicture", params);
}
var pluginPicture_saveBase64ImageToAlbum = (function () {
    var isGifMimeType = true;
    return function () {
        var params = {
            "mimeType": isGifMimeType ? "image/gif" : "image/png",
            "imgData": isGifMimeType ? base64GifString : base64ImageString
        };
        sendNativeAction("Picture", "saveBase64ImageToAlbum", params)
        isGifMimeType = !isGifMimeType;
    }
})();

var pluginPDF_showPdfViewer = (function () {
    var buttonCount = 0;
    return function () {
        var buttonType
        switch(buttonCount % 4) {
        case 0:
            buttonType = "agree"
            break
        case 1:
            buttonType = "disagree"
            break
        case 2:
            buttonType = "twoButton"
            break
        default:
            buttonType = "empty"
            break
        }
        
        var params = {
            "buttonType": buttonType,
            "buttonTitle": [
                "미동의",
                "동의"
            ],
            "infoTxt": "info메이션입니다.",
            "dataType": "url",
            "title": "샘플 PDF",
            "url": "http://img.shinhan.com/sbank2016/yak/930000025_yak_20170113173113.pdf?1484296464028",
            "urlParam": "",
            "fileData": "",
            "isDownload": "y"
        };
        sendNativeAction("PDF", "showPdfViewer", params)
        buttonCount++;
    }
})();
var pluginPDF_downloadPDF = (function () {
    var isURL = true
    return function () {
        var params = {
            "fileName" : "123.pdf",
            "dataType" : isURL ? "url" : "data",
            "url" : "http://img.shinhan.com/sbank2016/yak/930000025_yak_20170113173113.pdf?1484296464028",
            "urlParam": "",
            "fileData": base64ImageString
        };
        sendNativeAction("PDF", "downloadPDF", params);
        isURL = !isURL;
    }
})();
var pluginPDF_showPdfMultiViewer = (function () {
    var buttonCount = 0;
    return function () {
        var buttonType
        switch(buttonCount % 4) {
        case 0:
            buttonType = "agree"
            break
        case 1:
            buttonType = "disagree"
            break
        case 2:
            buttonType = "twoButton"
            break
        default:
            buttonType = "empty"
            break
        }
        
        var params = {
            "buttonType": buttonType,
            "buttonTitle": [
                "미동의",
                "동의"
            ],
            "infoTxt": "info메이션입니다.",
            "dataType": "url",
            "title": "샘플 PDF",
            "fileData": "",
            "isDownload": "y",
            "pdfUrls": [
                {
                    "url": "http://img.shinhan.com/sbank2016/yak/930000025_yak_20170113173113.pdf?1484296464028",
                    "urlParam": ""
                },
                {
                    "url": "http://img.shinhan.com/sbank2016/form/930000158_form_20180629134735.pdf?1530247682972",
                    "urlParam": ""
                }
            ],
            "pdfDatas": [
                {
                    "fileData": "JVBERi0xLjMNCiXi48/TDQo........."
                },
                {
                    "fileData": "JVBERi0xLjYNJeLjz9MNCjM3IDAgb2........."
                }
            ]
        };
        sendNativeAction("PDF", "showPdfMultiViewer", params);
        buttonCount++;
    }
})();

function pluginBankID_reqVCSearch() {
    var params = {
        "reqData" : {
             "DATA_KEY_USE_SITE_CODE" : "00088",
             "DATA_KEY_USE_SVC_CODE" : "001",
             "DATA_KEY_ISSUE_SITE_CODE" : "00000",
             "DATA_KEY_VC_LEVEL" : "001",
             "DATA_KEY_VC_TASK" : "001",
             "DATA_KEY_VC_BIZ" : "00000000000000000000"
         }
    };
    sendNativeAction("BankID", "reqVCSearch", params);
}
function pluginBankID_reqVCIssue() {
    var params = {
        "clearData" : true,
        "api" : {
            "DATA_KEY_USE_SITE_CODE" :  "00088",
            "DATA_KEY_USE_SVC_CODE" : "001",
            "DATA_KEY_PHONE_NUMBER" : "01020220909",
            "DATA_KEY_DID_DOCUMENT" : "",
            "DATA_KEY_AUTH_TECH_CODE" : "116"
        },
        "request" : {
            "cusno" : "0475549433",
            "userId" : "amg6hka7yv2XkZM0Yc97HYT6jT8k5WZyGJjVMAjBhxm2kGcWAp8hCUaX/VduejpTekNqUoF+w0Zzbh607952bg==",
            "deviceId" : "72E19A8B3ED198D9B6EC9CE60A1543D1610F970DFE3FC1A802FAC5BB08247C02",
            "reissue" : "false",
            "vcTypeCode" : "bankid",
            "name" : "파팡창",
            "carrier" : "1",
            "birthdate" : "19541102",
            "postalCode" : "12248",
            "address" : "경기 남양주시 다산중앙로82번길 15",
            "addressDetail" : "0882큘 1973꼬 (흴큘욕, 꼬쿱쉥잽쩐탓쫬흴)",
            "email" : "BdsrCmVql@qJeqEhB.srC",
            "gender" : "1",
            "nationality" : "1",
            "phoneNumber" : "01020220909"
        }
    };
    sendNativeAction("BankID", "reqVCIssue", params);
}
function pluginBankID_reqVCRecover() {
    alert("해당 예제는 목업입니다.\n플러그인 구현 후 alert 제거해 주세요");
    var params = {
        "clearData" : true,
        "restoreData" : {
            "cusno" : "",
            "userId" : "",
            "deviceId" : "",
            "vcTypeCode" : "bankid",
            "phoneNumber" : "01020220909"
        },
        "reqData" : {
            "DATA_KEY_USE_SITE_CODE" : "",
            "DATA_KEY_USE_SVC_CODE" : "",
            "DATA_KEY_ISSUE_SITE_CODE" : "",
            "DATA_KEY_PHONE_NUMBER" : "",
            "DATA_KEY_VC_LEVEL" : "",
            "DATA_KEY_VC_TASK" : "",
            "DATA_KEY_VC_BIZ" : "",
            "DATA_KEY_AUTH_TECH_CODE" : "116"
        },
        "enroll" : {
            "cusno" : "",
            "userId" : "",
            "deviceId" : "",
            "vcTypeCode" : "bankid"
        }
    };
    sendNativeAction("BankID", "reqVCRecover", params);
}
function pluginBankID_reqVCRevoke() {
    var params = {
        "revoke" : {
            "cusno" : "0475549433",
            "userId" : "amg6hka7yv2XkZM0Yc97HYT6jT8k5WZyGJjVMAjBhxm2kGcWAp8hCUaX/VduejpTekNqUoF+w0Zzbh607952bg==",
            "vcTypeCode" : "bankid"
        },
        "api" : {
            "DATA_KEY_USE_SITE_CODE" : "00088",
            "DATA_KEY_USE_SVC_CODE" : "001",
            "DATA_KEY_ISSUE_SITE_CODE" : "00088",
            "DATA_KEY_VC_TASK" : "001",
            "DATA_KEY_VC_BIZ" : "00000000000000000000",
            "DATA_KEY_VC_LEVEL" : "001"
        }
    };
    sendNativeAction("BankID", "reqVCRevoke", params);
}
function pluginBankID_reqVCAuthMng() {
    var params = {
        "DATA_KEY_AUTH_FAIL_MSG" :  "",
        "DATA_KEY_ISSUE_CONTINUE" : true,
        "DATA_KEY_AUTH_TECH_CODE_IN_USE" : "",
        
        "reqData" : {
            "DATA_KEY_AUTH_MNG_CODE" : "1",
            "DATA_KEY_USE_SITE_CODE" : "00088",
            "DATA_KEY_USE_SVC_CODE" : "001",
            "DATA_KEY_ISSUE_SITE_CODE" : "00000",
            "DATA_KEY_AUTH_TECH_CODE" : "116",
            "DATA_KEY_MNG_AUTH_TECH_CODE" : "116"
        }
    };
    sendNativeAction("BankID", "reqVCAuthMng", params);
}
function pluginBankID_reqVCPrivacy() {
    var params = {
        "reqData" : {
            "DATA_KEY_USE_SITE_CODE" : "00088",
            "DATA_KEY_USE_SVC_CODE" : "001",
            "DATA_KEY_ISSUE_SITE_CODE" : "00000",
            "DATA_KEY_VC_LEVEL" : "000",
            "DATA_KEY_VC_TASK" : "000",
            "DATA_KEY_VC_BIZ" : "00000000000000000000",
            "DATA_KEY_VC_ID" : "d99a6616-8ba4-415a-81b4-b153120ef7af"
         }
    };
    sendNativeAction("BankID", "reqVCPrivacy", params);
}
function pluginBankID_reqVCUseSearch() {
    var params = {
        "reqData" : {
            "DATA_KEY_USE_SITE_CODE" : "00088",
            "DATA_KEY_USE_SVC_CODE" : "001",
            "DATA_KEY_ISSUE_SITE_CODE" : "00000",
            "DATA_KEY_VC_LEVEL" : "001",
            "DATA_KEY_VC_TASK" : "001",
            "DATA_KEY_VC_BIZ" : "00000000000000000000",
            "DATA_KEY_VC_ID" : "d99a6616-8ba4-415a-81b4-b153120ef7af",
            "DATA_KEY_START_DT" : "202203",
            "DATA_KEY_END_DT" : "202208"
        }
    };
    sendNativeAction("BankID", "reqVCUseSearch", params);
}
function pluginBankID_clearTokenCache() {
    var params = {};
    sendNativeAction("BankID", "clearTokenCache", params);
}
function pluginBankID_reqClearData() {
    var params = {};
    sendNativeAction("BankID", "reqClearData", params);
}

function pluginCalendar_showCalendar() {
    var params = {
        "selectedDate": "2022-09-06",
//        "minDate": "2021-12-01",
        "maxDate": "2022-09-06"
    };
    sendNativeAction("Calendar", "showCalendar", params);
}

function pluginQRCode_commQRReader() {
    var params = {
        "code": "LocalTax"
    };
    sendNativeAction("QRCode", "commQRReader", params);
}
function pluginCalendar_showYearMonthSpinner() {
    var params = {
        "minYearMonth" : "2020-02",
        "maxYearMonth" : "2022-10",
        "selectedYearMonth": "2022-05"
    };
    sendNativeAction("Calendar", "showYearMonthSpinner", params);
}
function pluginCalendar_showYearMonthDaySpinner() {
    var params = {
        "selectedDate": "2022-03-05",
        "minDate": "2000-01-01",
        "maxDate": "2022-04-01"
    };
    sendNativeAction("Calendar", "showYearMonthDaySpinner", params);
}
function pluginCalendar_showPeriodSpinner() {
    var params = {};
    sendNativeAction("Calendar", "showPeriodSpinner", params);
}
function pluginCalendar_setDataToNativeCalendar() {
    var params = {
        "description": "[대명에너지] IPO 공모주 청약일입니다.",
        "endTime": "2022.08.10",
        "title": "[대명에너지]",
        "alarm": "당일",
        "allDay": "YES",
        "repeat": "없음",
        "startTime": "2022.08.10",
        "location": "",
        "repeatEndTime": ""
    };
    sendNativeAction("Calendar", "setDataToNativeCalendar", params);
}
function pluginChatbot_inputVoice() {
    var params = {
        "supportDarkMode" : true
    };
    sendNativeAction("Chatbot", "inputVoice", params);
}

function pluginExternalFile_selectFile() {
    var params = {
        "fileTypes": [ "png", "pdf" ],
//        "fileTypes": [],
        "maxFileDataSize": 0
    };
    sendNativeAction("ExternalFile", "selectFile", params);
}

function pluginFinCert_getFinCertInfo() {
    var params = {};
    sendNativeAction("FinCert", "getFinCertInfo", params);
}
function pluginFinCert_setFinCertInfo() {
    var params = {
        "__pubkId": "pubkId",
        "FinSDKKey": "finSDKKey"
    };
    sendNativeAction("FinCert", "setFinCertInfo", params);
}
function pluginFinCert_getCertSeqNum() {
    var params = {};
    sendNativeAction("FinCert", "getCertSeqNum", params)
}
function pluginFinCert_getCertInitData() {
    var params = {};
    sendNativeAction("FinCert", "getCertInitData", params)
}

function pluginFaceDetect_authForRegister() {
    var params = {
        "isMaskRegister": false
    };
    sendNativeAction("FaceDetect", "authForRegister", params)
}
function pluginFaceDetect_authForMaskRegister() {
    var params = {
        "isMaskRegister": true
    };
    sendNativeAction("FaceDetect", "authForRegister", params)
}
function pluginFaceDetect_authForValidate() {
    var params = {};
    sendNativeAction("FaceDetect", "authForValidate", params)
}

function pluginIDCardCheck_getOCRData() {
    var params = {
        "type" : "idcard",
        "retake" : "Y",
        "req_key" : "reqKey",
        "stdnt" : "Y"
    };
    sendNativeAction("IDCardCheck", "getOCRData", params);
}
function pluginIDCardCheck_getImgData() {
    var params = {};
    sendNativeAction("IDCardCheck", "getImgData", params);
}
function pluginIDCardCheck_call2010Data() {
    var params = {
        "req_key":"20220905160534973853",
        "telecom":"",
        "tel_no":"01010001000",
        "image_type":"2",
        "user_name":"홍길동",
        "enc_cid":"850823",
        "drv_issued_dt":"20200504",
        "drv_no":"<BASE64=TGBTmM/YtQ3LrewtlmuHEw==>"
    };
    sendNativeAction("IDCardCheck", "call2010Data", params);
}
function pluginIDCardCheck_verifyVp() {
    var params = {
        "callScheme" : "https://mobileid.go.kr/verify.html?mode=direct&data=eyJtb2RlIjoiZGlyZWN0IiwiY2kiOmZhbHNlLCJob3N0IjoiaHR0cDo vLzEwLjAuMC4xNTk6NzIwMS9hcGlzL3YxIiwidHlwZSI6Im1pcCIsInZlcnNpb24iOiIxLjAuMCIsImNtZCI6IjIwMCIsInRyeGNvZ GUiOiIyMDIyMDcxMTE2MTQ1NTM3MUU1RThFQTIwIn0=&clientScheme=",
        "mobpkg" : "solMobileId",
    };
    sendNativeAction("IDCardCheck", "verifyVp", params);
}

function pluginKeyboard_hideTargetKeypad() {
    var params = {
        "targets" : [
            "os",
            "custom_all"
        ]
    };
    sendNativeAction("Keyboard", "hideTargetKeypad", params);
}

function pluginLoading_show() {
    var params = {
        "message": "로딩바에 표시될 메시지"
    };
    sendNativeAction("Loading", "show", params);
}
function pluginLoading_hide() {
    var params = {};
    sendNativeAction("Loading", "hide", params);
}

function pluginNoFaceAuth_getNoFaceAuthOfficeHours() {
    var params = {};
    sendNativeAction("NoFaceAuth", "getNoFaceAuthOfficeHours", params);
}
function pluginNoFaceAuth_goNoFaceAuth() {
    var params = {
        "data": {
            "menu_code": "050002",
            "menu_name": "입출금계좌신규",
            "login_yn": "Y",
            "cert_name": "",
            "user_no": "0741831215",
            "user_name": "홍길동",
            "tel_no": "01010001000",
            "phone_auth_no": "",
            "product_name": "쏠편한입출금통장",
            "product_cd": "12312312",
            "smart_pinpad_yn": "",
            "sel_idcard_type": "0",
            "step3_cert_type": "0",
            "callback_data": ""
//            "device_id": "293r8y23r34t34t34t34tesdfjsdhfgaert",
//            "app_name": "NewApp",
//            "pkg_name": "com.shinhan.sbanking2015",
//            "device_type": "I",
//            "device_model": "iPhone",
//            "app_code": "05",
//            "app_version": "8.4.9"
        }
    };
    sendNativeAction("NoFaceAuth", "goNoFaceAuth", params);
}
function pluginNoFaceAuth_getInitData() {
    var params = {};
    sendNativeAction("NoFaceAuth", "getInitData", params);
}
function pluginNoFaceAuth_endNoFaceAuthWithResult() {
    var params = {
        "result": {
            "key1": "value1",
            "key2": "value2"
        }
    };
    sendNativeAction("NoFaceAuth", "endNoFaceAuthWithResult", params);
}
function pluginNoFaceAuth_cancelNoFaceAuth() {
    var params = {
        "reqKey": "1234"
    };
    sendNativeAction("NoFaceAuth", "cancelNoFaceAuth", params);
}
function pluginNoFaceAuth_finishNoFaceAuth() {
    var params = {
        "reqKey": "1234"
    };
    sendNativeAction("NoFaceAuth", "finishNoFaceAuth", params);
}
function pluginNoFaceAuth_requestNoFaceAuthAPI() {
    var params = {
        "JsonData": {},
        "RequestCd" : "noface.NF0020"
    };
    sendNativeAction("NoFaceAuth", "requestNoFaceAuthAPI", params);
}

function pluginNoFaceSKeypad_showAccountPasswordKeypad() {
    var params = {};
    sendNativeAction("NoFaceSKeypad", "showAccountPasswordKeypad", params);
}
function pluginNoFaceSKeypad_hideKeypad() {
    var params = {};
    sendNativeAction("NoFaceSKeypad", "hideKeypad", params);
}

function pluginVoiceBanking() {
    var params = {};
    sendNativeAction("VoiceBanking", "test", params);
}

function pluginNLogger_sendEvent() {
    var params = {
        "eventName": "testEventName",
        "extraData": {
            "key1": "value",
            "key2": "3",
        }
    };
    sendNativeAction("NLogger", "sendEvent", params);
}

function pluginProduct_sendEvent() {
    var params = {
        "updateType": "myBasket"
    };
    sendNativeAction("Product", "refreshProductMain", params);
}

function pluginAllMenu_recentlyUsedMenu() {
    var params = {
        "programID": "SM0601S0021T01"
    };
    sendNativeAction("Menu", "recentlyUsedMenu", params);
}

function pluginOpenBanking_auth() {
    let authType = prompt("인증타입 입력\n3[지문], 4[패턴], 5[공동],\n8[금융], B[PIN], C[faceID],\nE[뱅크ID], G[신한]");
    var params = {
        "authType": authType
    };
    sendNativeAction("OpenBanking", "auth", params);
}

function pluginRaonFido_isSupportDevice() {
    var params = {};
    sendNativeAction("RaonFido", "isSupportDevice", params);
}
function pluginRaonFido_registerLoginMethod_Bio() {
    var params = {
        "loginMethod" : "C", // Bio
        "isRequired" : false
    };
    sendNativeAction("RaonFido", "registerLoginMethod", params);
}
function pluginRaonFido_registerLoginMethod_Pattern() {
    var params = {
        "loginMethod" : "4", // Pattern
        "isRequired" : false
    };
    sendNativeAction("RaonFido", "registerLoginMethod", params);
}
function pluginRaonFido_registerLoginMethod_Pin() {
    var params = {
        "loginMethod" : "B", // Pin
        "isRequired" : true
    };
    sendNativeAction("RaonFido", "registerLoginMethod", params);
}
function pluginRaonFido_checkAuthStatus() {
    var params = {};
    sendNativeAction("RaonFido", "checkAuthStatus", params);
}
function pluginRaonFido_checkBioAuthMethodRegistered() {
    var params = {};
    sendNativeAction("RaonFido", "checkBioAuthMethodRegistered", params);
}
function pluginRaonFido_getRaonFidoInfo() {
    var params = {};
    sendNativeAction("RaonFido", "getRaonFidoInfo", params);
}
function pluginRaonFido_isDeviceSecure() {
    var params = {};
    sendNativeAction("RaonFido", "isDeviceSecure", params);
}
function pluginRaonFido_registerFingerprintSOLPay() {
    var params = {};
    sendNativeAction("RaonFido", "registerFingerprintSOLPay", params);
}
function pluginRaonFido_authFingerprintSOLPay() {
    var params = {};
    sendNativeAction("RaonFido", "authFingerprintSOLPay", params);
}

function pluginShare_sendText() {
    var params = {
        "title": "신한은행 뉴앱",
        "text": "신한은행 뉴앱 전격 오픈!!!",
        "chooserTitle": "공유앱선택"
    };
    sendNativeAction("Share", "sendText", params);
}
function pluginShare_sendImage() {
    var params = {
        "imageData": base64ImageString,
        "chooserTitle": "공유앱선택"
    };
    sendNativeAction("Share", "sendImage", params);
}

function pluginSharedPlatform_open() {
    var params = {
        "programInfo": {
            "PROGRAM_URL" : "SPMN_BANK", // '신한플러스 이용등록' SPHB_SPCMUR00000001, SPMN_BANK 메인으로 이동
        },
        "PARAM": {
        }
    };
    sendNativeAction("SharedPlatform", "open", params);
}
function pluginSharedPlatform_isJoinedShinhanPlus() {
    var params = {};
    sendNativeAction("SharedPlatform", "isJoinedShinhanPlus", params);
}
function pluginSharedPlatform_isJoinedShinhanGroup() {
    var params = {
        "code": "INSURANCE" // 조회할 서비스 코드(BANK, CARD, INVEST, INSURANCE)
    };
    sendNativeAction("SharedPlatform", "isJoinedShinhanGroup", params);
}
function pluginSharedPlatform_requestOpenApi() {
    var params = {
        "code": "CARD", // 조회할 서비스 코드(BANK, CARD, INVEST, INSURANCE)
        "head": "",
        "body": "",
        "option": ""
    };
    sendNativeAction("SharedPlatform", "requestOpenApi", params);
}

function pluginShinhanSign_genCertCMP() {
    let cusNo = prompt("고객번호 입력");
    let cusName = prompt("고객명 입력");
    let refVal = prompt("참조번호 입력");
    let secretCode = prompt("인가코드 입력");
    let params = {
        "customerNumber": cusNo,
        "customerName": cusName,
        "referenceNumber": refVal,
        "authCode": secretCode
    };
    sendNativeAction("ShinhanSign", "genCertCMP", params);
}
function pluginShinhanSign_disuseCert() {
    let cusNo = prompt("고객번호 입력", "0928640794");
    let params = {
        "customerNumber": cusNo,
        "discardReason": "...."
    };
    sendNativeAction("ShinhanSign", "disuseCert", params);
}
function pluginShinhanSign_inquiryCert() {
    var params = {};
    sendNativeAction("ShinhanSign", "inquiryCert", params);
}
function pluginShinhanSign_regBio() {
    var params = {};
    sendNativeAction("ShinhanSign", "regBio", params);
}
function pluginShinhanSign_disuseBio() {
    var params = {};
    sendNativeAction("ShinhanSign", "disuseBio", params);
}
function pluginShinhanSign_checkBio() {
    var params = {};
    sendNativeAction("ShinhanSign", "checkBio", params);
}
function pluginShinhanSign_modifyAuth() {
    var params = {};
    sendNativeAction("ShinhanSign", "modifyAuth", params);
}
function pluginShinhanSign_inquiryExtRelayTran() {
    var params = {};
    sendNativeAction("ShinhanSign", "inquiryExtRelayTran", params);
}
function pluginShinhanSign_regSignMsg() {
    var params = {};
    sendNativeAction("ShinhanSign", "regSignMsg", params);
}
function pluginShinhanSign_inquiryCertUseHistory() {
    let cusNo = prompt("고객번호 입력");
    var params = {
        "customerNumber": cusNo,
        "searchStart": "20220801",
        "searchEnd": "20220930",
        "pageNum": 1,
        "pageRowNum": 10
    };
    sendNativeAction("ShinhanSign", "inquiryCertUseHistory", params);
}
function pluginShinhanSign_inquiryCertGenHistory() {
    let cusNo = prompt("고객번호 입력");
    var params = {
        "customerNumber": cusNo,
        "searchStart": "20220801",
        "searchEnd": "20220930",
        "pageNum": 1,
        "pageRowNum": 10
    };
    sendNativeAction("ShinhanSign", "inquiryCertGenHistory", params);
}
function pluginShinhanSign_getAllInfo() {
    var params = {};
    sendNativeAction("ShinhanSign", "getAllInfo", params);
}
function pluginShinhanSign_signData() {
    var params = {
        "certKeyAlias": "123123123123",
        "ranKey": "123123123123",
        "encDataList": [
            {
                "TRAN_ELSG_ONTT_CON": "원문1",
                "TX_ID": "1"
            },
            {
                "TRAN_ELSG_ONTT_CON": "원문2",
                "TX_ID": "2"
            }
        ]
    };
    sendNativeAction("ShinhanSign", "signData", params);
}
function pluginShinhanSign_regPattern() {
    var params = {};
    sendNativeAction("ShinhanSign", "regPattern", params);
}
function pluginShinhanSign_modifyPattern() {
    var params = {};
    sendNativeAction("ShinhanSign", "modifyPattern", params);
}
function pluginShinhanSign_disusePattern() {
    var params = {};
    sendNativeAction("ShinhanSign", "disusePattern", params);
}
function pluginShinhanSign_checkPattern() {
    var params = {};
    sendNativeAction("ShinhanSign", "checkPattern", params);
}
function pluginShinhanSign_getBasicAuthType() {
    var params = {};
    sendNativeAction("ShinhanSign", "getBasicAuthType", params);
}
function pluginShinhanSign_setBasicAuthType() {
    var params = {
        "basicAuthType": "2"
    };
    sendNativeAction("ShinhanSign", "setBasicAuthType", params);
}
function pluginShinhanSign_checkRegisteredCustomer() {
    let cusNo = prompt("고객번호 입력", "0658259789");
    var params = {
        "customerNumber": cusNo
    };
    sendNativeAction("ShinhanSign", "checkRegisteredCustomer", params);
}
function pluginShinhanSign_checkRelayTranInfo() {
    let cusNo = prompt("고객번호 입력", "0658259789");
    var params = {
        "customerNumber": cusNo
    };
    sendNativeAction("ShinhanSign", "checkRelayTranInfo", params);
}

function pluginBottomSheet_showSelectCertMethodBottomSheet() {
    var params = {};
    sendNativeAction("BottomSheet", "showSelectCertMethodBottomSheet", params);
}
function pluginSignature_electronicSign() {
    var params = {
//        "VIEW_TYPE": "half", /*half*/ /*full*/  /*full_desc*/
        "SIGN_DOC": {
            "signTitle" : "신한 MYCAR 대출",
            "signData" : "<내용>\n1.신한 MYCAR 대출 카드결제방식 보증한도조회를 신청합니다.\n  다음 사항을 충분히 이해하고 본인 신용정보의 제공 및 서울보증보험정보 조회 동의합니다.\n2. 신청내용\n(1)대출한도조회일자: 20220804\n(2)거래시간: 145922\n(3)성    명: 파눈유\n",
        },
        "certOnly" : "",
        "isFidoSign" : "Y",
        "isSHSign" : "Y",
        "withScraping" : "Y"
    };
    sendNativeAction("Signature", "electronicSign", params);
}
function pluginSignature_sendSignData() {
    var params = {
//        "VIEW_TYPE": "half", /*half*/ /*full*/  /*full_desc*/
        "SIGN_DOC": {
            "signTitle" : "전자서명 CertSign",
            "signData" : "대출한도 및 금리조회를 위해 다음 사항을 충분히 이해하고 본인 신용정보의 제공 및 조회에 동의하며 대출 신청을 진행합니다.\r\n1. 개인신용정보의 제공,조회 동의서 : 동의함\r\n2. 개인(신용)정보 수집, 이용, 제공 동의서(여신금융거래) : 동의함\r\n3. 신용정보 수집, 이용, 제공 동의서(재무제표 수집 등) : 동의함\r\n4. 개인(신용)정보 조회 동의서(통신관련정보) : 동의함\r\n5. [여신用] [공통선택]개인(신용)정보 수집·이용·제공 동의서(통신관련정보) : 동의함\r\n6. 서류제출 자동화 서비스 이용신청서(사업자用) : 신청함\r\n7. 신청내용\r\n (1)신청일자: 2022.08.03\r\n (2)거래시간: 17:14:47\r\n (3)성 명: 전화동 \r\n (4)신청정보: 쏠편한 사업자 대출 한도조회",
            "sendSignData" : "<?xml version='1.0' encoding='UTF-8'?><신청데이터 xmlns='https://www.dpaper.kr/apply/1.0' xmlns:dpaper='https://www.dpaper.kr/apply/1.0'><공통메타데이터><신청인>원마판</신청인><전자문서지갑주소>1rzKTgcixQm6CsJkqX3L6uFgxnkY5KELyoexrN9</전자문서지갑주소><신청일시>2022-08-08T13:24:27</신청일시><신청전자증명서 ID='1'><문서종류코드>30000100001</문서종류코드><문서종류명>주민등록표등본</문서종류명></신청전자증명서></공통메타데이터><전자증명서메타데이터><IN-주민등록표등본신청서 ID='1'><구분 코드='3'>주민등록표등본교부</구분><신청내용><주소변동사항 코드='02'>미포함</주소변동사항><세대구성사유 코드='01'>포함</세대구성사유><세대구성일자 코드='01'>포함</세대구성일자><현세대원의입적일 코드='01'>포함</현세대원의입적일><세대원의변동사유 코드='01'>모두포함</세대원의변동사유><세대원이름공개 코드='01'>포함</세대원이름공개><주민등록번호뒷자리 코드='01'>모두포함</주민등록번호뒷자리><세대주관계 코드='01'>포함</세대주관계><동거인 코드='01'>포함</동거인></신청내용><외국인여부>101</외국인여부><시도시군구선택><sidoNm>서울특별시</sidoNm><siggNm>강남구</siggNm><siggCode>32200003220124강남구</siggCode></시도시군구선택></IN-주민등록표등본신청서></전자증명서메타데이터></신청데이터>",
            "ecdwAdres" : ""
        },
        "certOnly" : "N",
        "isFidoSign" : "N",
        "isSHSign" : "Y",
        "withScraping" : "Y"
    };
    sendNativeAction("Signature", "sendSignData", params);
}
function pluginSignature_electronicSignPDF() {
    var params = {
        "VIEW_TYPE": "half", /*half*/ /*full*/  /*full_desc*/
        "P7_VALUE": "서버에서 생성된 데이터입니다.\n<내용>\r\n신한 MYCAR 대출 신차 보증한도조회를 신청합니다.\r\n다음 사항을 충분히 이해하고 본인 신용정보의 제공 및 서울보증보험정보 조회 동의합니다.\r\n\r\n1. 개인신용정보의 조회 동의 승인함. \r\n   서울보증보험정보 조회 동의 승인함.\r\n2. 신청내용\r\n (1)대출한도조회일자: 2022.08.04\r\n (2)거래시간: 15:07:06\r\n (3)성    명: 전화동",
        "PDF_INFO_LIST" : [
            {
                "code": "0",
                "value" : "6bb73def86ce20c2559e66ffe0e032660b4d3f7ea074cefd69fde6763b46de1a"
            }
         ],
        "certOnly" : "",
        "isFidoSign" : "Y",
        "isSHSign" : "Y",
        "withScraping" : "Y"
    };
    sendNativeAction("Signature", "electronicSignPDF", params);
}
function pluginSignature_electronicSignMulti() {
    var params  = {
        "certType":"cert",
        "data": [
            {
                "bEnc":"N",
                "name":"004",
                "original_data":"MIIBHAIBAgQQH3fSveZ28UTYD4zV0vua3zCBvwyBuOq4iOycteu2hOyVvCDrp4jsnbTrjbDsnbTthLAg7Ya17ZWp7J247Kad7J2EIOychO2VnCDsnbjspp3shJwg67O47J247ZmV7J24IOyEnOu5hOyKpCDsnbTsmqnslb3qtIAsIOqwnOyduOygleuztCDsspjrpqwsIOqzoOycoOyLneuzhOygleuztCDsiJjsp5HCt-ydtOyaqSDrsI8g7JyE7YOB7JeQIOuPmeydmO2VqeuLiOuLpC4DAgP4MDEMFElOSVNBRkVfVUNQSURfQ2xpZW50DAdJTklURUNIMBACAQICAQCgAwIBAKEDAgEADBB3d3cubXlkYXRhLmNvLmty"
            },
            {
                "bEnc":"Y",
                "name":"004_consent",
                "original_data":"eyJjb25zZW50Tm9uY2UiOiI4alFDM25KenZ6RUR1YUdmNWlIaEFBIiwiY29uc2VudCI6eyJyY3Zfb3JnX2NvZGUiOiJaVkFBRVIwMDAwIiwiZW5kX2RhdGUiOiIyMDIyMTAxMSIsInBlcmlvZCI6IjIwMjIxMDExIiwic25kX29yZ19jb2RlIjoiQTFBQUVPMDAwMCIsImlzX3NjaGVkdWxlZCI6ImZhbHNlIiwiZm5kX2N5Y2xlIjoiMS93IiwiYWRkX2N5Y2xlIjoiMS93IiwicHVycG9zZSI6IuyDgeyEuOygleuztCDsoITshqHsmpTqtazrpbwg7JyE7ZWcIOqwgOyeheyDge2SiOuqqeuhnSDsobDtmowiLCJ0YXJnZXRfaW5mbyI6W3sic2NvcGUiOiJiYW5rLmxpc3QifV19fQ=="
            }
        ],
        "desc":"마이데이터 멀티 전자서명을 진행합니다.\n1. 신청내용\n(1)신청일자: 2022.08.29\n(2)거래시간: 15:59:30\n마이데이터 멀티 전자서명을 진행합니다.",
        "withScraping" : "Y"
    };
    
    sendNativeAction("Signature", "electronicSignMulti", params);
}
function pluginSignature_electronicSignMulti_finCert() {
    var params  = {
        "certType":"finCert",
        "data": [
            {
                "bEnc":"N",
                "name":"011",
                "original_data":"MIIBHAIBAgQQxD1V8GiollUEraGl_dkmpDCBvwyBuOq4iOycteu2hOyVvCDrp4jsnbTrjbDsnbTthLAg7Ya17ZWp7J247Kad7J2EIOychO2VnCDsnbjspp3shJwg67O47J247ZmV7J24IOyEnOu5hOyKpCDsnbTsmqnslb3qtIAsIOqwnOyduOygleuztCDsspjrpqwsIOqzoOycoOyLneuzhOygleuztCDsiJjsp5HCt-ydtOyaqSDrsI8g7JyE7YOB7JeQIOuPmeydmO2VqeuLiOuLpC4DAgP4MDEMFElOSVNBRkVfVUNQSURfQ2xpZW50DAdJTklURUNIMBACAQICAQCgAwIBAKEDAgEADBB3d3cubXlkYXRhLmNvLmty"
            },
            {
                "bEnc":"Y",
                "name":"011_consent",
                "original_data":"{\"consentNonce\":\"xD1V8GiollUEraGl_dkmpA\",\"consent\":\"{\\\"rcv_org_code\\\":\\\"ZVAAER0000\\\",\\\"end_date\\\":\\\"20220905\\\",\\\"period\\\":\\\"20220905\\\",\\\"is_scheduled\\\":\\\"false\\\",\\\"fnd_cycle\\\":\\\"1/w\\\",\\\"add_cycle\\\":\\\"1/w\\\",\\\"purpose\\\":\\\"상세정보 전송요구를 위한 가입상품목록 조회\\\",\\\"target_info\\\":[{\\\"scope\\\":\\\"bank.list\\\"}]}\"}"
            },
            {
                "bEnc":"N",
                "name":"020",
                "original_data":"MIIBHAIBAgQQpQg6hHoH7jHpiHlsGJjc5TCBvwyBuOq4iOycteu2hOyVvCDrp4jsnbTrjbDsnbTthLAg7Ya17ZWp7J247Kad7J2EIOychO2VnCDsnbjspp3shJwg67O47J247ZmV7J24IOyEnOu5hOyKpCDsnbTsmqnslb3qtIAsIOqwnOyduOygleuztCDsspjrpqwsIOqzoOycoOyLneuzhOygleuztCDsiJjsp5HCt-ydtOyaqSDrsI8g7JyE7YOB7JeQIOuPmeydmO2VqeuLiOuLpC4DAgP4MDEMFElOSVNBRkVfVUNQSURfQ2xpZW50DAdJTklURUNIMBACAQICAQCgAwIBAKEDAgEADBB3d3cubXlkYXRhLmNvLmty"
                
            },
            {
                "bEnc":"Y",
                "name":"020_consent",
                "original_data":"{\"consentNonce\":\"pQg6hHoH7jHpiHlsGJjc5Q\",\"consent\":\"{\\\"rcv_org_code\\\":\\\"ZVAAER0000\\\",\\\"end_date\\\":\\\"20220905\\\",\\\"period\\\":\\\"20220905\\\",\\\"is_scheduled\\\":\\\"false\\\",\\\"fnd_cycle\\\":\\\"1/w\\\",\\\"add_cycle\\\":\\\"1/w\\\",\\\"purpose\\\":\\\"상세정보 전송요구를 위한 가입상품목록 조회\\\",\\\"target_info\\\":[{\\\"scope\\\":\\\"bank.list\\\"}]}\"}"
            }
        ],
        "desc": "마이데이터 멀티 전자서명을 진행합니다.\n1. 신청내용\n(1)신청일자: 2022.08.29\n(2)거래시간: 15:57:22\n마이데이터 멀티 전자서명을 진행합니다."
    };
    
    sendNativeAction("Signature", "electronicSignMulti", params);
}

function pluginSignature_electronicSign_half() {
    var params = {
        "SIGN_DOC": {
            "signTitle" : "신한 MYCAR 대출",
            "signData" : "<내용>\n1.신한 MYCAR 대출 카드결제방식 보증한도조회를 신청합니다.\n  다음 사항을 충분히 이해하고 본인 신용정보의 제공 및 서울보증보험정보 조회 동의합니다.\n2. 신청내용\n(1)대출한도조회일자: 20220804\n(2)거래시간: 145922\n(3)성    명: 파눈유\n",
        },
        "certOnly" : "",
        "isFidoSign" : "Y",
        "isSHSign" : "Y",
        "VIEW_TYPE": "half", /*half*/ /*full*/ /*full_desc*/
        "withScraping" : "Y"
    };
    sendNativeAction("Signature", "electronicSign", params);
}
function pluginSignature_electronicSign_full() {
    var params = {
        "SIGN_DOC": {
            "signTitle" : "신한 MYCAR 대출",
            "signData" : "<내용>\n1.신한 MYCAR 대출 카드결제방식 보증한도조회를 신청합니다.\n  다음 사항을 충분히 이해하고 본인 신용정보의 제공 및 서울보증보험정보 조회 동의합니다.\n2. 신청내용\n(1)대출한도조회일자: 20220804\n(2)거래시간: 145922\n(3)성    명: 파눈유\n",
        },
        "certOnly" : "",
        "isFidoSign" : "Y",
        "isSHSign" : "Y",
        "VIEW_TYPE": "full", /*half*/ /*full*/ /*full_desc*/
        "withScraping" : "Y"
    };
    sendNativeAction("Signature", "electronicSign", params);
}
function pluginSignature_electronicSign_full_desc() {
    var params = {
        "SIGN_DOC": {
            "signTitle" : "신한 MYCAR 대출",
            "signData" : "<내용>\n1.신한 MYCAR 대출 카드결제방식 보증한도조회를 신청합니다.\n  다음 사항을 충분히 이해하고 본인 신용정보의 제공 및 서울보증보험정보 조회 동의합니다.\n2. 신청내용\n(1)대출한도조회일자: 20220804\n(2)거래시간: 145922\n(3)성    명: 파눈유\n",
        },
        "certOnly" : "",
        "isFidoSign" : "Y",
        "isSHSign" : "Y",
        "VIEW_TYPE": "full_desc", /*half*/ /*full*/ /*full_desc*/
        "withScraping" : "Y"
    };
    sendNativeAction("Signature", "electronicSign", params);
}

var PluginSKeyPad_showAccountPasswordKeypad = (function () {
    var isUseForgotLink = true;
    return function () {
        var params = {
            "useForgotLink": isUseForgotLink ? true : false,
            "titleText": "계좌 비밀번호"
        };
        sendNativeAction("SKeypad", "showAccountPasswordKeypad", params);
        isUseForgotLink = !isUseForgotLink;
    }
})();
function PluginSKeyPad_showNewNumKeypad() {
    var params = {};
    sendNativeAction("SKeypad", "showNewNumKeypad", params);
}
function PluginSKeyPad_showNumKeypad() {
    var params = {
        "minInputLength": 4,
        "maxInputLength": 6,
        "useCancelOnTouchOutside": false,
        "encType": "se2e"
    };
    sendNativeAction("SKeypad", "showNumKeypad", params);
}
function PluginSKeyPad_showCharKeypad() {
    var params = {
        "minInputLength": 5,
        "maxInputLength": 16,
        "useCancelOnTouchOutside": false,
        "encType": "client"
    };
    sendNativeAction("SKeypad", "showCharKeypad", params);
}
var PluginSKeyPad_showCharEditKeypad = (function () {
    var isUseCancelOnTouchOutside = true;
    return function () {
        var params = {
            "minInputLength": 5,
            "maxInputLength": 16,
            "useCancelOnTouchOutside": isUseCancelOnTouchOutside ? true : false,
            "encType": "bigScrap"
        };
        sendNativeAction("SKeypad", "showCharEditKeypad", params)
        isUseCancelOnTouchOutside = !isUseCancelOnTouchOutside;
    }
})();
function PluginSKeyPad_hideKeypad() {
    var params = {};
    sendNativeAction("SKeypad", "hideKeypad", params);
}
function PluginSKeyPad_setPasswordError() {
    var params = {
        "message": "error message"
    };
    sendNativeAction("SKeypad", "setPasswordError", params);
}
function PluginSKeyPad_resetInput() {
    var params = {
    };
    sendNativeAction("SKeypad", "resetInput", params);
}
function pluginSecurityMedia_showOTP() {
    var params = {
        "nextServiceCode": "", //필요한 경우에만 포함
        "serviceCode": "RSMCM1100A04" // RSMCM1100A04 or RSMCM1100A02 둘 중 하나
    };
    sendNativeAction("SecurityMedia", "OTP", params);
}
function pluginSecurityMedia_showSecurityCard() {
    var params = {
        "nextServiceCode": "", //필요한 경우에만 포함
        "cardType": "3", //3자리 보안카드, 4자리 보안카드 "3" or "4"
        "firstNumber" : "18", //카드번호 1
        "secondNumber" : "16" //카드번호 2
    };
    sendNativeAction("SecurityMedia", "SecureCard", params);
}
function pluginSecurityMedia_showSerialSecurityCard() {
    var params = {
        "nextServiceCode": "", //필요한 경우에만 포함
        "cardType": "3", //3자리 보안카드, 4자리 보안카드 "3" or "4"
        "firstNumber" : "18", //카드번호 1
        "secondNumber" : "16", //카드번호 2
        "serialNumberArray" : ["1", "3", "5"] //입력해야하는 일련번호 position (보안카드 일련번호 필요여부가 N이라면 입력 X)
    };
    sendNativeAction("SecurityMedia", "SecureCardWithSerial", params);
}
function pluginTrustNoFace_goEntryPage() {
    var params = {
        "data": {
            "loadURL": "/trust/step1.do",
            "key1": "value1",
            "key2": "value2"
        }
    };
    sendNativeAction("TrustNoFace", "goEntryPage", params);
}
function pluginTrustNoFace_endNoFaceAuthWithResult() {
    var params = {
        "state": "auth-success",
        "req_key" : "1234"
    };
    sendNativeAction("TrustNoFace", "endNoFaceAuthWithResult", params);
}
function pluginTrustNoFace_goVideoCallPage() {
    var params = {
        "isSPassNativeMode": true, // aos only
        "req_key": "0621124020200422203355474",
        "data": {
            "app_type": "I",
            "product_code": "230101211206003",
            "blind":"off",
            "app_version": "10.0.2"
        }
    };
    sendNativeAction("TrustNoFace", "goVideoCallPage", params);
}

function pluginOdsNoFace_goEntryPage() {
    var params = {
        "data": {
            "k": "3uOuw7Rg4CXaKo0PHMGx*x",
//            "key2": "value2"
        }
    };
    sendNativeAction("OdsNoFace", "goEntryPage", params);
}
function pluginOdsNoFace_endNoFaceAuthWithResult() {
    var params = {
        "state": "auth-success",
        "req_key" : "1234"
    };
    sendNativeAction("OdsNoFace", "endNoFaceAuthWithResult", params);
}
function pluginOdsNoFace_goVideoCallPage() {
    var params = {
        "data": {
            "key1": "value1",
            "key2": "value2",
            "goSmart": false,
            "k": "7*FCzC1MA2ya_JJaXa_sqq"
        }
    };
    sendNativeAction("OdsNoFace", "goVideoCallPage", params);
}

function pluginOpenFace_startFaceAuth() {
    var params = {
        "req_key": "20220906093535754379",
        "sexType": "", // 성별
        "settingVal": { // 안면 인증 세팅 값
            "live_stdt": "20220906093949", // 인증 시작 시간
            "mot_step": "2", // 라이브니스 단계
            "mot_wait_times": "6", // 모션 실행 시간
            "face_bas_v": 0.505, // 안면 인증 기준 값
            "mot_1": "0", // 인증 처음 실행 했을때 모션 1
            "mot_2": "1", // 인증 처음 실행 했을때 모션 2
            "mot_3": "0", // 인증 처음 실행 했을때 모션 3
            "mot_plcy_yn": "Y", // 모션 정책 여부
            "mot_cnt": "3", // 모션 횟수
            "liveness_lmt_cnt": "11", // 인증 가능횟수 제한 값
            "fail_cnt": "0" // 인증 실패 횟수
        },
        "faceErrList" : [
            {
                "eCode": "101",
                "msg": "얼굴감지, 정상"
            },
            {
                "eCode": "102",
                "msg": "가이드 영역안에 얼굴이 없음"
            },
            {
                "eCode": "103",
                "msg": "여러명의 얼굴이 감지됨"
            },
            {
                "eCode": "104",
                "msg": "얼굴을 찾을 수 없음"
            },
            {
                "eCode": "105",
                "msg": "너무 밝음"
            },
            {
                "eCode": "106",
                "msg": "너무 어두움"
            },
            {
                "eCode": "0",
                "msg": "-"
            },
            {
                "eCode": "-1000",
                "msg": "연결실패로 재시작이 필요합니다."
            },
            {
                "eCode": "-1001",
                "msg": "카메라를 봐주세요."
            },
            {
                "eCode": "-1002",
                "msg": "카메라를 봐주세요."
            },
            {
                "eCode": "-1003",
                "msg": "카메라를 봐주세요."
            },
            {
                "eCode": "-1005",
                "msg": "안내된 모션을 따라 해주세요."
            },
            {
                "eCode": "-1006",
                "msg": "안내된 모션을 따라 해주세요."
            },
            {
                "eCode": "-1007",
                "msg": "카메라를 봐주세요."
            },
            {
                "eCode": "-1008",
                "msg": "카메라를 봐주세요."
            },
            {
                "eCode": "-1009",
                "msg": "카메라를 봐주세요."
            },
            {
                "eCode": "-1010",
                "msg": "카메라를 봐주세요."
            },
            {
                "eCode": "-1011",
                "msg": "카메라를 봐주세요."
            },
            {
                "eCode": "-1012",
                "msg": "잠시후에 다시 시작해 주세요."
            },
            {
                "eCode": "-1013",
                "msg": "잠시후에 다시 시작해 주세요."
            },
            {
                "eCode": "-1014",
                "msg": "전면 카메라가 작동하지 않습니다."
            },
            {
                "eCode": "-1015",
                "msg": "얼굴인증시 카메라 저장은 내부 저장장치만 사용 가능합니다.(SD카드 사용불가)"
            }
        ] // liveness error list
    };
    sendNativeAction("OpenFace", "startFaceAuth", params);
}

function pluginUFace_startFaceAuth() {
    var params = {
        "req_key": "0621124020200422203355474",
        "image_base64_data": base64ImageString,
        "uface_fake_cnt": 4
    };
    sendNativeAction("UFace", "startFaceAuth", params);
}

function pluginUFace_confirmSamePerson() {
    var params = {
        "req_key": "0621124020200422203355474",
        "image_base64_data": base64ImageString,
        "faceDataForComparison": {
            "rsaKey" : rsaKey,
            "template": template,
            "templateHash": templateHash
        }
    };
    sendNativeAction("UFace", "confirmSamePerson", params);
}

function pluginView_refreshMain() {
    var params = {};
    sendNativeAction("Login", "refreshMain", params);
}
function pluginNoFaceAuthVideo_goVideoCallPage() {
    var params = {
        "req_key": "0621124020200422203355474"
    };
    sendNativeAction("NoFaceAuthVideo", "goVideoCallPage", params);
}
function pluginNoFaceAuthVideo_emitVideoCallState() {
    var params = {};
    sendNativeAction("NoFaceAuthVideo", "emitVideoCallState", params);
}

function pluginWonKeypad_showKeypad() {
    var params = {
        "useAmountButton" : true,
        "useCommaFormat": true,
        "useWonFormat": true,
        "maxLength": 14,
        "defaultValue": 1000,
        "fullValue": 100000,
        "useCancelOnTouchOutside": true
    };
    sendNativeAction("WonKeypad", "showKeypad", params);
}
function pluginWonKeypad_hideKeypad() {
    var params = {};
    sendNativeAction("WonKeypad", "hideKeypad", params);
}
function pluginWonKeypad_clearInput() {
    var params = {};
    sendNativeAction("WonKeypad", "clearInput", params);
}
function pluginWonKeypad_setFullValue() {
    var params = {
        "fullValue": 1233220
    };
    sendNativeAction("WonKeypad", "setFullValue", params);
}

function pluginSharingValues_getSimpleTransferID() {
    var params = {};
    sendNativeAction("SharingValues", "getSimpleTransferID", params);
}
function pluginSharingValues_setSimpleTransferID() {
    var params = {
        "newValue": "testtesttest"
    };
    sendNativeAction("SharingValues", "setSimpleTransferID", params);
}
function pluginSharingValues_getShakeSettingData() {
    var params = {};
    sendNativeAction("SharingValues", "getShakeSettingData", params);
}
function pluginSharingValues_setShakeSettingData() {
    var params = {
        "shakeYn": "Y",
        "shakeProgramId": "IN0101A110001"
    };
    sendNativeAction("SharingValues", "setShakeSettingData", params);
}
function pluginSharingValues_getComSecChal() {
    var params = {};
    sendNativeAction("SharingValues", "getComSecChal", params);
}
function pluginSharingValues_setComSecChal() {
    var params = {
        "COM_SEC_CHAL1": "20",
        "COM_SEC_CHAL2": "30"
    };
    sendNativeAction("SharingValues", "setComSecChal", params);
}
function pluginSharingValues_setFaceDetectRegisteration() {
    var params = {
        "status": true
    };
    sendNativeAction("SharingValues", "setFaceDetectRegisteration", params);
}
function pluginSharingValues_setFaceDetectUnRegisteration() {
    var params = {
        "status": false
    };
    sendNativeAction("SharingValues", "setFaceDetectRegisteration", params);
}
function pluginSharingValues_setHaveSeenPushAlarm() {
    var params = {};
    sendNativeAction("SharingValues", "setHaveSeenPushAlarm", params);
}

function pluginSharingValues_setHaveSeenOTPWarranty() {
    var params = {};
    sendNativeAction("SharingValues", "setHaveSeenOTPWarranty", params)
}


function pluginCertManager_issueCert() {
    var params = {
        "password" : "y+lMvaNAeZ2F0L26yYyC6w==",
        "referenceNum" : "673375292",
        "authCode" : "76032639925071214030"
    };
    
    sendNativeAction("JointCert", "issueCert", params);
}

function pluginCertManager_renewCert() {
    var params = {
        "password" : "",
        "index" : 9
    };
    sendNativeAction("JointCert", "renewCert", params);
}

function pluginCertManager_selectCertificate_Scrap() {
    var params = {
        "selectType" : "scrap"
    };
    sendNativeAction("JointCert", "selectCertificate", params);
}

function pluginCertManager_selectCertificate_OtherCert() {
    var params = {
        "selectType" : "otherCert"
    };
    sendNativeAction("JointCert", "selectCertificate", params);
}

function pluginCertManager_selectCertificate_UpdateCert() {
    var params = {
        "selectType" : "updateCert"
    };
    sendNativeAction("JointCert", "selectCertificate", params);
}

function pluginCertManager_openCopyCertQR() {
    var params = {
        "type" : "QR" //QR, MtoPC, PCtoM, SCRAP, MtoM
    };
    sendNativeAction("JointCert", "openCopyCert", params);
}

function pluginCertManager_openCopyCertMtoPC() {
    var params = {
        "type" : "MtoPC" //QR, MtoPC, PCtoM, SCRAP, MtoM
    };
    sendNativeAction("JointCert", "openCopyCert", params);
}


function pluginCertManager_openCopyCertPCtoM() {
    var params = {
        "type" : "PCtoM" //QR, MtoPC, PCtoM, SCRAP, MtoM
    };
    sendNativeAction("JointCert", "openCopyCert", params);
}

function pluginCertManager_openCopyCertMtoM() {
    var params = {
        "type" : "MtoM" //QR, MtoPC, PCtoM, SCRAP, MtoM
    };
    sendNativeAction("JointCert", "openCopyCert", params);
}

function pluginCertManager_openCopyCertSCRAP() {
    var params = {
        "type" : "SCRAP" //QR, MtoPC, PCtoM, SCRAP, MtoM
    };
    sendNativeAction("JointCert", "openCopyCert", params);
}

function pluginCertManager_certManagement() {
    var params = {};
    sendNativeAction("JointCert", "startCommonCertManagerActivity", params);
}

function pluginShortCut_shortcut() {
    var params = {
        "type" : "COSMO_BARCODE_SHORTCUT",
        "title" : "컵반환",
        "invocationPhrase" : "컵반환",
        "isEligibleForSearch" : "Y",
        "isEligibleForPrediction" : "Y",
        "screenId" : "IN04610101001P02",
        "userInfo" : {}
    };
    sendNativeAction("Shortcut", "addShortcut", params);
}

function pluginShareBase64ImageKakao() {
    var params = {
        "title": "타이틀", // 타이틀
        "description": "공유 메시지", // 본문
        "imageWidth": 160, // 이미지 너비
        "imageHeight": 100, // 이미지 높이
        "imageLink": "https://www.daum.net", // 이미지 클릭 시 링크 주소 -> 없으면 공유된 url로 취환 (TODO:클릭시 이동지점 설계 필요)
        "buttonTitle": "New App 버튼 제목", // 버튼 타이틀
        "buttonLink": "https://www.google.com", // 버튼 클릭 시 링크 주소 -> 없으면 공유된 url로 취환 (TODO:클릭시 이동지점 설계 필요)
        "imageData": "iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAMAAADXqc3KAAAB+FBMVEUAAAA/mUPidDHiLi5Cn0XkNTPmeUrkdUg/m0Q0pEfcpSbwaVdKskg+lUP4zA/iLi3msSHkOjVAmETdJSjtYFE/lkPnRj3sWUs8kkLeqCVIq0fxvhXqUkbVmSjwa1n1yBLepyX1xxP0xRXqUkboST9KukpHpUbuvRrzrhF/ljbwaljuZFM4jELaoSdLtElJrUj1xxP6zwzfqSU4i0HYnydMtUlIqUfywxb60AxZqEXaoifgMCXptR9MtklHpEY2iUHWnSjvvRr70QujkC+pUC/90glMuEnlOjVMt0j70QriLS1LtEnnRj3qUUXfIidOjsxAhcZFo0bjNDH0xxNLr0dIrUdmntVTkMoyfL8jcLBRuErhJyrgKyb4zA/5zg3tYFBBmUTmQTnhMinruBzvvhnxwxZ/st+Ktt5zp9hqota2vtK6y9FemNBblc9HiMiTtMbFtsM6gcPV2r6dwroseLrMrbQrdLGdyKoobKbo3Zh+ynrgVllZulTsXE3rV0pIqUf42UVUo0JyjEHoS0HmsiHRGR/lmRz/1hjqnxjvpRWfwtOhusaz0LRGf7FEfbDVmqHXlJeW0pbXq5bec3fX0nTnzmuJuWvhoFFhm0FtrziBsjaAaDCYWC+uSi6jQS3FsSfLJiTirCOkuCG1KiG+wSC+GBvgyhTszQ64Z77KAAAARXRSTlMAIQRDLyUgCwsE6ebm5ubg2dLR0byXl4FDQzU1NDEuLSUgC+vr6urq6ubb29vb2tra2tG8vLu7u7uXl5eXgYGBgYGBLiUALabIAAABsElEQVQoz12S9VPjQBxHt8VaOA6HE+AOzv1wd7pJk5I2adpCC7RUcHd3d3fXf5PvLkxheD++z+yb7GSRlwD/+Hj/APQCZWxM5M+goF+RMbHK594v+tPoiN1uHxkt+xzt9+R9wnRTZZQpXQ0T5uP1IQxToyOAZiQu5HEpjeA4SWIoksRxNiGC1tRZJ4LNxgHgnU5nJZBDvuDdl8lzQRBsQ+s9PZt7s7Pz8wsL39/DkIfZ4xlB2Gqsq62ta9oxVlVrNZpihFRpGO9fzQw1ms0NDWZz07iGkJmIFH8xxkc3a/WWlubmFkv9AB2SEpDvKxbjidN2faseaNV3zoHXvv7wMODJdkOHAegweAfFPx4G67KluxzottCU9n8CUqXzcIQdXOytAHqXxomvykhEKN9EFutG22p//0rbNvHVxiJywa8yS2KDfV1dfbu31H8jF1RHiTKtWYeHxUvq3bn0pyjCRaiRU6aDO+gb3aEfEeVNsDgm8zzLy9egPa7Qt8TSJdwhjplk06HH43ZNJ3s91KKCHQ5x4sw1fRGYDZ0n1L4FKb9/BP5JLYxToheoFCVxz57PPS8UhhEpLBVeAAAAAElFTkSuQmCC"
    };
    sendNativeAction("SNS", "shareBase64ImageKakao", params);
}

/**
 * iOS의 생체인증 타입 전송(touchID/faceID)
 */

function pluginBioType_fetchBioType() {
    var params = {};
    sendNativeAction("BioType","fetchBioType",params)
}

/**
 * ShinhanPlus Responder (데이터 확인용)
 */

function pluginShinhanPlusResponder_CertificationList(){
    var params = {};
    sendNativeAction("ShinhanPlusResponderCertification", "list", params)
}

function pluginShinhanPlusResponder_AuthExtendSession(){
    var params = {};
    sendNativeAction("ShinhanPlusResponderAuth", "extendSession", params)
}
function pluginShinhanPlusResponder_SecureKeyVerify(){
    var params = {
        "VALUE_1ST":"abcd",
        "VALUE_2ND":"efgt"
    };
    sendNativeAction("ShinhanPlusResponderSecureKey", "verify", params)
}
function pluginShinhanPlusResponder_AuthUpdateAgreement(){
    var params = {
        "FLAGS":"true"
    };
    sendNativeAction("ShinhanPlusResponderAuth", "updateAgreement", params)
}

function pluginShinhanPlusResponder_CertificationScraping(){
    var params = {
        "CVACD": "1",
        "NAME": "홍길동",
        "PERSONAL_NUMBER": "",
        "CERTIFICATE_PASSWORD": "00000000&",
        "CERTIFICATE_INDEX": "8",
        "PHONE_NUMBER_1ST": "010",
        "PHONE_NUMBER_2ST": "1233",
        "PHONE_NUMBER_3ST": "1323",
        "DOCUMENT_TYPE": "DOC_101",
        "SCRAPING_URL": "https://down.finger.co.kr/down/mws/service/shb_20200305"
    };
    sendNativeAction("ShinhanPlusResponderCertification", "scraping", params)
}

function pluginShinhanPlusResponder_CertificationScrapingBig(){
    var params = {
        "JOB_ID": "통합연금포털",
        "DOCUMENT_TYPE": "DOC_105",
        "DOC_105_INFO": {
            "이름": "홍길동",
            "아이디": "abdd123",
            "패스워드": "qqqqqqqq&",
            "기관명": "통합연금포털",
            "기관코드": "902",
            "서비스명": "통합연금포털_내연금조회",
            "조회시작년월": "202201",
            "조회종료년월": "202212",
            "타임아웃": "300",
            "BIGSCRAPING_URL": "https://down.finger.co.kr/down/mws/service/shb_20200305",
            "jobId": "통합연금포털_내연금조회"
        }
    };
    sendNativeAction("ShinhanPlusResponderCertification", "scraping", params)
}

function pluginShinhanPlusResponder_CertificationScrapingDrm(){
    var params = {
        // OmniDoc -> Big Scraping
        "DOC_INFO": {
            "GOV24_JUMIND": {
                "type": "0x03000002",   // 등본: 0x03000002, 초본: 0x03000004
                "organName": "정부24",
                "docName": "주민등록등본",
                "opt1": "02",           // 주소변동이력 표시여부
                "opt2": "02",           // 동거인 표시여부
                "opt3": "01",           // 세대주 관계표시
                "opt4": "01",           // 전입일 표시
                "opt5": "01",           // 세대구성 사유표시
                "opt6": "02",           // 주민등록번호 뒷자리
                "opt7": "01",           // 세대원 이름표시
                "opt8": "02",           // 세대구성일자
                "opt9": "02",           // 세대원의 변동사유
                "opt10": ""           
            },
            "GOV24_LOGIN": {
                "opt1":"경기도",
                "opt2":"안산시"
            }
        },
        "TASK_INFO": "",
        "CERT_INFO": {
            "certIndex": "8",
            "certPasswordEcc": "I0uzql6RBVSlyKd3IYAC4A==",
            "certPasswordAes": "0000000&"
        },
        "OPTION": ""
    };
    sendNativeAction("ShinhanPlusResponderCertification", "scrapingDrm", params)
}

function pluginShinhanPlusResponder_CertificationGetFinCertInfo() {
    var params = {};
    sendNativeAction("ShinhanPlusResponderCertification", "getFinCertInfo", params)
}

function pluginShinhanPlusResponder_CertificationSetFinCertInfo() {
    var params = {
        "finCertLsPubkId": "xxx",
        "finCertLsFinSdkKey": "xxx"
    };
    sendNativeAction("ShinhanPlusResponderCertification", "setFinCertInfo", params)
}

var pluginShinhanPlusResponder_UtilsShowNumberKeypad = (function () {
    var isAmountViewHidden = true;
    return function () {
        var params = {
            "type" : "W",
            "amountViewHidden": isAmountViewHidden ? "Y" : "N",
            "isComma": "Y",
            "isWon": "Y",
            "maxLength": 14,
            "maxValue": 100000000,
            "korTagId": "12345"
        };
        sendNativeAction("ShinhanPlusResponderWonKeypad", "showWonKeypad", params)
        isAmountViewHidden = !isAmountViewHidden;
    }
})();
function pluginShinhanPlusResponder_UtilsCloseNumberKeypad() {
    var params = {};
    sendNativeAction("ShinhanPlusResponderWonKeypad", "hideKeypad", params)
}

////////////////////////////////////////////////////////////////////////////////
/* script handler  */
//////////////////////////////////////////////////////////////////////////
otcBridge = {};
otcBridge.sh = {};

/**
 * 네이티브로 실행할 함수의 콜백 아이디
 */
otcBridge.sh.callbackID = Math.floor(Math.random()*2000000000);

/**
 * 실행한 함수가 콜백을 실행하기 전까지, 콜백 저장
 */
otcBridge.sh.callbacks = {};

/**
 * 디바이스 체크
 */
otcBridge.sh.isMobile = {
android: function () {
    return navigator.userAgent.match(/Android/i) == null ? false : true;
},
ios: function () {
    return navigator.userAgent.match(/iPhone|iPad|iPod/i) == null ? false : true;
},
any: function () {
    return (this.android() || this.ios())
}
};

/**
 * web -> android / ios 실행
 */
otcBridge.sh.exec = function(successCallback, failCallback, className, command, params){
    console.log("[otcBridge.sh.exec =========== start]");
    if (!otcBridge.sh.isMobile.any()) {
        console.log("[otcBridge.sh.exec =========== 웹에서 실행할 수 없습니다. ]");
        //fail.call(this,"웹에서 실행할 수 없습니다.");
        //return;
    }
    
    // callbacks
    var callbackID = null;
    if(successCallback || failCallback){
        callbackID = otcBridge.sh.callbackID;
        otcBridge.sh.callbackID += 1;
        otcBridge.sh.callbacks[callbackID] = {className:className, command:command, success:successCallback, fail:failCallback, params: params}
    }
    
    try {
        
        if(otcBridge.sh.isMobile.android() ){
            console.log("[otcBridge.sh.exec ===========]", "android");
            otcBridge.sh.aosCommand(callbackID, className, command, params);
        }else if(otcBridge.sh.isMobile.ios() ){
            console.log("[otcBridge.sh.exec ===========]", "ios");
            otcBridge.sh.iosCommand(callbackID, className, command, params);
        }else{
            console.log("[otcBridge.sh.exec ===========]", "웹화면");
            
            //TODO test web callback
            var strCallbackID = callbackID.toString();
            var message = {
                "callbackID": strCallbackID,
                "command": command,
                "params": params
            };
            var args = {};
            
            console.log(" otcBridge.sh.exec ::::: message : " + JSON.stringify(message, null, 4) );
            var strArgs = JSON.stringify(message);
            var strMessage = JSON.stringify(message);
            otcBridge.sh.command_callback(callbackID, true, strArgs, strMessage);
        }
        
    } catch (e) {
        console.log("otcBridge.sh.exec Error: " + e);
    }
};

/**
 *  AOS WebView에 Javascript Interface 실행하여 명령 전송
 */
otcBridge.sh.aosCommand = function(callbackID, className, command, params){
    var strCallbackID = callbackID.toString();
    var message = {
        "callbackID": strCallbackID,
        "className": className,
        "command": command,
        "params": params
    };
    
    console.log(" otcBridge.sh.aosCommand ::::: message : " + JSON.stringify(message, null, 4) );
    window.nativeInterface.execute( JSON.stringify(message) );
};

/**
 *  IOS WKWebView에 스크립트메세지 전송
 */
otcBridge.sh.iosCommand = function(callbackID, className, command, params){
    var strCallbackID = callbackID.toString();
    var message = {
        "requestId": strCallbackID,
        "serviceName": className,
        "action": command,
        "params": params
    };
    var request = document.getElementById("request")
    request.value = JSON.stringify(message, null, 4)
    console.log(" otcBridge.sh.iosCommand ::::: message : " + JSON.stringify(message, null, 4) );
    window.webkit.messageHandlers.geuniModule.postMessage( JSON.stringify(message) );
};

var base64ImageString = "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";

var base64GifString = "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S7as2bNo06pdq/QpV7bj3N6E+08uT7r+7ALFy7ev37+AAwseTLiw4cOIZwpYzLix48eQG8OITLmy48mWM0cm9Pad5s+XX4AeLQAzac2c5xo8/dk068quX28e1JmdbMuxb4d2oZty6rvYegsfTry48eOgByhfzry58+fQo0ufrlwi8uvYs2vfzpi69+/gv1vnTr68+fORw6tfr348+vfw4xdnT78+dPfy8+vfD5k5gf8ABv4o4IAEFmjggQj+x5xD/DXoYH7+JSjhhBRKuGBDD2aoIXkRVujhhxReyNCGJJZoXIcgpqiigCIudF0BMMYo44w01ijjizbmqOONyO3oY46NoVigAUQWaeSRSCap5JJJJtjiaj3+KCWPx01pZQE4XvljkMslyOSXYIaJpJPLKZSlljueiSaQUa6pI5fKeSnmnHSOieCTBanpJo167kmlcX6yuZiQBNZpaJ1kVpdQoIw26uijkEZaI6H/HXrkAZgeoGSmmh5aIJ4ESSrqqKSWKimlBFhqJKebZmrpp2UuauqstNZq64yoqlokq0nyaiisiiJ067DEFttorroa4Oulrv56SiCoAxkr7bTU6ohiq5gmq+2SAUIrULXghivttb02u+25RXYbq7DituuuqeQiuSy626ob7EHv5qvvo/Eymy296No7gEKiImDwwQgnrPDCCBfM8MMQN1yjJWtGbPHDMvYLcJLQYdupnQquC8B9+VAs6cUoJ+xwyinbaLKWLLOccZcAbsxkx+X+CzIBLZKMz8uQxtzyyUJf7DIkFRdt8cxx1myzkjjLa+6RAlPg8z1AP6r00kRvjfHESKPpNcRMDxDg01A/57GSVU9wtT2WjC333HTXbffdKGtsM3MJ9O1338zRKTDff/vt7Tt4J6744ow3joDeGxNeeAKBzzn4cv6TAy6yPY537vnnoCsMOcCSF165mJcrlznlm9cT+uuwx0736PSW/vfpYaY+wOqHsyP778AHDzHtc85bpO2Z4842gMhP3vs6wkcv/e/Ei2k8kc2bvhyYAq9+e+v0TC/++J1XH+b1BmT/vXLcM4+595rfyzn59Ndft/lgoq++4dt/2T38rJOf6xKngAIa8IAITKACD6i4BTrwgQqIW9EkqDAIKiA8DDwY/pK1P+eBB4DaEyA13NFAC5owgSU8oQUpGDMWIsyCGDQgwjaoqw6G0DsgXN/A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m6qJqompVExUO1q9KilrHK9cgxbNBTZsmLJm2q2yZjaPWrUE2a571tahXGx3u+aFW1cr3bnlsO7N29dvYLx/o20tHAhtG8eMsUBeMzlylcppMFuWovlM581PPpcRDZoJabHbSk9arOq0aiSuX8ueTbu27du4c+vezbu379/Ag1cbKzwza8XEi3s+TjS18tHMR8V+HmM69evYs2vfzr279+/gw4sfT96CgPPo06tfzx4G+/fw37uPTz/+/Pr41YvPn/8+//4v/P73n38C0rdfgfARiKB8AS5oYIMOJhhehOspSCF6Fl4oQIYXHqjhhyCGKOKIJK43wIkopqjiiiy26OKLMJ44VIk01mjjjTXGqOOOPO44I45ABinkkO/1aOSRRv5I5JJMNhkiklBG2aKSTlZp5ZXspUjAllx26eWXYIYp5phkbpliT1imqWaVWpbp5ptwunkmT2vWaSeQbcap555wzrnTnYAGKmKefBZqqJd+6lTAoow26uijkJYI6aSUTipppZhWeumjhIZpwKeghirqqKSWaiqpZSZaU6asMrppq7C+CiursjLaKZin5qrrrqOmimJOs2Zaa7CUDktspCROeuuXvP426yyqZKpK07HFJkstpsZe66q1nKJY5rPgPuurjDhpa+656Kar7rrXLktAuKIeIO8Bpc5Lb7hhSjsTu/z26++/AEPqLryh2lvvvPDm+2u5ATfs8MMQVzowwZ8aTKrF4CpM7k0Rd+zxx/xOTDHG8SKML5j6ygTyyiy33CqhB8tL8agtJsxlolOy5PLOPO8M88UmzwxqzSebubAEOa/U89JMR/zzqCQLTXTGNx8NQNIqNa311v0+XbLMQg/Nos1Gb3w1iy0hoPbabLft9tv+vi333HLHTffddNvtttdhk5piAoAHDniKBQctapctCi54yh/h7fjaej8ueeSSO0752v589y3q34oPjmLhYPda9Yqde252SZXjfXnqc6/OOtz9yp255mKfWHoChIMaNaiIs3g74xq93nrswt/tevGQE7+3t1zSXirnnedeseGh9k566cBXhPz23Hfv/ffgFz+789DfjvvnuVo/gPmBZw9R+PDHL//89L89Pu3l/47+qeqzb/oAKamfAAdIwALe7X6ayx/29meq/vnPfQsxoAQnSEH4IbBvCoweA0vlQPZB0CAVDKEIJdgivF1wV7v7VAbN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";


var rsaKey = "356AA68F5A50D5EA9024CC33B772F573A768ABA6CDBB941E74B0C1B2A91A5A9BAB1666288D58EF7708884673FA26F5729461CB40B59BECD612122345D28E1A4368D442FB9DC2A0D84E6408BF47777E5195B1487745D2DC9F159CCE15E905503E274E7D8D3422CF9BE33211AD29FE87B6E40E2D9E321E596BD66B94CDC0A5C26B613A5186458FC8869674DA14279EA66E4A0BAE5DFEBBED0BD9475A0EF73085E2EEC557C7926E56D9A1890265538476AB9638F88930030D0D9A715CA9C6FA831998866729FE78166CB83FBD07B4F949B2B4D2CB91E5946965477D18516EBFAD4A24EA7637530EA8862A483011B8132656064D2B63DE94C57F127AAECD43F2352F";
