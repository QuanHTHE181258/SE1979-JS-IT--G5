package project.demo.coursemanagement.dto;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;


public class ValidationResult {

    private boolean valid;
    private List<String> errors;
    private List<String> warnings;
    private String successMessage;

    /**
     * Default constructor - creates valid result with no errors
     */
    public ValidationResult() {
        this.valid = true;
        this.errors = new ArrayList<>();
        this.warnings = new ArrayList<>();
    }

    /**
     * Constructor with validation status and errors
     */
    public ValidationResult(boolean valid, List<String> errors) {
        this.valid = valid;
        this.errors = errors != null ? new ArrayList<>(errors) : new ArrayList<>();
        this.warnings = new ArrayList<>();
    }

    /**
     * Constructor with single error
     */
    public ValidationResult(boolean valid, String error) {
        this.valid = valid;
        this.errors = new ArrayList<>();
        this.warnings = new ArrayList<>();

        if (error != null && !error.trim().isEmpty()) {
            this.errors.add(error.trim());
        }
    }

    /**
     * Create successful validation result
     */
    public static ValidationResult success() {
        return new ValidationResult(true, (List<String>) null);
    }

    /**
     * Create successful validation result with message
     */
    public static ValidationResult success(String message) {
        ValidationResult result = new ValidationResult(true, (List<String>) null);
        result.setSuccessMessage(message);
        return result;
    }

    /**
     * Create failed validation result with single error
     */
    public static ValidationResult failure(String error) {
        return new ValidationResult(false, error);
    }

    /**
     * Create failed validation result with multiple errors
     */
    public static ValidationResult failure(List<String> errors) {
        return new ValidationResult(false, errors);
    }

    /**
     * Create failed validation result with multiple errors (varargs)
     */
    public static ValidationResult failure(String... errors) {
        return new ValidationResult(false, Arrays.asList(errors));
    }

