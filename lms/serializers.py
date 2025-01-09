from rest_framework.serializers import ModelSerializer, SerializerMethodField

from lms.models import Course, Lesson


class CourseSerializer(ModelSerializer):
    count_of_lessons = SerializerMethodField()

    def get_count_of_lessons(self, obj):
        return obj.lesson_set.count()

    class Meta:
        model = Course
        fields = "__all__"


class LessonSerializer(ModelSerializer):
    class Meta:
        model = Lesson
        fields = "__all__"
