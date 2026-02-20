// Assessment and Quiz Functions

// Sample questions data
const assessmentData = {
    'Java': [
        {
            id: 1,
            question: 'What is the Java Virtual Machine (JVM)?',
            options: [
                'A physical machine that executes Java code',
                'An abstract computing machine that enables a computer to run Java programs',
                'A compiler for Java programs',
                'A type of memory in Java'
            ],
            correctAnswer: 1
        },
        {
            id: 2,
            question: 'What does OOP stand for?',
            options: [
                'Object Oriented Programming',
                'Object Oriented Process',
                'Object Optimization Process',
                'Open Online Platform'
            ],
            correctAnswer: 0
        }
    ],
    'Python': [
        {
            id: 1,
            question: 'What is a Python list?',
            options: [
                'A collection of ordered, changeable items',
                'A collection of unordered, unchangeable items',
                'A collection of random items',
                'A type of variable'
            ],
            correctAnswer: 0
        },
        {
            id: 2,
            question: 'What is the correct syntax for creating a function in Python?',
            options: [
                'def myFunction():',
                'function myFunction():',
                'func myFunction():',
                'define myFunction():'
            ],
            correctAnswer: 0
        }
    ]
};

// Assessment state
let currentAssessmentIndex = 0;
let currentSkill = '';
let userAnswers = [];
let assessmentStartTime = null;

// Initialize assessment
function initializeAssessment(skillName) {
    currentSkill = skillName;
    currentAssessmentIndex = 0;
    userAnswers = [];
    assessmentStartTime = new Date();
    
    const questions = getAssessmentQuestions(skillName);
    if (questions && questions.length > 0) {
        loadQuestion(0);
        updateProgress();
    }
}

// Get assessment questions for a skill
function getAssessmentQuestions(skillName) {
    return assessmentData[skillName] || [];
}

// Load a specific question
function loadQuestion(index) {
    const questions = getAssessmentQuestions(currentSkill);
    if (index < 0 || index >= questions.length) return;
    
    currentAssessmentIndex = index;
    const question = questions[index];
    
    const questionDiv = document.getElementById('questionDiv');
    if (questionDiv) {
        let optionsHTML = '';
        question.options.forEach((option, idx) => {
            optionsHTML += `
                <label>
                    <input type="radio" name="answer" value="${idx}" 
                        ${userAnswers[index] === idx ? 'checked' : ''}>
                    ${option}
                </label>
            `;
        });
        
        questionDiv.innerHTML = `
            <h3>${question.question}</h3>
            <div class="options">
                ${optionsHTML}
            </div>
        `;
    }
    
    updateProgress();
    updateButtons();
}

// Record answer
function recordAnswer() {
    const selected = document.querySelector('input[name="answer"]:checked');
    if (selected) {
        userAnswers[currentAssessmentIndex] = parseInt(selected.value);
    }
}

// Move to next question
function nextQuestion() {
    recordAnswer();
    const questions = getAssessmentQuestions(currentSkill);
    if (currentAssessmentIndex < questions.length - 1) {
        loadQuestion(currentAssessmentIndex + 1);
    }
}

// Move to previous question
function previousQuestion() {
    recordAnswer();
    if (currentAssessmentIndex > 0) {
        loadQuestion(currentAssessmentIndex - 1);
    }
}

// Update button states
function updateButtons() {
    const questions = getAssessmentQuestions(currentSkill);
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    const submitBtn = document.getElementById('submitBtn');
    
    if (prevBtn) prevBtn.disabled = currentAssessmentIndex === 0;
    if (nextBtn) {
        if (currentAssessmentIndex === questions.length - 1) {
            if (nextBtn) nextBtn.style.display = 'none';
            if (submitBtn) submitBtn.style.display = 'inline-block';
        } else {
            if (nextBtn) nextBtn.style.display = 'inline-block';
            if (submitBtn) submitBtn.style.display = 'none';
        }
    }
}

// Update progress bar
function updateProgress() {
    const questions = getAssessmentQuestions(currentSkill);
    const progress = ((currentAssessmentIndex + 1) / questions.length) * 100;
    
    const progressBar = document.getElementById('progressBar');
    if (progressBar) {
        progressBar.style.width = progress + '%';
    }
    
    const counter = document.getElementById('questionCounter');
    if (counter) {
        counter.textContent = `Question ${currentAssessmentIndex + 1} of ${questions.length}`;
    }
}

// Calculate assessment score
function calculateScore() {
    const questions = getAssessmentQuestions(currentSkill);
    let correctAnswers = 0;
    
    userAnswers.forEach((answer, index) => {
        if (answer === questions[index].correctAnswer) {
            correctAnswers++;
        }
    });
    
    const percentage = (correctAnswers / questions.length) * 100;
    const completionTime = Math.round((new Date() - assessmentStartTime) / 1000);
    
    return {
        totalQuestions: questions.length,
        correctAnswers: correctAnswers,
        wrongAnswers: questions.length - correctAnswers,
        percentage: Math.round(percentage),
        completionTime: completionTime,
        passingScore: 70
    };
}

// Submit assessment
function submitAssessment() {
    recordAnswer();
    
    const result = calculateScore();
    const isPassed = result.percentage >= result.passingScore;
    
    const resultDiv = document.getElementById('resultDiv');
    const quizContainer = document.getElementById('quizContainer');
    
    if (resultDiv && quizContainer) {
        quizContainer.style.display = 'none';
        resultDiv.style.display = 'block';
        
        document.getElementById('resultText').textContent = 
            isPassed ? 'Congratulations! You passed!' : 'Please try again later.';
        document.getElementById('scoreText').innerHTML = `
            <strong>Your Score: ${result.percentage}%</strong><br>
            Correct Answers: ${result.correctAnswers}/${result.totalQuestions}<br>
            Completion Time: ${result.completionTime} seconds
        `;
    }
    
    console.log('Assessment Result:', result);
    return result;
}

// Add event listeners for assessment page
document.addEventListener('DOMContentLoaded', function() {
    const nextBtn = document.getElementById('nextBtn');
    const prevBtn = document.getElementById('prevBtn');
    const submitBtn = document.getElementById('submitBtn');
    const quizForm = document.getElementById('quizForm');
    
    if (nextBtn) {
        nextBtn.addEventListener('click', function(e) {
            e.preventDefault();
            nextQuestion();
        });
    }
    
    if (prevBtn) {
        prevBtn.addEventListener('click', function(e) {
            e.preventDefault();
            previousQuestion();
        });
    }
    
    if (quizForm) {
        quizForm.addEventListener('submit', function(e) {
            e.preventDefault();
            submitAssessment();
        });
    }
});
