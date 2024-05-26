from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm
from django import forms
from django.core.validators import MinLengthValidator

class RegistrationForm(UserCreationForm):
  class Meta:
    model = User
    fields = ['username','first_name','last_name', 'email']

class PasswordResetRequestForm(forms.Form):
    email = forms.EmailField(label='Email', max_length=254)

class SetNewPasswordForm(forms.Form):
    password = forms.CharField(
        label='New Password',
        max_length=128,
        widget=forms.PasswordInput,
        validators=[MinLengthValidator(8)],
    )
    confirm_password = forms.CharField(
        label='Confirm Password',
        max_length=128,
        widget=forms.PasswordInput,
    )

    def clean(self):
        cleaned_data = super().clean()
        password = cleaned_data.get("password")
        confirm_password = cleaned_data.get("confirm_password")

        if password != confirm_password:
            raise forms.ValidationError("Passwords do not match.")

        return cleaned_data