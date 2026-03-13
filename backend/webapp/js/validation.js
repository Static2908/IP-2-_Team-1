// Form Validation Functions
function validateEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

function validateUsername(username) {
    return username.length >= 3 && username.length <= 50;
}

function validatePassword(password) {
    return password.length >= 6;
}

function validateCGPA(cgpa) {
    const cgpaNum = parseFloat(cgpa);
    return cgpaNum >= 0 && cgpaNum <= 10;
}

function showError(fieldId, message) {
    const field = document.getElementById(fieldId);
    if (field) {
        field.classList.add('error');
        const errorMsg = document.createElement('span');
        errorMsg.className = 'error-message';
        errorMsg.textContent = message;
        field.parentNode.insertBefore(errorMsg, field.nextSibling);
    }
}

function clearErrors() {
    document.querySelectorAll('.error-message').forEach(el => el.remove());
    document.querySelectorAll('.error').forEach(el => el.classList.remove('error'));
}

// Login Form Validation
document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            e.preventDefault();
            clearErrors();
            
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            
            let isValid = true;
            
            if (!validateUsername(username)) {
                showError('username', 'Username must be 3-50 characters');
                isValid = false;
            }
            
            if (!validatePassword(password)) {
                showError('password', 'Password must be at least 6 characters');
                isValid = false;
            }
            
            if (isValid) {
                console.log('Login form submitted:', { username });
                // Submit to backend
                this.submit();
            }
        });
    }

    // Student Registration Form Validation
    const studentForm = document.getElementById('studentForm');
    if (studentForm) {
        studentForm.addEventListener('submit', function(e) {
            e.preventDefault();
            clearErrors();
            
            const firstName = document.getElementById('firstName').value;
            const lastName = document.getElementById('lastName').value;
            const email = document.getElementById('email').value;
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const department = document.getElementById('department').value;
            const semester = document.getElementById('semester').value;
            const cgpa = document.getElementById('cgpa').value;
            
            let isValid = true;
            
            if (firstName.trim().length === 0) {
                showError('firstName', 'First name is required');
                isValid = false;
            }
            
            if (lastName.trim().length === 0) {
                showError('lastName', 'Last name is required');
                isValid = false;
            }
            
            if (!validateEmail(email)) {
                showError('email', 'Please enter a valid email');
                isValid = false;
            }
            
            if (!validateUsername(username)) {
                showError('username', 'Username must be 3-50 characters');
                isValid = false;
            }
            
            if (!validatePassword(password)) {
                showError('password', 'Password must be at least 6 characters');
                isValid = false;
            }
            
            if (department === '') {
                showError('department', 'Please select a department');
                isValid = false;
            }
            
            if (semester === '' || semester < 1 || semester > 8) {
                showError('semester', 'Semester must be between 1 and 8');
                isValid = false;
            }
            
            if (!validateCGPA(cgpa)) {
                showError('cgpa', 'CGPA must be between 0 and 4');
                isValid = false;
            }
            
            if (isValid) {
                console.log('Student form submitted successfully');
                this.submit();
            }
        });
    }

    // Skill Form Validation
    const skillForm = document.getElementById('skillForm');
    if (skillForm) {
        skillForm.addEventListener('submit', function(e) {
            e.preventDefault();
            clearErrors();
            
            const skillName = document.getElementById('skillName').value;
            const proficiencyLevel = document.querySelector('input[name="proficiencyLevel"]:checked');
            const experience = document.getElementById('experience').value;
            
            let isValid = true;
            
            if (skillName === '') {
                showError('skillName', 'Please select a skill');
                isValid = false;
            }
            
            if (!proficiencyLevel) {
                showError('level1', 'Please select a proficiency level');
                isValid = false;
            }
            
            if (experience === '' || experience < 0) {
                showError('experience', 'Please enter valid years of experience');
                isValid = false;
            }
            
            if (isValid) {
                console.log('Skill form submitted:', { skillName, proficiencyLevel: proficiencyLevel.value, experience });
                this.submit();
            }
        });
    }
});
