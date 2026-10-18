from django.urls import include, path
from django.contrib import admin

from . import health

urlpatterns = [
    path('healthz', health.healthz),
    path('readyz', health.readyz),
    path('polls/', include('polls.urls')),
    path('admin/', admin.site.urls),
]
