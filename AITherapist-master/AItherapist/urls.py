from django.urls import path
from . import views
from .views import CustomPasswordResetView, CustomPasswordResetConfirmView

urlpatterns = [
  path('', views.home, name='home'),  # Set home view as the default URL
  path('signin/', views.signin, name='signin'),
  path('signup/', views.signup, name='signup'),
  path('chatbot_success/<uidb64>/<token>/', views.chatbot_success, name='chatbot_success'),
  path('password/reset/', CustomPasswordResetView.as_view(), name='password_reset'),
  path('password/reset/confirm/<uidb64>/<tok>/', CustomPasswordResetConfirmView.as_view(), name='password_reset_confirm'),
  path('password-reset/', views.password_reset_request, name='password_reset_request')

]
