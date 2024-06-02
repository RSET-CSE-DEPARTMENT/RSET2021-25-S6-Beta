import time
from datetime import datetime
from pathlib import Path
import winsound
import cv2
import torch
import torch.backends.cudnn as cudnn
from numpy import random
import firebase_admin
from firebase_admin import credentials,messaging
from firebase_admin import firestore,storage
import threading
from models.experimental import attempt_load
from utils.datasets import LoadStreams, LoadImages
from utils.general import check_img_size, check_requirements, check_imshow, non_max_suppression, apply_classifier, scale_coords, xyxy2xywh, strip_optimizer, set_logging, increment_path
from utils.plots import plot_one_box
from utils.torch_utils import select_device, load_classifier, time_synchronized, TracedModel

class custom_detect:
    def __init__(self, id, source_link):
        self.cooldown = True
        self.cred = credentials.Certificate("credential.json")
        firebase_admin.initialize_app(self.cred,{'storageBucket':'enter your id'})
        self.source = source_link
        self.cam_id = id
        self.db = firestore.client()
        #retrieving tokens
        self.tokens_ref = self.db.collection('tokens')
        self.tokens = self.tokens_ref.get()
        self.notunique_list = []
        # append each document
        for token in self.tokens:
            self.notunique_list.append(token.to_dict()['token'])
        self.token_list = list(set(self.notunique_list))
        print(self.token_list)


        self.frequency = 2000  # Hz (controls pitch)
        self.duration = 300  # milliseconds (controls duration)
        if __name__ == '__main__':
        
        #check_requirements(exclude=('pycocotools', 'thop'))

            with torch.no_grad():
                if False:  # update all models (to fix SourceChangeWarning)
                    for self.opt.weights in ['yolov7.pt']:
                        detect()
                        strip_optimizer(opt.weights)
                else:
                    self.detect()


    def sendPush(self, title, msg, registration_token, dataObject=None):
        # See documentation on defining a message payload.
        self.message = messaging.MulticastMessage(
            notification=messaging.Notification(
                title=title,
                body=msg
            ),
            data=dataObject,
            tokens=registration_token,
        )

        # Send a message to the device corresponding to the provided
        # registration token.
        self.response = messaging.send_multicast(self.message)
        # Response is a message ID string.
        print('Successfully sent message:', self.response)

    def timer_function(self):
        # Your timer function logic goes here
        self.cooldown = True

    #def update_counter(self, ):
        
    #def upload_img(self):
        
        
                            
    def detect(self,save_img=False):
        #source, weights, view_img, save_txt, imgsz, trace = opt.source, opt.weights, opt.view_img, opt.save_txt, opt.img_size, not opt.no_trace
        
        self.weights = 'ele_best2.pt'
        self.view_img = True
        self.trace = False
        self.imgsz = 640
        self.save_txt = False
        self.project = 'runs/detect'
        self.name = 'exp'
        self.save_img = not False and not self.source.endswith('.txt')  # save inference images
        self.webcam = self.source.isnumeric() or self.source.endswith('.txt') or self.source.lower().startswith(
            ('rtsp://', 'rtmp://', 'http://', 'https://'))

        # Directories
        self.save_dir = Path(increment_path(Path(self.project) / self.name, exist_ok=False))  # increment run
        (self.save_dir / 'labels' if self.save_txt else self.save_dir).mkdir(parents=True, exist_ok=True)  # make dir

        # Initialize
        set_logging()
        self.device = select_device('')
        self.half = self.device.type != 'cpu'  # half precision only supported on CUDA

        # Load model
        self.model = attempt_load(self.weights, map_location=self.device)  # load FP32 model
        self.stride = int(self.model.stride.max())  # model stride
        self.imgsz = check_img_size(self.imgsz, s=self.stride)  # check img_size

        if self.trace:
            model = TracedModel(model, self.device, self.imgsz)

        if self.half:
            self.model.half()  # to FP16

        # Second-stage classifier
        self.classify = False
        if self.classify:
            self.modelc = load_classifier(name='resnet101', n=2)  # initialize
            self.modelc.load_state_dict(torch.load('weights/resnet101.pt', map_location=self.device)['model']).to(self.device).eval()

        # Set Dataloader
        self.vid_path, self.vid_writer = None, None
        if self.webcam:
            self.view_img = check_imshow()
            cudnn.benchmark = True  # set True to speed up constant image size inference
            self.dataset = LoadStreams(self.source, img_size=self.imgsz, stride=self.stride) # LoadStream used to convert stream from webcam into frames
        else:
            self.dataset = LoadImages(self.source, img_size=self.imgsz, stride=self.stride)

        # Get names and colors
        self.names = self.model.module.names if hasattr(self.model, 'module') else self.model.names
        self.colors = [[random.randint(0, 255) for _ in range(3)] for _ in self.names]

        # Run inference
        if self.device.type != 'cpu':
            self.model(torch.zeros(1, 3, self.imgsz, self.imgsz).to(self.device).type_as(next(self.model.parameters())))  # run once
        self.old_img_w = self.old_img_h = self.imgsz
        self.old_img_b = 1

        self.t0 = time.time()
        for self.path, self.img, self.im0s, self.vid_cap in self.dataset: # Process each frame (img) here
            self.img = torch.from_numpy(self.img).to(self.device)
            self.img = self.img.half() if self.half else self.img.float()  # uint8 to fp16/32
            self.img /= 255.0  # 0 - 255 to 0.0 - 1.0
            if self.img.ndimension() == 3:
                self.img = self.img.unsqueeze(0)

            # Warmup
            if self.device.type != 'cpu' and (self.old_img_b != self.img.shape[0] or self.old_img_h != self.img.shape[2] or self.old_img_w != self.img.shape[3]):
                self.old_img_b = self.img.shape[0]
                self.old_img_h = self.img.shape[2]
                self.old_img_w = self.img.shape[3]
                for i in range(3):
                    self.model(self.img, augment=False)[0]

            # Inference
            self.t1 = time_synchronized()
            with torch.no_grad():   # Calculating gradients would cause a GPU memory leak
                self.pred = self.model(self.img, augment=False)[0]
            self.t2 = time_synchronized()
            self.conf_thres = 0.65
            
            self.iou_thres = 0.45

            # Apply NMS
            self.pred = non_max_suppression(self.pred, self.conf_thres, self.iou_thres, classes=None, agnostic=False)
            self.t3 = time_synchronized()
            if self.cam_id == 1:
                self.place = 'Chittethukara'
            elif self.cam_id == 2:
                self.place = 'Korangad'
            # Apply Classifier
            if self.classify:
                self.pred = apply_classifier(self.pred, self.modelc, self.img, self.im0s)

            # Process detections
            for self.i, self.det in enumerate(self.pred):  # detections per image
                if self.webcam:  # batch_size >= 1
                    self.p, self.s, self.im0, self.frame = self.path[self.i], '%g: ' % self.i, self.im0s[self.i].copy(), self.dataset.count
                else:
                    self.p, self.s, self.im0, self.frame = self.path, '', self.im0s, getattr(self.dataset, 'frame', 0)

                self.p = Path(self.p)  # to Path
                self.save_path = str(self.save_dir / self.p.name)  # img.jpg
                self.txt_path = str(self.save_dir / 'labels' / self.p.stem) + ('' if self.dataset.mode == 'image' else f'_{self.frame}')  # img.txt
                self.gn = torch.tensor(self.im0.shape)[[1, 0, 1, 0]]  # normalization gain whwh
                if len(self.det):
                    # Rescale boxes from img_size to im0 size
                    self.det[:, :4] = scale_coords(self.img.shape[2:], self.det[:, :4], self.im0.shape).round()

                    # Print results
                    for c in self.det[:, -1].unique():
                        self.n = (self.det[:, -1] == c).sum()  # detections per class
                        self.s += f"{self.n} {self.names[int(c)]}{'s' * (self.n > 1)}, "  # add to string

                    # Write results
                    for *self.xyxy, self.conf, self.cls in reversed(self.det):
                        if self.save_txt:  # Write to file
                            self.xywh = (xyxy2xywh(torch.tensor(self.xyxy).view(1, 4)) / self.gn).view(-1).tolist()  # normalized xywh
                            self.line = (self.cls, *self.xywh, self.conf) if False else (self.cls, *self.xywh)  # label format
                            with open(self.txt_path + '.txt', 'a') as self.f:
                                self.f.write(('%g ' * len(self.line)).rstrip() % self.line + '\n')

                        if (self.save_img or self.view_img):  # Add bbox to image
                            self.label = f'{self.names[int(self.cls)]} {self.conf:.2f}'
                            plot_one_box(self.xyxy, self.im0, label=self.label, color=self.colors[int(self.cls)], line_thickness=1)

                        if self.cls == 0 and self.cooldown: #This deal with my section
                            self.filename = f"detected_object_{time.time()}.jpg"  # Example with timestamp
                            cv2.imwrite(self.filename, self.im0)
                            self.storage_ref = storage.bucket().blob(self.filename)#Uploading image name as to be in bucket
                            self.storage_ref.upload_from_filename(self.filename)#Uploading image name in system
                            print("Image uploaded successfully!")
                            self.storage_ref.make_public()
                            self.download_url = self.storage_ref.public_url

                            self.cooldown = False
                            self.data = {
                                'Timestamp' : str(datetime.now()),
                                'Animal' : 'Elephant',
                                'Camera ID' : self.cam_id,
                                'url' : self.download_url
                            }
                            self.doc_ref = self.db.collection('Logs').document()
                            self.doc_ref.set(self.data) #this is used to store into firestore
                            self.sendPush("Elephant Alert!!", "Detected near " + self.place, self.token_list)
                            winsound.Beep(self.frequency, self.duration)
                            self.timer_thread = threading.Timer(10.0, self.timer_function)
                            self.timer_thread.start()
                            
                        
                            

                # Print time (inference + NMS)
                print(f'{self.s}Done. ({(1E3 * (self.t2 - self.t1)):.1f}ms) Inference, ({(1E3 * (self.t3 - self.t2)):.1f}ms) NMS')

                # Stream results
                if self.view_img:
                    cv2.imshow(str(self.p), self.im0)
                    cv2.waitKey(1)  # 1 millisecond

                # Save results
                if save_img:
                    if self.dataset.mode == 'image':
                        cv2.imwrite(self.save_path, self.im0)
                        print(f" The image with the result is saved in: {self.save_path}")
                    else:  # 'video' or 'stream'
                        if self.vid_path != self.save_path:  # new video
                            self.vid_path = self.save_path
                            if isinstance(self.vid_writer, cv2.VideoWriter):
                                self.vid_writer.release()  # release previous video writer
                            if self.vid_cap:  # video
                                fps = self.vid_cap.get(cv2.CAP_PROP_FPS)
                                w = int(self.vid_cap.get(cv2.CAP_PROP_FRAME_WIDTH))
                                h = int(self.vid_cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
                            else:  # stream
                                self.fps, self.w, self.h = 30, self.im0.shape[1], self.im0.shape[0]
                                self.save_path += '.mp4'
                            self.vid_writer = cv2.VideoWriter(self.save_path, cv2.VideoWriter_fourcc(*'mp4v'), self.fps, (self.w, self.h))
                        self.vid_writer.write(self.im0)

        if self.save_txt or self.save_img:
            s = f"\n{len(list(self.save_dir.glob('labels/*.txt')))} labels saved to {self.save_dir / 'labels'}" if self.save_txt else ''
            #print(f"Results saved to {save_dir}{s}")

        print(f'Done. ({time.time() - self.t0:.3f}s)')


        if __name__ == '__main__':
        
        #check_requirements(exclude=('pycocotools', 'thop'))

            with torch.no_grad():
                if False:  # update all models (to fix SourceChangeWarning)
                    for opt.weights in ['yolov7.pt']:
                        detect()
                        strip_optimizer(opt.weights)
                else:
                    self.detect()



obj = custom_detect(1, 'ele_bw.mp4') #camera object
#'ele_testvideo.mp4'
#obj2 = custom_detect(2, 'ele_bw.mp4')
#rtsp://admin:admin@192.168.137.25:1935