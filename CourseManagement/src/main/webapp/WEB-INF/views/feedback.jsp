<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Course Feedback</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
            gap: 10px;
        }
        .rating input {
            display: none;
        }
        .rating label {
            cursor: pointer;
            font-size: 30px;
            color: #ddd;
            transition: color 0.2s;
        }
        .rating label:before {
            content: '★';
        }
        .rating input:checked ~ label {
            color: #ffd700;
        }
        .rating label:hover,
        .rating label:hover ~ label {
            color: #ffd700;
        }
    </style>
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Course Feedback</h4>
        </div>

        <div class="card-body">
            <div class="mb-4">
                <h5>Course: ${course.title}</h5>
            </div>

            <form action="feedback" method="POST">
                <input type="hidden" name="courseId" value="${course.courseCode}">

                <div class="mb-4 text-center">
                    <h5>Rate this course</h5>
                    <div class="rating">
                        <input type="radio" name="rating" value="5" id="star5" required ${feedback != null && feedback.rating == 5 ? 'checked' : ''}>
                        <label for="star5" title="5 stars"></label>
                        <input type="radio" name="rating" value="4" id="star4" ${feedback != null && feedback.rating == 4 ? 'checked' : ''}>
                        <label for="star4" title="4 stars"></label>
                        <input type="radio" name="rating" value="3" id="star3" ${feedback != null && feedback.rating == 3 ? 'checked' : ''}>
                        <label for="star3" title="3 stars"></label>
                        <input type="radio" name="rating" value="2" id="star2" ${feedback != null && feedback.rating == 2 ? 'checked' : ''}>
                        <label for="star2" title="2 stars"></label>
                        <input type="radio" name="rating" value="1" id="star1" ${feedback != null && feedback.rating == 1 ? 'checked' : ''}>
                        <label for="star1" title="1 star"></label>
                    </div>
                </div>

                <div class="mb-4">
                    <label for="comment" class="form-label">Your feedback</label>
                    <textarea class="form-control" id="comment" name="comment" rows="4"
                              placeholder="Share your experience with this course...">${feedback != null ? feedback.comment : ''}</textarea>
                </div>

                <div class="text-center">
                    <a href="enrollments" class="btn btn-light me-2">Back</a>
                    <button type="submit" class="btn btn-primary">
                        ${feedback != null ? 'Update Feedback' : 'Submit Feedback'}
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
