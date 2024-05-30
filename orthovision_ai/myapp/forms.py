from .models import *
from django.forms import ModelForm
from django.contrib.auth.forms import UserCreationForm
from django import forms
from django.contrib.auth.models import User
from django import forms
from .models import XrayImages
 
 
class XrayImgForm(forms.ModelForm):
 
    class Meta:
        model = XrayImages
        fields = ['img']
class CreateUserForm(UserCreationForm):
    class Meta:
        model = User
        fields = ['username', 'email', 'password1', 'password2']