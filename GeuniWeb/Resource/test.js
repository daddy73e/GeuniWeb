

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
function goPrevPageWithData() {
    var params = {
        "data" : "test data"
    };
    sendNativeAction("Navigator", "goPrevPageWithData", params)
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

function callbackListener(message) {
    var response = document.getElementById("response")
    response.value = JSON.stringify(message, null, 4)
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

var rsaKey = "356AA68F5A50D5EA9024CC33B772F573A768ABA6CDBB941E74B0C1B2A91A5A9BAB1666288D58EF7708884673FA26F5729461CB40B59BECD612122345D28E1A4368D442FB9DC2A0D84E6408BF47777E5195B1487745D2DC9F159CCE15E905503E274E7D8D3422CF9BE33211AD29FE87B6E40E2D9E321E596BD66B94CDC0A5C26B613A5186458FC8869674DA14279EA66E4A0BAE5DFEBBED0BD9475A0EF73085E2EEC557C7926E56D9A1890265538476AB9638F88930030D0D9A715CA9C6FA831998866729FE78166CB83FBD07B4F949B2B4D2CB91E5946965477D18516EBFAD4A24EA7637530EA8862A483011B8132656064D2B63DE94C57F127AAECD43F2352F";
