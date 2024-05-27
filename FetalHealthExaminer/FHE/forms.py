from django import forms
from django.contrib.auth.models import User
from .models import UserProfile

class UserLoginForm(forms.Form):
    username = forms.CharField(max_length=100)
    password = forms.CharField(widget=forms.PasswordInput())

class SignUpForm(forms.Form):
    username = forms.CharField(max_length=100)
    email = forms.EmailField()
    phone_number = forms.CharField(max_length=15)
    hospital = forms.CharField(max_length=100)
    specialization = forms.CharField(max_length=100)
    city = forms.CharField(max_length=100)
    password = forms.CharField(widget=forms.PasswordInput())
    retype_password = forms.CharField(widget=forms.PasswordInput())

    def clean_username(self):
        username = self.cleaned_data['username']
        if User.objects.filter(username=username).exists():
            raise forms.ValidationError("Username is already taken.")
        return username

    def clean(self):
        cleaned_data = super().clean()
        password = cleaned_data.get('password')
        retype_password = cleaned_data.get('retype_password')

        if password and retype_password and password != retype_password:
            raise forms.ValidationError("Passwords do not match.")

        return cleaned_data
