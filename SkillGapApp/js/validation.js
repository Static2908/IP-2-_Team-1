// Input validation routines (frontend/js/validation.js)

function validateNotEmpty(value) {
    return value && value.trim().length > 0;
}

function validateEmail(email) {
    const re = /^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$/;
    return re.test(email);
}

function validatePassword(pass) {
    return pass && pass.length >= 6;
}