<!-- Add feedback form -->
<div class="card mt-4">
    <div class="card-body">
        <h5 class="card-title">Course Feedback</h5>

        <form action="feedback" method="POST" id="feedbackForm">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="courseId" value="${course.id}">

            <div class="mb-3">
                <label class="form-label">Rating</label>
                <div class="rating">
                    <input type="radio" name="rating" value="5" id="5" required><label for="5">☆</label>
                    <input type="radio" name="rating" value="4" id="4"><label for="4">☆</label>
                    <input type="radio" name="rating" value="3" id="3"><label for="3">☆</label>
                    <input type="radio" name="rating" value="2" id="2"><label for="2">☆</label>
                    <input type="radio" name="rating" value="1" id="1"><label for="1">☆</label>
                </div>
            </div>

            <div class="mb-3">
                <label for="comment" class="form-label">Your Comment</label>
                <textarea class="form-control" id="comment" name="comment" rows="3" required></textarea>
            </div>

            <button type="submit" class="btn btn-primary">Submit Feedback</button>
        </form>
    </div>
</div>

<style>
.rating {
    display: flex;
    flex-direction: row-reverse;
    justify-content: flex-end;
}

.rating:not(:checked) > input {
    position: absolute;
    top: -9999px;
}

.rating:not(:checked) > label {
    float: right;
    width: 1em;
    padding: 0 .1em;
    overflow: hidden;
    white-space: nowrap;
    cursor: pointer;
    font-size: 200%;
    line-height: 1.2;
    color: #ddd;
}

.rating:not(:checked) > label:before {
    content: '★';
}

.rating > input:checked ~ label {
    color: #ffc700;
}

.rating:not(:checked) > label:hover,
.rating:not(:checked) > label:hover ~ label {
    color: #ffc700;
}

.rating > input:checked + label:hover,
.rating > input:checked + label:hover ~ label,
.rating > input:checked ~ label:hover,
.rating > input:checked ~ label:hover ~ label,
.rating > label:hover ~ input:checked ~ label {
    color: #ffd700;
}
</style>

<!-- Display success/error messages -->
<c:if test="${param.message == 'feedback_added'}">
    <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
        Thank you for your feedback!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:if test="${param.error != null}">
    <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
        <c:choose>
            <c:when test="${param.error == 'feedback_failed'}">
                Sorry, we couldn't save your feedback. Please try again.
            </c:when>
            <c:when test="${param.error == 'invalid_parameters'}">
                Invalid input parameters. Please check your input.
            </c:when>
            <c:otherwise>
                An error occurred. Please try again later.
            </c:otherwise>
        </c:choose>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
