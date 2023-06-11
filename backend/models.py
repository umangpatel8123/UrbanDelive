from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.


class User(AbstractUser):
    uid = models.CharField(
        blank=False, unique=True, default="xNO0HY79PvPY7N5upD561wE13MG3", max_length=50
    )
    email = models.EmailField()
    phoneNo = models.CharField(
        max_length=15, blank=False, unique=True, default="+441234123412"
    )
    username = models.CharField(max_length=50,unique=True)
    last_login = models.DateTimeField(auto_now=True)

    EMAIL_FIELD = "email"
    USERNAME_FIELD = "phoneNo"
    REQUIRED_FIELDS = ["uid", "username"]

    def __str__(self):
        return self.phoneNo


# User model
class Profile(models.Model):
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        related_name="user_profile",
    )
    dob = models.DateField(blank=True)
    bio = models.CharField(
        default="Hey there, I am using Urban Delive !!!",
        max_length=100,
    )
    addressLine1 = models.CharField(max_length=50, blank=False, default="")
    addressLine2 = models.CharField(max_length=50, blank=False, default="")
    isBusiness = models.ForeignKey(
        "Business", on_delete=models.CASCADE, null=True, blank=True
    )

    def __str__(self):
        return self.user.phoneNo


# Business model
class Business(models.Model):
    businessName = models.CharField(max_length=25, unique=True)
    businessNameSlug = models.CharField(max_length=25, null=True, unique=True)
    isActive = models.BooleanField(default=False)
    contactNo = models.IntegerField()
    businessCategory = models.CharField(max_length=50, default="")
    # latitude = models.CharField(max_length=100, default=0, blank=True)
    # longitude = models.CharField(max_length=100, default=0, blank=True)
    # location = [latitude, longitude]
    categories = models.ManyToManyField("Category", blank=True)

    def __str__(self):
        return "%s - Owned By -" % (self.businessName)


class Category(models.Model):
    categoryName = models.CharField(max_length=25)
    categoryType = models.CharField(max_length=25)
    items = models.ManyToManyField("Item", blank=True)

    def __str__(self):
        return self.categoryName


class Item(models.Model):
    itemName = models.CharField(max_length=25)
    quantity = models.IntegerField(default=0)
    image = models.ImageField(
        upload_to="item_image", blank=True, default="blank-profile-picture.png"
    )
    price = models.IntegerField()

    def __str__(self):
        return self.itemName
