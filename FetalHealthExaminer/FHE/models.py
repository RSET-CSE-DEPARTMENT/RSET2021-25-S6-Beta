from django.contrib.auth.models import User
from django.db import models

class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    phone_number = models.CharField(max_length=15)
    hospital = models.CharField(max_length=100)
    specialization = models.CharField(max_length=100)
    city = models.CharField(max_length=100)

    def __str__(self):
        return self.user.username
    
class WeekData(models.Model):
    week_name = models.CharField(max_length=100)
    username = models.CharField(max_length=100) 
    abnormality = models.CharField(max_length=100)
    numbers = models.JSONField()

    def __str__(self):
        return f"{self.username} - {self.week_name}"
    
class PatientData(models.Model):
    patientname = models.CharField(max_length=100)
    doctorname = models.CharField(max_length=100)
    age = models.IntegerField()
    relevantinfo = models.CharField(max_length=300)
    uuid = models.CharField(max_length=100)

    def __str__(self):
        return self.patientname
    