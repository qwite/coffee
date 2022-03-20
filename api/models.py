from io import BytesIO
from PIL import Image
from phonenumber_field.modelfields import PhoneNumberField
from pytils.translit import slugify

from django.contrib.auth.base_user import AbstractBaseUser, BaseUserManager
from django.contrib.auth.models import PermissionsMixin
from django.core.files import File
from django.utils.translation import gettext_lazy as _
from django.db import models


class CustomAccountManager(BaseUserManager):

    def _create_user(self, phone_number, password, is_active, is_staff, is_superuser, **extra_fields):
        if not phone_number:
            raise ValueError(_('You must provide a phone number'))
        user = self.model(phone_number=phone_number, is_active=is_active, is_staff=is_staff, is_superuser=is_superuser,
                          **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, phone_number, password, **extra_fields):
        return self._create_user(phone_number, password, is_active=True, is_staff=False, is_superuser=False,
                                 **extra_fields)

    def create_superuser(self, phone_number, password, **extra_fields):
        user = self._create_user(phone_number, password, is_active=True, is_staff=True, is_superuser=True,
                                 **extra_fields)
        user.save(using=self._db)
        return user


class CustomUser(AbstractBaseUser, PermissionsMixin):
    phone_number = PhoneNumberField('Номер телефона', unique=True)
    password = models.CharField(_("Пароль"), max_length=128)
    first_name = models.CharField('Имя', max_length=15)
    date_joined = models.DateTimeField('Дата регистрации', auto_now_add=True)
    is_staff = models.BooleanField('Администратор', default=False)
    is_active = models.BooleanField('Активен', default=True)
    is_superuser = models.BooleanField('Суперадмин', default=False)

    objects = CustomAccountManager()

    USERNAME_FIELD = 'phone_number'

    REQUIRED_FIELDS = ['password', 'first_name']

    class Meta:
        ordering = ['-date_joined']
        verbose_name = 'Пользователь'
        verbose_name_plural = 'Пользователи'

    def __str__(self):
        return str(self.phone_number)


class Cafe(models.Model):
    address = models.CharField('Адрес', max_length=255)
    slug = models.SlugField(unique=True)

    class Meta:
        ordering = ['address']
        verbose_name = 'Кофейня'
        verbose_name_plural = 'Кофейни'

    def __str__(self):
        return self.address

    def save(self, *args, **kwargs):
        self.slug = slugify(self.address)
        super(Cafe, self).save(*args, **kwargs)

    def get_absolute_url(self):
        return f'/{self.slug}/'


class Coffee(models.Model):
    name = models.CharField('Название', max_length=255)
    description = models.TextField()
    price = models.PositiveIntegerField('Цена')
    cafe = models.ForeignKey(Cafe, related_name='coffee', on_delete=models.CASCADE)
    slug = models.SlugField()
    image = models.ImageField('Изображение', upload_to='uploads/')
    thumbnail = models.ImageField('Миниатюра', upload_to='uploads', blank=True, null=True)

    class Meta:
        ordering = ['name']
        verbose_name = 'Кофе'
        verbose_name_plural = 'Кофе'

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        self.slug = slugify(self.name)
        super(Coffee, self).save(*args, **kwargs)

    def get_absolute_url(self):
        return f'/{self.cafe.slug}/{self.slug}'

    def get_image(self):
        return 'http://127.0.0.1:8000/' + self.image.url

    def get_thumbnail(self):
        if self.thumbnail:
            return 'http://127.0.0.1:8000/' + self.thumbnail.url
        else:
            self.thumbnail = self.make_thumbnail(self.image)
            self.save()

            return 'http://127.0.0.1:8000/' + self.thumbnail.url

    def make_thumbnail(self, image, size=(300, 200)):
        img = Image.open(image)
        img.convert('RGB')
        img.thumbnail(size)

        thumb_io = BytesIO()
        img.save(thumb_io, 'JPEG', quality=85)

        thumbnail = File(thumb_io, name=image.name)

        return thumbnail


class Order(models.Model):
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE, unique=True)
    cafe = models.ForeignKey(Cafe, related_name='orders', on_delete=models.CASCADE)
    created = models.DateTimeField('Дата создания', auto_now_add=True)
    is_paid = models.BooleanField('Оплачен', default=False)

    class Meta:
        ordering = ['-created']
        verbose_name = 'Заказ'
        verbose_name_plural = 'Заказы'

    def __str__(self):
        return f'Заказ №{self.id}'

    def get_total_cost(self):
        return sum(item.get_cost() for item in self.items.all())


class OrderItem(models.Model):
    SIZE = [
        ('S', 'Small'),
        ('M', 'Medium'),
        ('L', 'Large')
    ]

    order = models.ForeignKey(Order, related_name='items', on_delete=models.CASCADE)
    coffee = models.ForeignKey(Coffee, related_name='order_coffee', on_delete=models.CASCADE)
    size = models.CharField('Размер', max_length=1, choices=SIZE, default='S')
    quantity = models.PositiveIntegerField(default=1)
    added = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['added']

    def __str__(self):
        return f'{self.coffee.name} x {self.quantity} ({self.size}) из заказа №{self.order.id}'

    def get_cost(self):
        return self.coffee.price * self.quantity
