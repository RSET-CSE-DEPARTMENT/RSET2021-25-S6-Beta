import axios from "axios";

const pushNotification = (subId, title, message) =>
  axios.post(`https://app.nativenotify.com/api/indie/notification`, {
      subID: subId,
      appId: 21277,
      appToken: 'zKYr5HfxtSvzogaxyd2h3F',
      title: title,
      message: message
  });
export default pushNotification; 
