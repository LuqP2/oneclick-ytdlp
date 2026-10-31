chrome.action.onClicked.addListener((tab) => {
  if (tab.url && (tab.url.startsWith("http://") || tab.url.startsWith("https://"))) {
    chrome.scripting.executeScript({
      target: { tabId: tab.id },
      func: (url) => {
        window.location.href = "ytdlp://" + url;
      },
      args: [tab.url]
    });
  }
});