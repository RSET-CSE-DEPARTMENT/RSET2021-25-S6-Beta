from django.shortcuts import render,redirect
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from django.contrib import messages
from django.http import HttpResponse
from .forms import XrayImgForm
from .models import *
from django.db import IntegrityError
import requests
import base64
fracture_list = ["Elbow", "Finger", "Forearm", "Humerus", "Shoulder", "Wrist"]
ftype = ""
def Login(request):
    if request.method == "POST":
        username = request.POST.get("username")
        password = request.POST.get("password")
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('upload')
        else:
            messages.error(request, ("Invalid username or password"))
            storage = messages.get_messages(request)
            storage.used = True
    return render(request, 'myapp/login.html')
def signup(request):
    if request.method=="POST":
        email=request.POST.get("email")
        username=request.POST.get("username")
        password=request.POST.get("password")
        confirm_password=request.POST.get("confirm_password")
        if password!=confirm_password:
            messages.error(request, ("Confirmed password was incorrect"))
            storage = messages.get_messages(request)
            storage.used = True
        else:
            try:
                user=User.objects.create_user(username,email,password)
                user.save()
                messages.success(request, ("New User successfully created."))
                storage = messages.get_messages(request)
                storage.used = True
            except IntegrityError:
                messages.error(request, ("Username already exists"))
                storage = messages.get_messages(request)
                storage.used = True
    return render(request,'myapp/Signup.html')
def upload(request):
    global ftype
    if request.method == 'POST':
        form = XrayImgForm(request.POST, request.FILES)

        if form.is_valid():
            uploaded_image = form.save()

            # Read the image file as binary data
            with open(uploaded_image.img.path, "rb") as img_file:
                image_data = img_file.read()

            # Encode the binary data as base64
            base64_image = base64.b64encode(image_data).decode('utf-8')
            
            # Construct the URL for Roboflow API
            roboflow_url = "https://detect.roboflow.com/sleep-oqgis/2"

            # Construct the query parameters dictionary
            api_key = "pMkpzggFKSNgKPAKIxhz"
            params = {
                "api_key": api_key,
                "format": "json"
            }
            params1 = {
                "api_key": api_key,
                "format": "image"
            }
            headers = {
                "Content-Type": "application/json"
            }
            # Make the request to Roboflow API
            response = requests.post(roboflow_url, params=params, data=base64_image,headers=headers)
            t=[]
            t=response.json()['predictions']
            if t==[]:
                print("no fracture")
                return fail(request)
            else:
                tup=t[0]
                a,b,c,d,e,f,g,h= tup.values()
            f=int(f)
            ftype = fracture_list[f]
            response1 = requests.post(roboflow_url, params=params1, data=base64_image,headers=headers)
            if response1.status_code == 200:
                return success(request, response1,fracture_list[f])
            else:
                form = XrayImgForm()
    else:
        form = XrayImgForm()
    context = {'form': form}
    return render(request, 'myapp/Upload.html', context)
 
def success(request,response,f):
    image_data = response.content
    image_data_base64 = base64.b64encode(image_data).decode('utf-8')
    image_src = f"data:image/jpeg;base64,{image_data_base64}"
    return render(request, 'myapp/success.html', {'image_src': image_src,'f': f})

def fail(request):
    last_uploaded_image = XrayImages.objects.last()
    return render(request, 'myapp/fail.html', {'fail': last_uploaded_image})

def doctors(request):
    print(ftype)
    doctors = Doctor.objects.filter(speciality=ftype)
    context = {'doctors': doctors}
    return render(request, 'myapp/doctors.html', context)