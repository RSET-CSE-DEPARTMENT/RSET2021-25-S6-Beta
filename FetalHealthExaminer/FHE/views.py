from django.shortcuts import render, redirect
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from .forms import SignUpForm, UserLoginForm
from .models import UserProfile, WeekData, PatientData
from django.views.decorators.http import require_http_methods
from django.http import JsonResponse
import json
from ml.final import predict_fetal_health
from django.urls import reverse
from django.core.serializers import serialize
from django.views.decorators.csrf import csrf_exempt
import uuid


def home(request):
    context = {}
    if request.user.is_authenticated:
        context['is_logged_in'] = True
    else:
        context['is_logged_in'] = False
    return render(request, 'home.html', context)

def signup(request):
    if request.method == 'POST':
        form = SignUpForm(request.POST)
        if form.is_valid():
            username = form.cleaned_data['username']
            email = form.cleaned_data['email']
            phone_number = form.cleaned_data['phone_number']
            hospital = form.cleaned_data['hospital']
            specialization = form.cleaned_data['specialization']
            city = form.cleaned_data['city']
            password = form.cleaned_data['password']

            # Create User object
            user = User.objects.create_user(username=username, email=email, password=password)
            user.save()

            # Create UserProfile object
            UserProfile.objects.create(user=user, phone_number=phone_number, hospital=hospital, specialization=specialization, city=city)

            return redirect('signup_success')  # Redirect to success page
    else:
        form = SignUpForm()

    return render(request, 'signup.html', {'form': form})



def signup_success(request):
    return render(request, 'signup_success.html')

@csrf_exempt
@require_http_methods(["POST"])
def login_user(request):
    data = json.loads(request.body)
    username = data.get('username', '')
    password = data.get('password', '')
    user = authenticate(request, username=username, password=password)
    if user is not None:
        login(request, user)
        return JsonResponse({'success': True})
    else:
        return JsonResponse({'success': False, 'error': 'Invalid username or password.'}, status=400)

@csrf_exempt
@require_http_methods(["POST"])
def signin(request):
    data = json.loads(request.body)
    username = data.get('username', '')
    password = data.get('password', '')
    phone_number = data.get('phNo', '')
    hospital = data.get('hospitalName', '')
    specialization = data.get('specialisation', '')
    email = data.get('email', '')   
    city = data.get('city', '')
    # Create User object
    user = User.objects.create_user(username=username, email=email, password=password)
    user.save()

            # Create UserProfile object
    UserProfile.objects.create(user=user, phone_number=phone_number, hospital=hospital, specialization=specialization, city=city)
    if user is not None:
        login_view(request)
        return JsonResponse({'success': True})
    else:
        return JsonResponse({'success': False, 'error': 'Invalid username or password.'}, status=400)

@require_http_methods(["POST"])
def process_integers(request):
    try:
        data = json.loads(request.body)
        integers = data.get('integers', [])
        weekName = data.get('weekName', '')
        uuid_ = data.get('uuid_', '')
        if not isinstance(integers, list):
            return JsonResponse({'error': 'Invalid data format. Expected a list of integers.'}, status=400)
        
        result = predict_fetal_health(integers)
   
        WeekData.objects.create(username=uuid_, week_name=weekName, numbers=integers,abnormality=result)
        userprofile = UserProfile.objects.filter(user=request.user)[0]

        print(userprofile.specialization)
        
        return JsonResponse({'result': result})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=400)
    

@require_http_methods(["POST"])
def add_patient(request):
    data = json.loads(request.body)
    patientname = data.get('patientname', '')
    doctorname = request.user.username
    age = data.get('age', '')
    relevantinfo = data.get('relevantinfo', '')
    uuid_ = str(uuid.uuid4())
    print(relevantinfo)
    PatientData.objects.create(patientname=patientname, doctorname=doctorname, age=age, relevantinfo=relevantinfo, uuid=uuid_)
    return JsonResponse({'success': True})
    
@require_http_methods(["DELETE"])
def delete_patient(request, uuid_):
    PatientData.objects.filter(uuid=uuid_).delete()
    return JsonResponse({"success": True})

def patient_view(request, uuid_):
    print(uuid_)
    weekdatas = WeekData.objects.filter(username=uuid_)
    patient = PatientData.objects.filter(uuid=uuid_)[0]
    print(patient.relevantinfo)
    weekdatas_json = serialize('json', weekdatas)
    context = {
        'range': range(1, 23),
        'process_integers_url': reverse('process_integers'),
        'user' : request.user,
        'weekdatas': weekdatas_json,
        'uuid_': uuid_,
        'patientdata': patient
        }
    return render(request, 'patients.html', context)

def signup_view(request):
   
    context = {
        'range': signup
        }
    return render(request, 'signup.html', context)


def login_view(request):
    context = {
        'range': 'login'
    }
    return render(request, 'login.html', context)

def doctor_view(request):
    patientdatas = PatientData.objects.filter(doctorname=request.user.username)
    patientdatas_json = serialize('json', patientdatas)
    userdata = UserProfile.objects.filter(user=request.user)[0]
    print(userdata)
    context = {
        'userdata' : userdata,
        'patientdatas': patientdatas_json,
    }
    return render(request, 'doctor.html', context)

def addpatient_view(request):
    context = {
        'range': 'addpatient'
    }
    return render(request, 'addpatient.html', context)

def view_report(request, uuid_):
    patientdata = PatientData.objects.filter(uuid=uuid_)[0]
    weekdatas = WeekData.objects.filter(username=uuid_)
    weekdatas_json = serialize('json', weekdatas)
    userdata = UserProfile.objects.filter(user=request.user)[0]
    print(userdata)
    context = {
        'range': 'view_report',
        'patientdata': patientdata,
        'weekdatas': weekdatas_json,
        'userdata': userdata   
    }
    return render(request, 'report.html', context)

@csrf_exempt
def view_contact(request):
    context = {
        'range': 'contact'
    }
    return render(request, 'contact.html', context)

def view_chart(request, uuid_, chart_type):
    weekdatas = WeekData.objects.filter(username=uuid_)
    weekdatas_json = serialize('json', weekdatas)

    context = {
        'range': 'chart',
        'weekdatas': weekdatas_json,
        'chart_type': chart_type,
    }
    return render(request, 'chart.html', context)

def view_home(request):
    context = {
        'range': 'home'
    }
    return render(request, 'home.html', context)