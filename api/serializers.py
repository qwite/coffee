from rest_framework import serializers

from api.models import Cafe, Coffee, Order, OrderItem


class CafeSerializer(serializers.ModelSerializer):
    orders = serializers.HyperlinkedRelatedField(many=True, read_only=True, view_name='order-detail')
    coffee = serializers.HyperlinkedRelatedField(many=True, read_only=True, view_name='coffee-detail')

    class Meta:
        model = Cafe
        fields = ('id', 'address', 'coffee', 'orders', 'get_absolute_url')


class CoffeeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coffee
        fields = ('id', 'name', 'description', 'price', 'cafe', 'get_absolute_url', 'image', 'thumbnail')


class OrderSerializer(serializers.ModelSerializer):
    items = serializers.HyperlinkedRelatedField(many=True, read_only=True, view_name='order-item-detail')

    class Meta:
        model = Order
        fields = ('id', 'user', 'cafe', 'items', 'get_total_cost', 'created', 'is_paid')


class OrderItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderItem
        fields = ('id', 'order', 'coffee', 'size', 'quantity', 'get_cost', 'added')
