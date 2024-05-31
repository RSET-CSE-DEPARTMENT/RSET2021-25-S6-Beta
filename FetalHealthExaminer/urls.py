"""
URL configuration for FetalHealthExaminer project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from FHE import views
from django.conf import settings

from django.contrib.staticfiles.urls import staticfiles_urlpatterns

urlpatterns = [
    path('admin/', admin.site.urls),
    path('login/', views.login_view, name='login'),
    path('login_user/', views.login_user, name='login_user'),
    path('home/', views.home, name='home'),
    path('signup/', views.signup_view, name='signup'),
    path('signup/success/', views.signup_success, name='signup_success'),
    path('process_integers/', views.process_integers, name='process_integers'),
    path('patient/<str:uuid_>/', views.patient_view, name='patient_view'),
    path('signin/', views.signin, name='signin'),
    path('doctor/', views.doctor_view, name='doctor'),
    path('addpatient/', views.addpatient_view, name='addpatient'),
    path('add_patient/', views.add_patient, name='add_patient'),
    path('deletepatient/<str:uuid_>/', views.delete_patient, name='delete_patient'),
    path('view_report/<str:uuid_>/', views.view_report, name='view_report'),
    path('contact/', views.view_contact, name='contact'),
    path('chart/<str:uuid_>/<int:chart_type>/', views.view_chart, name='chart'),
    path('', views.view_home, name='home')
    
] + staticfiles_urlpatterns()
