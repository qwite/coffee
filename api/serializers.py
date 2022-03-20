from rest_framework import serializers

from api.models import Cafe, Coffee, Order, OrderItem, CustomUser


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ('id', 'phone_number', 'first_name', 'date_joined', 'is_staff', 'is_active', 'is_superuser')


class CafeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cafe
        fields = ('id', 'address', 'orders', 'get_absolute_url')


class CoffeeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coffee
        fields = ('id', 'name', 'description', 'price', 'cafe', 'get_absolute_url', 'image', 'thumbnail')


class OrderSerializer(serializers.ModelSerializer):
    items = serializers.StringRelatedField(many=True)

    class Meta:
        model = Order
        fields = ('id', 'user', 'cafe', 'items', 'get_total_cost', 'created', 'is_paid')


class OrderItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderItem
        fields = (
            'id', 'order', 'coffee', 'size', 'quantity', 'get_cost',
            'added')
