from django.http import Http404
from django.shortcuts import render

from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.views import APIView

from api.models import Cafe, Coffee, Order, OrderItem
from api.permissions import IsAdminOrReadOnly
from api.serializers import CafeSerializer, CoffeeSerializer, OrderSerializer, OrderItemSerializer


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
        serializer_context = {'request': request}
        instance = self.get_object(cafe_slug)
        serializer = CafeSerializer(instance=instance, context=serializer_context)
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
    queryset = Coffee.objects.all()
    serializer_class = CoffeeSerializer
    permission_classes = (IsAdminOrReadOnly,)


class CafeCoffeeAPIList(generics.ListCreateAPIView):
    serializer_class = CoffeeSerializer
    permission_classes = (IsAdminOrReadOnly,)

    def get_queryset(self):
        slug = self.kwargs['cafe_slug']
        return Coffee.objects.filter(cafe__slug=slug)


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
    # permission_classes = (IsAdminOrReadOnly,)


class OrderItemAPIDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = OrderItem.objects.all()
    serializer_class = OrderItemSerializer
