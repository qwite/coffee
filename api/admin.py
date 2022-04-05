from django.contrib import admin

# Register your models here.
from api.models import CustomUser, Cafe, Coffee, Order

admin.site.register(CustomUser)
admin.site.register(Cafe)
admin.site.register(Coffee)
admin.site.register(Order)