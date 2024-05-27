// Add an event listener to wait for DOM content to be loaded
document.addEventListener('DOMContentLoaded', function() {
  // Add a click event listener to the convert button
  document.getElementById("convertButton").addEventListener("click", function() {
      // Send a message to the content script to initiate the conversion
      chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
          chrome.tabs.sendMessage(tabs[0].id, {"message": "convert_red_to_grey"});
      });
  });
});
