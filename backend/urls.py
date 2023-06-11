from django.urls import path
from . import views

urlpatterns = [
    path("", views.home, name="home"),
    path("checkUser/", views.checkUser, name="checkUser"),
    path("getUser/", views.getUser, name="getUser"),
    path("createUser/", views.createUser, name="createUser"),
    path("allBusinesses/", views.allBusiness, name="allBusinesses"),

    # not yet done
    # path("signUp/", views.SignUp, name="SignUp"),
    # path("login/", views.Login, name="Login"),
    # path("api/profile/<str:username>/", views.userProfile, name="userProfile"),

    path("api/business/addBusiness/", views.add_business, name="add_business"),
    path("api/businesses-near-me/", views.allBusiness, name="allBusiness"),
    path("api/business/updateItem/<str:itemId>/", views.updateQuantity, name="updateQuantity"),
    path("api/business/addItem/", views.add_item, name="add_item"),
    path("api/business/addCategory/", views.add_category, name="add_item"),
    path("api/all_categories/", views.allCategories, name="add_item"),
    path("api/business/<str:businessNameSlug>/", views.buisnessView, name="buisnessView"),
    path("api/business/<str:businessNameSlug>/", views.buisnessView, name="buisnessView"),
    path("api/business/<str:businessNameSlug>/toggleActive/", views.toggleActive, name="buisnessView"),
]
