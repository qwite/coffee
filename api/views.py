from django.http import Http404
from django.shortcuts import render

from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.views import APIView

from api.models import CustomUser, Cafe, Coffee, Order, OrderItem
from api.permissions import IsAdminOrReadOnly
from api.serializers import UserSerializer, CafeSerializer, CoffeeSerializer, OrderSerializer, OrderItemSerializer


class UserAPIList(generics.ListAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer
    permission_classes = (IsAdminOrReadOnly,)


class CafeAPIList(generics.ListCreateAPIView):
    queryset = Cafe.objects.all()
    serializer_class = CafeSerializer
    permission_classes = (IsAdminOrReadOnly,)


class CafeAPIDetailView(APIView):
    permission_classes = (IsAdminOrReadOnly,)

    def get_object(self, cafe_slug):
        try:
            return Cafe.objects.get(slug=cafe_slug)
        except Cafe.DoesNotExist:
            return Http404

    def get(self, request, cafe_slug):
        instance = self.get_object(cafe_slug)
        serializer = CafeSerializer(instance)
        return Response(serializer.data)

    def delete(self, request, cafe_slug, *args, **kwargs):
        instance = self.get_object(cafe_slug)
        instance.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

    def put(self, request, cafe_slug, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object(cafe_slug)
        serializer = CafeSerializer(instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        if getattr(instance, '_prefetched_objects_cache', None):
            instance._prefetched_objects_cache = {}

        return Response(serializer.data)

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return self.put(request, *args, **kwargs)


class CoffeeAPIList(generics.ListCreateAPIView):
    queryset = Coffee.objects.all()
    serializer_class = CoffeeSerializer
    permission_classes = (IsAdminOrReadOnly,)


class CoffeeAPIDetailView(APIView):
    permission_classes = (IsAdminOrReadOnly,)

    def get_object(self, coffee_slug):
        try:
            return Coffee.objects.get(slug=coffee_slug)
        except Cafe.DoesNotExist:
            return Http404

    def get(self, request, coffee_slug, cafe_slug):
        instance = self.get_object(coffee_slug)
        serializer = CoffeeSerializer(instance)
        return Response(serializer.data)

    def delete(self, request, coffee_slug, cafe_slug, *args, **kwargs):
        instance = self.get_object(coffee_slug)
        instance.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

    def put(self, request, coffee_slug, cafe_slug, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object(coffee_slug)
        serializer = CoffeeSerializer(instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        if getattr(instance, '_prefetched_objects_cache', None):
            instance._prefetched_objects_cache = {}

        return Response(serializer.data)

    def partial_update(self, request, *args, **kwargs):
        kwargs['partial'] = True
        return self.put(request, *args, **kwargs)


class OrderAPIList(generics.ListCreateAPIView):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer
    permission_classes = (IsAdminOrReadOnly,)


class OrderAPIDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer
    permission_classes = (IsAdminOrReadOnly,)


class OrderItemAPIList(generics.ListCreateAPIView):
    queryset = OrderItem.objects.all()
    serializer_class = OrderItemSerializer
    #permission_classes = (IsAdminOrReadOnly,)