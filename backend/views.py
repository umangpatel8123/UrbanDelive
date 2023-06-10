# api setup
from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.contrib.auth.hashers import make_password

# models
# from django.contrib.auth.models import User
from .models import Business, Profile, Item, Category, User

# serializers
from .serializers import (
    UserSerializer,
    UserProfileSerializer,
    BusinessSerializer,
    CategorySerializer,
    ItemSerializer,
)


# views
@api_view(["GET"])
def home(request):
    routes = [
        "Urban Deliv Api",
        {
            "Endpoint": "/",
            "method": "GET",
            "body": None,
            "description": "List of all available routes",
        },
        {
            "Endpoint": "checkUser/",
            "method": "POST",
            "body": {"uid": ""},
            "response": {"existing_user": "boolean"},
            "description": "returns True if user exists else False",
        },
    ]
    return Response(routes)


@api_view(["POST"])
def checkUser(request):
    if request.method == "POST":
        data = request.data
        if User.objects.filter(uid=data["uid"]).exists():
            user = User.objects.get(uid=data["uid"])
            if Profile.objects.filter(user=user).exists():
                return Response({"existing_user": True}, status=200)
            else:
                return Response({"existing_user": False}, status=200)
        else:
            return Response({"existing_user": False}, status=200)
    else:
        return Response("Method not allowed", status=405)


@api_view(["POST"])
def createUser(request):
    if request.method == "POST":
        data = request.data
        if User.objects.filter(uid=data["uid"]).exists():
            return Response(
                {"success": False, "msg": "User Already Exists"}, status=200
            )
        else:
            user = User.objects.create(
                uid=data["uid"],
                email=data["email"],
                phoneNo=data["phoneNo"],
                username=data["username"],
                password=make_password(data["password"]),
            )
            user.save()
            profile = Profile.objects.create(
                user=user,
                # dob=data["dob"],
                dob="2020-01-01",
                bio=data["bio"],
                addressLine1=data["addressLine1"],
                addressLine2=data["addressLine2"],
            )
            profile.save()
            return Response({"success": True}, status=200)
    else:
        return Response("Method not allowed", status=405)


@api_view(["POST"])
def getUser(request):
    if request.method == "POST":
        uid = request.data["uid"]
        if User.objects.filter(uid=uid).exists():
            user = User.objects.get(uid=uid)
            if Profile.objects.filter(user=user).exists():
                user_profile = Profile.objects.get(user=user)
                profile_serialzer = UserProfileSerializer(user_profile, many=False).data
                return Response({"error": False, "user": profile_serialzer}, status=200)
            else:
                return Response(
                    {"error": True, "msg": "User Profile does not exist"},
                    status=200,
                )
        else:
            return Response(
                {"error": True, "msg": "User does not exist"},
                status=200,
            )
    else:
        return Response("Method not allowed", status=405)


@api_view(["GET"])
def userProfile(request, username):
    if request.method == "GET":
        if User.objects.filter(username=username).exists():
            profile = Profile.objects.get(user=User.objects.get(username=username))
            serialized_profile = UserProfileSerializer(profile, many=False).data

            return Response(serialized_profile)

        else:
            return Response("User does't Exists !!", status=400)


@api_view(["GET"])
def allBusiness(request):
    if request.method == "GET":
        business_near_by = Profile.objects.all().exclude(isBusiness=None)
        serialized_business_near_by = UserProfileSerializer(
            business_near_by, many=True
        ).data

        return Response(serialized_business_near_by)


@api_view(["GET"])
def allCategories(request):
    categories = Category.objects.all()
    serialized_categories = CategorySerializer(categories, many=True).data
    print(serialized_categories)

    return Response(serialized_categories)


@api_view(["GET"])
def buisnessView(request, businessNameSlug):
    if request.method == "GET":
        if Business.objects.filter(businessNameSlug=businessNameSlug).exists():
            business = Business.objects.get(businessNameSlug=businessNameSlug)
            owner = Profile.objects.get(isBusiness=business)
            serialized_business_owner = UserProfileSerializer(owner).data

            return Response(serialized_business_owner)

        else:
            return Response("No such Business Exists !!", status=400)


@api_view(["GET"])
def toggleActive(request, businessNameSlug):
    if request.method == "GET":
        if Business.objects.filter(businessNameSlug=businessNameSlug).exists():
            business = Business.objects.get(businessNameSlug=businessNameSlug)
            business.isActive = not (business.isActive)
            business.save()

            return Response("Toggled Business")

        else:
            return Response("No such Business Exists !!", status=400)


@api_view(["POST"])
def updateQuantity(request, itemId):
    if request.method == "POST":
        data = request.data
        reqType = data["type"]

        if Item.objects.filter(id=itemId).exists():
            if reqType == "incr":
                item = Item.objects.get(id=itemId)
                item.quantity = item.quantity + 1
                item.save()

                return Response("Item Incremented")

            elif reqType == "decr":
                item = Item.objects.get(id=itemId)
                item.quantity = item.quantity - 1
                item.save()

                return Response("Item Decremented")

            elif reqType == "change":
                item = Item.objects.get(id=itemId)
                if not (data.quantity == 0):
                    item.quantity = data["quantity"]
                item.save()

            else:
                return Response("No such type exists")

        else:
            return Response("No such Item Exists !!", status=400)


@api_view(["POST"])
def add_item(request):
    if request.method == "POST":
        data = request.data

        if Business.objects.filter(businessNameSlug=data["businessNameSlug"]).exists():
            business = Business.objects.get(businessNameSlug=data["businessNameSlug"])
            item = Item.objects.create(itemName=data["item"], price=data["price"])
            item.save()
            category = business.categories.all().get(categoryName=data["category"])
            cat = Category.objects.get(id=category.id)
            cat.items.add(item)

            return Response("Item Added", status=200)
        else:
            return Response("No such Business Exists", status=400)

    else:
        return Response("Error")


@api_view(["POST"])
def add_business(request):
    if request.method == "POST":
        data = request.data

        business = Business.objects.create(
            businessName=data["businessName"],
            businessNameSlug=data["businessNameSlug"],
            contactNo=data["contactNo"],
            businessCategory=data["businessCategory"],
        )
        business.save()

        return Response("done")


@api_view(["POST"])
def add_item(request):
    if request.method == "POST":
        data = request.data

        if Business.objects.filter(businessNameSlug=data["businessNameSlug"]).exists():
            business = Business.objects.get(businessNameSlug=data["businessNameSlug"])
            item = Item.objects.create(
                itemName=data["item"], price=data["price"], quantity=data["quantity"]
            )
            item.save()
            category = business.categories.all().get(categoryName=data["category"])
            cat = Category.objects.get(id=category.id)
            cat.items.add(item)

            return Response("Item Added", status=200)
        else:
            return Response("No such Business Exists", status=400)

    else:
        return Response("Error")


@api_view(["POST"])
def add_category(request):
    if request.method == "POST":
        data = request.data

        if Business.objects.filter(businessNameSlug=data["businessNameSlug"]).exists():
            business = Business.objects.get(businessNameSlug=data["businessNameSlug"])
            cat = Category.objects.create(
                categoryName=data["categoryName"], categoryType=data["categoryType"]
            )
            cat.save()
            business.categories.add(cat)

            return Response("Category Added", status=200)
        else:
            return Response("No such Business Exists", status=400)

    else:
        return Response("Error")
