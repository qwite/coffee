from django.urls import path

from api import views

urlpatterns = [
    path('users/', views.UserAPIList.as_view()),
    path('cafe/', views.CafeAPIList.as_view()),
    path('coffee/', views.CoffeeAPIList.as_view()),
    path('orders/', views.OrderAPIList.as_view()),
    path('order-items/', views.OrderItemAPIList.as_view()),
    path('cafe/<slug:cafe_slug>/', views.CafeAPIDetailView.as_view()),
    path('cafe/<slug:cafe_slug>/<slug:coffee_slug>/', views.CoffeeAPIDetailView.as_view()),
    path('orders/<int:pk>/', views.OrderAPIDetailView.as_view()),
]