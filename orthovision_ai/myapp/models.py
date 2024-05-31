from django.db import models

# Create your models here.
class XrayImages(models.Model):
    img = models.ImageField(upload_to='Xrayimages/')

class Doctor(models.Model):
    doctorid = models.CharField(max_length=50, primary_key=True)
    doctorname = models.CharField(max_length=100)
    hospital = models.CharField(max_length=100)
    rating = models.FloatField()
    speciality = models.CharField(max_length=100)
