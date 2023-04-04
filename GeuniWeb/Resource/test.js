

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

//////////////////////////////////////////////////////////////////////////
function generateBarcode() {
    var params = {
        "code" : "777100083303423291"
    };
    sendNativeAction("Generate", "barcode", params)
}


function updateScreenModeFull() {
    var params = {
        "screenMode" : "fullScreen",
    };
    sendNativeAction("Configuration", "screen", params)
}

function updateScreenModeSafeArea() {
    var params = {
        "screenMode" : "safeArea",
    };
    sendNativeAction("Configuration", "screen", params)
}

/* plugin functions */
function updateConfigureDevelop() {
    var params = {
        "configure" : "develop",
    };
    sendNativeAction("Configuration", "baseURL", params)
}

function updateConfigureProduction() {
    var params = {
        "configure" : "production",
    };
    sendNativeAction("Configuration", "baseURL", params)
}

function requestAPI() {
    var params = { };
    
    sendNativeAction("APIRequest", "requestTest", params)
}

function goPrevPageWithData() {
    var params = {
        "data" : "test data"
    };
    sendNativeAction("Navigator", "goPrevPageWithData", params)
}

function showAlertPopup() {
    var params = {
        "title" : "제목",
        "contents" : "내용",
        "yesText" : "확인",
        "noText" : "취소"
    };
    sendNativeAction("Notification", "popup", params)
}

function showToast() {
    var params = {
        "message" : "toast메세지",
        "duration" : "3"
    };
    sendNativeAction("Notification", "toast", params)
}

function writeLocalStorage() {
    var params = {
        "key" : "test",
        "value" : "testValue"
    };
    sendNativeAction("LocalStorage", "writeLocalStorage", params)
}

function readLocalStorage() {
    var params = {
        "key" : "test"
    };
    sendNativeAction("LocalStorage", "readLocalStorage", params)
}

function removeLocalStorage() {
    var params = {
        "key" : "test"
    };
    sendNativeAction("LocalStorage", "removeLocalStorage", params)
}

function loginApple() {
    var params = {
        "type" : "apple"
    };
    sendNativeAction("Login", "loginSNS", params)
}

function loginKakao() {
    var params = {
        "type" : "kakao"
    };
    sendNativeAction("Login", "loginSNS", params)
}

function loginFacebook() {
    var params = {
        "type" : "facebook"
    };
    sendNativeAction("Login", "loginSNS", params)
}

function loginPayco() {
    var params = {
        "type" : "payco"
    };
    sendNativeAction("Login", "loginSNS", params)
}

function logOut() {
    var params = { };
    sendNativeAction("LogOut", "logout", params)
}

function callbackListener(message) {
    var response = document.getElementById("response")
    response.value = JSON.stringify(message, null, 4)
}

////////////////////////////////////////////////////////////////////////////////
