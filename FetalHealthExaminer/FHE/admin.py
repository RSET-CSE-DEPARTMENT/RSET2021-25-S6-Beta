from django.contrib import admin

# Register your models here.
from .models import UserProfile,WeekData,PatientData

admin.site.register(UserProfile)
admin.site.register(WeekData)
admin.site.register(PatientData)

