"""
URL configuration for miniproject project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
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
import sys
import os
from django.contrib import admin
from django.urls import path
from django.urls import path
from django.contrib import admin
from django.views.generic.base import RedirectView
from AItherapist.views import home,signup,signin,chatbot_success,password_reset_request,password_reset_confirm

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.append(BASE_DIR)

urlpatterns = [
    path('', RedirectView.as_view(pattern_name='home', permanent=False)),
    path('home/', home, name='home'),
    path('admin/', admin.site.urls),
    path('signup/', signup, name='signup'),
    path('signin/', signin, name='signin'),
    path('chatbot_success/<uidb64>/<token>/', chatbot_success, name='chatbot_success'),
    path('password-reset/', password_reset_request, name='password_reset_request'),
    path('password-reset/<uidb64>/<tok>/', password_reset_confirm, name='password_reset_confirm')
]

