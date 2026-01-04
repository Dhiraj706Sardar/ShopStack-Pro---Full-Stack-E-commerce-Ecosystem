package com.ecommerce.exception;

import com.ecommerce.dto.MessageResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

@ControllerAdvice
public class GlobalExceptionHandler {

    private static final org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(org.springframework.web.HttpMediaTypeNotSupportedException.class)
    public ResponseEntity<?> handleHttpMediaTypeNotSupportedException(
            org.springframework.web.HttpMediaTypeNotSupportedException ex, WebRequest request) {
        logger.error("Media type not supported: {}", ex.getMessage());
        return new ResponseEntity<>(new MessageResponse(ex.getMessage()), HttpStatus.UNSUPPORTED_MEDIA_TYPE);
    }

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<?> handleResourceNotFoundException(ResourceNotFoundException ex, WebRequest request) {
        logger.error("Resource not found: {}", ex.getMessage());
        return new ResponseEntity<>(new MessageResponse(ex.getMessage()), HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(APIException.class)
    public ResponseEntity<?> handleAPIException(APIException ex, WebRequest request) {
        logger.error("API Error: {}", ex.getMessage());
        return new ResponseEntity<>(new MessageResponse(ex.getMessage()), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<?> handleRuntimeException(RuntimeException ex, WebRequest request) {
        logger.error("Runtime Exception: ", ex);
        return new ResponseEntity<>(new MessageResponse(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<?> handleGlobalException(Exception ex, WebRequest request) {
        logger.error("Global Exception: ", ex);
        return new ResponseEntity<>(new MessageResponse(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