    // Getters and Setters

    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }

    public List<String> getErrors() {
        return Collections.unmodifiableList(errors);
    }

    public void setErrors(List<String> errors) {
        this.errors = errors != null ? new ArrayList<>(errors) : new ArrayList<>();
        // If there are errors, result should not be valid
        if (!this.errors.isEmpty()) {
            this.valid = false;
        }
    }

    public List<String> getWarnings() {
        return Collections.unmodifiableList(warnings);
    }

    public void setWarnings(List<String> warnings) {
        this.warnings = warnings != null ? new ArrayList<>(warnings) : new ArrayList<>();
    }

    public String getSuccessMessage() {
        return successMessage;
    }

    public void setSuccessMessage(String successMessage) {
        this.successMessage = successMessage;
    }

    // Helper methods

    /**
     * Add a single error
     */
    public void addError(String error) {
        if (error != null && !error.trim().isEmpty()) {
            this.errors.add(error.trim());
            this.valid = false;
        }
    }

    /**
     * Add multiple errors
     */
    public void addErrors(List<String> errors) {
        if (errors != null) {
            for (String error : errors) {
                addError(error);
            }
        }
    }

    /**
     * Add multiple errors (varargs)
     */
    public void addErrors(String... errors) {
        if (errors != null) {
            for (String error : errors) {
                addError(error);
            }
        }
    }

    /**
     * Add a single warning
     */
    public void addWarning(String warning) {
        if (warning != null && !warning.trim().isEmpty()) {
            this.warnings.add(warning.trim());
        }
    }

    /**
     * Add multiple warnings
     */
    public void addWarnings(List<String> warnings) {
        if (warnings != null) {
            for (String warning : warnings) {
                addWarning(warning);
            }
        }
    }

    /**
     * Check if there are any errors
     */
    public boolean hasErrors() {
        return !errors.isEmpty();
    }

    /**
     * Check if there are any warnings
     */
    public boolean hasWarnings() {
        return !warnings.isEmpty();
    }

    /**
     * Get total number of errors
     */
    public int getErrorCount() {
        return errors.size();
    }

    /**
     * Get total number of warnings
     */
    public int getWarningCount() {
        return warnings.size();
    }

    /**
     * Get first error message (if any)
     */
    public String getFirstError() {
        return errors.isEmpty() ? null : errors.get(0);
    }

    /**
     * Get first warning message (if any)
     */
    public String getFirstWarning() {
        return warnings.isEmpty() ? null : warnings.get(0);
    }

    /**
     * Get all errors as a single string (separated by newlines)
     */
    public String getErrorsAsString() {
        return String.join("\n", errors);
    }

    /**
     * Get all errors as a single string with custom separator
     */
    public String getErrorsAsString(String separator) {
        return String.join(separator, errors);
    }

    /**
     * Get all warnings as a single string (separated by newlines)
     */
    public String getWarningsAsString() {
        return String.join("\n", warnings);
    }

    /**
     * Clear all errors and warnings
     */
    public void clear() {
        this.errors.clear();
        this.warnings.clear();
        this.valid = true;
        this.successMessage = null;
    }

    /**
     * Clear only errors
     */
    public void clearErrors() {
        this.errors.clear();
        // Revalidate: if no errors, result is valid
        if (this.errors.isEmpty()) {
            this.valid = true;
        }
    }

    /**
     * Clear only warnings
     */
    public void clearWarnings() {
        this.warnings.clear();
    }

    /**
     * Merge another ValidationResult into this one
     */
    public void merge(ValidationResult other) {
        if (other != null) {
            this.addErrors(other.getErrors());
            this.addWarnings(other.getWarnings());

            // If other result is invalid, this becomes invalid too
            if (!other.isValid()) {
                this.valid = false;
            }

            // Preserve success message if this result doesn't have one
            if (this.successMessage == null && other.getSuccessMessage() != null) {
                this.successMessage = other.getSuccessMessage();
            }
        }
    }

    // Create a copy of this ValidationResult
    public ValidationResult copy() {
        ValidationResult copy = new ValidationResult(this.valid, this.errors);
        copy.setWarnings(this.warnings);
        copy.setSuccessMessage(this.successMessage);
        return copy;
    }

    // Check if validation passed without errors or warnings
    public boolean isPerfect() {
        return valid && errors.isEmpty() && warnings.isEmpty();
    }

    // Check if validation passed with warnings
    public boolean isValidWithWarnings() {
        return valid && !warnings.isEmpty();
    }

    // Get a summary of the validation result
    public String getSummary() {
        if (valid) {
            if (warnings.isEmpty()) {
                return "Validation passed successfully";
            } else {
                return "Validation passed with " + warnings.size() + " warning(s)";
            }
        } else {
            return "Validation failed with " + errors.size() + " error(s)";
        }
    }

    //Convert to JSON string representation
    public String toJsonString() {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"valid\":").append(valid).append(",");
        json.append("\"errors\":[");
        for (int i = 0; i < errors.size(); i++) {
            if (i > 0) json.append(",");
            json.append("\"").append(errors.get(i).replace("\"", "\\\"")).append("\"");
        }
        json.append("],");
        json.append("\"warnings\":[");
        for (int i = 0; i < warnings.size(); i++) {
            if (i > 0) json.append(",");
            json.append("\"").append(warnings.get(i).replace("\"", "\\\"")).append("\"");
        }
        json.append("]");
        if (successMessage != null) {
            json.append(",\"successMessage\":\"").append(successMessage.replace("\"", "\\\"")).append("\"");
        }
        json.append("}");
        return json.toString();
    }

    /**
     * Create ValidationResult from exception
     */
    public static ValidationResult fromException(Exception e) {
        String message = e.getMessage() != null ? e.getMessage() : "An unexpected error occurred";
        return ValidationResult.failure(message);
    }

    /**
     * Create ValidationResult for field validation
     */
    public static ValidationResult forField(String fieldName, String errorMessage) {
        return ValidationResult.failure(fieldName + ": " + errorMessage);
    }

    /**
     * Combine multiple validation results
     */
    public static ValidationResult combine(ValidationResult... results) {
        ValidationResult combined = ValidationResult.success();

        for (ValidationResult result : results) {
            if (result != null) {
                combined.merge(result);
            }
        }

        return combined;
    }

    /**
     * Combine multiple validation results from list
     */
    public static ValidationResult combine(List<ValidationResult> results) {
        ValidationResult combined = ValidationResult.success();

        if (results != null) {
            for (ValidationResult result : results) {
                if (result != null) {
                    combined.merge(result);
                }
            }
        }

        return combined;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("ValidationResult{");
        sb.append("valid=").append(valid);
        sb.append(", errors=").append(errors.size());
        sb.append(", warnings=").append(warnings.size());
        if (successMessage != null) {
            sb.append(", successMessage='").append(successMessage).append('\'');
        }
        sb.append('}');
        return sb.toString();
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;

        ValidationResult that = (ValidationResult) obj;

        if (valid != that.valid) return false;
        if (!errors.equals(that.errors)) return false;
        if (!warnings.equals(that.warnings)) return false;
        return successMessage != null ? successMessage.equals(that.successMessage) : that.successMessage == null;
    }

    @Override
    public int hashCode() {
        int result = (valid ? 1 : 0);
        result = 31 * result + errors.hashCode();
        result = 31 * result + warnings.hashCode();
        result = 31 * result + (successMessage != null ? successMessage.hashCode() : 0);
        return result;
    }
}