//content of the webpage to be fully loaded before executing 
document.addEventListener("DOMContentLoaded", function() {
//This element is usually a button that the user clicks to apply the selected styles.
    var applyBtn = document.getElementById('applyBtn');
  
    applyBtn.addEventListener('click', function() {
      var bgColor = document.getElementById('bgColor').value;
      var textColor = document.getElementById('textColor').value;
      var linkColor = document.getElementById('linkColor').value;
  // sends a message to the background script of the Chrome extension
      chrome.runtime.sendMessage({
        action: "injectStyles",
        bgColor: bgColor,
        textColor: textColor,
        linkColor: linkColor
      });
    });
  });
  