function fromFlutter(type, data) {
  if ((eduv3Instance && eduv3Instance.onCallback) || type === "response") {
    var param = null;
    if (data) {
      var dataJson = decodeURIComponent(atob(data));
      param = JSON.parse(dataJson);
    }
    if (eduv3Instance && eduv3Instance.onCallback) {
      eduv3Instance.onCallback(type, param);
    }
    if (type === "response" && param.id) {
      var cb = eduv3Instance_method_callback[param.id];
      if (cb) {
        delete eduv3Instance_method_callback[param.id];
        cb(param.data, param.error);
      }
    }
  }
}

function eduv3PostMessageToApp(type, data) {
  var postObj = { type, data };
  var base64Data = btoa(encodeURIComponent(JSON.stringify(postObj)));
  messageHandler.postMessage(base64Data);
}
var eduv3Instance_method_id = 100;
var eduv3Instance_method_callback = {};
var eduv3Instance = {
  goBack(param) {
    eduv3PostMessageToApp("GoBack", param);
  },
  openNewUrl(url, showStatusBar, title) {
    eduv3PostMessageToApp("OpenNewUrl", { url, showStatusBar, title });
  },
  openPage(page, param) {
    eduv3PostMessageToApp("OpenPage", { page, param });
  },
  openNewUrlAsync(url, showStatusBar, title, callback) {
    var id = eduv3Instance_method_id;
    eduv3Instance_method_callback[id] = callback;
    eduv3Instance_method_id++;
    eduv3PostMessageToApp("openNewUrlAsync", {
      id,
      url,
      showStatusBar,
      title,
    });
  },
  openPageAsync(page, param, callback) {
    var id = eduv3Instance_method_id;
    eduv3Instance_method_callback[id] = callback;
    eduv3Instance_method_id++;
    eduv3PostMessageToApp("openPageAsync", { id, page, param });
  },
  isInApp() {
    return !!messageHandler;
  },
  saveDataAsync(key, val, callback) {
    var id = eduv3Instance_method_id;
    eduv3Instance_method_callback[id] = callback;
    eduv3Instance_method_id++;
    eduv3PostMessageToApp("saveDataAsync", { id, key, val });
  },
  getDataAsync(key, callback) {
    var id = eduv3Instance_method_id;
    eduv3Instance_method_callback[id] = callback;
    eduv3Instance_method_id++;
    eduv3PostMessageToApp("getDataAsync", { id, key });
  },
  getTokenAsync(callback) {
    var id = eduv3Instance_method_id;
    eduv3Instance_method_callback[id] = callback;
    eduv3Instance_method_id++;
    eduv3PostMessageToApp("getTokenAsync", { id });
  },
  alertAsync(msg, callback) {
    var id = eduv3Instance_method_id;
    eduv3Instance_method_callback[id] = callback;
    eduv3Instance_method_id++;
    eduv3PostMessageToApp("alertAsync", { id, msg });
  },
  confirmAsync(msg, callback) {
    var id = eduv3Instance_method_id;
    eduv3Instance_method_callback[id] = callback;
    eduv3Instance_method_id++;
    eduv3PostMessageToApp("confirmAsync", { id, msg });
  },
  toast(msg) {
    eduv3PostMessageToApp("toast", { msg });
  },
  openUrlWithExtraAsync(url, callback) {
    var id = eduv3Instance_method_id;
    eduv3Instance_method_callback[id] = callback;
    eduv3Instance_method_id++;
    eduv3PostMessageToApp("openUrlWithExtraAsync", { id, url });
  },
};
