# Generated by Django 4.0.3 on 2022-03-19 22:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='coffee',
            name='price',
            field=models.DecimalField(decimal_places=4, max_digits=6, verbose_name='Цена'),
        ),
    ]
