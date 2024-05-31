from django.contrib import admin
from django.urls import path
from . import views
from django.conf import settings
from django.conf.urls.static import static
urlpatterns = [
    path('',views.Login,name="login"),
    path('signup/',views.signup,name="signup"),
    path('upload/',views.upload,name="upload"),
    path('success/',views.success,name="success"),
    path('fail/',views.success,name="fail"),
    path('doctors/',views.doctors,name="doctors"),
]
if settings.DEBUG:
        urlpatterns += static(settings.MEDIA_URL,
                              document_root=settings.MEDIA_ROOT)