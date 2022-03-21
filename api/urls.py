from django.urls import path, include, re_path

from api import views

urlpatterns = [
    path('auth/', include('djoser.urls')),
    re_path(r'^auth/', include('djoser.urls.authtoken')),
    #path('drf-auth/', include('rest_framework.urls')),
    path('cafe/', views.CafeAPIList.as_view()),
    path('coffee/', views.CoffeeAPIList.as_view()),
    path('orders/', views.OrderAPIList.as_view()),
    path('order-items/', views.OrderItemAPIList.as_view()),
    path('order-items/<int:pk>/', views.OrderItemAPIDetailView.as_view(), name='order-item-detail'),
    path('cafe/<slug:cafe_slug>/', views.CafeAPIDetailView.as_view()),
    path('cafe/<slug:cafe_slug>/coffee', views.CafeCoffeeAPIList.as_view()),
    path('coffee/<int:pk>/', views.CoffeeAPIDetailView.as_view(), name='coffee-detail'),
    path('orders/<int:pk>/', views.OrderAPIDetailView.as_view(), name='order-detail'),
]