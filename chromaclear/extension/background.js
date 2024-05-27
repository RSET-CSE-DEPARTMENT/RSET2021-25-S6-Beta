//Event Listener Registration
chrome.runtime.onMessage.addListener(function(request, sender, sendResponse) {
    if (request.action === "injectStyles") {
      //queries the browser for information about the currently active tab
      chrome.tabs.query({ currentWindow: true, active: true }, function(tabs) {
        if (tabs.length > 0) {
          //Retrieves the ID of the first tab in the array, assuming it's the active tab.
          var currentTabId = tabs[0].id;
          //Extracts the background color, text color, and link color from the received message.
          var bgColor = request.bgColor;
          var textColor = request.textColor;
          var linkColor = request.linkColor;
          
          //Executes a content script in the active tab, modifies the CSS styles of the web page based on the received colors.
          chrome.scripting.executeScript({
            target: { tabId: currentTabId },
            func: function(bgColor, textColor, linkColor) {
              // Console log for troubleshooting
              console.log("Adding class:", document.documentElement.classList);
  
              var style = `
                /* More specific selector (optional) */
                .custom-style body { background-color: ${bgColor} !important; }
                p, a, span { color: ${textColor}; }
                a { color: ${linkColor}; }
              `;
              //CSS Style Injection
              var styleElement = document.createElement('style');
              styleElement.textContent = style;
              document.documentElement.classList.add('custom-style');
              document.documentElement.appendChild(styleElement);
            },
            args: [bgColor, textColor, linkColor]
          });
        } else {
          console.error("No active tab found!");
        }
      });
    }
  });
  