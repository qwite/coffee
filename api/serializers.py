from rest_framework import serializers

from api.models import Cafe, Coffee, Order, OrderItem


class CoffeeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coffee
        fields = ('id', 'name', 'description', 'price', 'cafe', 'get_absolute_url', 'image', 'thumbnail')

class OrderItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderItem
        fields = ('id', 'order', 'coffee', 'size', 'quantity', 'get_cost', 'added')


class OrderSerializer(serializers.ModelSerializer):
    items = OrderItemSerializer(many=True, read_only=True)

    class Meta:
        model = Order
        fields = ('id', 'user', 'cafe', 'items', 'get_total_cost', 'created', 'is_paid')

class CafeSerializer(serializers.ModelSerializer):
    orders = OrderSerializer(many=True, read_only=True)
    coffee = CoffeeSerializer(many=True, read_only=True)

    class Meta:
        model = Cafe
        fields = ('id', 'address', 'coffee', 'orders', 'get_absolute_url')

