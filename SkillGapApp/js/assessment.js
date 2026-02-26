// Assessment page logic (same as frontend/js/assessment.js)
let currentQuestionIndex = 0;
let score = 0;
const quizContainer = document.getElementById("quiz-container");
const questionElement = document.getElementById("question");
const answersElement = document.getElementById("answers");
const nextBtn = document.getElementById("next-btn");

function showQuestion() {
    const q = questions[currentQuestionIndex];
    questionElement.textContent = (currentQuestionIndex + 1) + ". " + q.question;
    answersElement.innerHTML = "";
    q.options.forEach((option, index) => {
        const li = document.createElement("li");
        li.innerHTML = `<label><input type='radio' name='answer' value='${index}'> ${option}</label>`;
        answersElement.appendChild(li);
    });
}

function showNextQuestion() {
    const selected = document.querySelector('input[name="answer"]:checked');
    if (!selected) { alert("Please select an answer."); return; }

    if (parseInt(selected.value) === questions[currentQuestionIndex].correct)
        score++;

    currentQuestionIndex++;
    if (currentQuestionIndex < questions.length) {
        showQuestion();
    } else {
        displayResult();
    }
}

function displayResult() {
    const percentage = Math.round((score / questions.length) * 100);
    quizContainer.innerHTML = `<div class='result-section'><h2>You scored ${percentage}%</h2><a href='/SkillGapApp/dashboard.jsp'>View Dashboard</a></div>`;
}

nextBtn.addEventListener("click", showNextQuestion);

// Example questions - replace with dynamic content as needed
const questions = [
    { question: "What is Java?", options: ["Programming language", "Coffee", "Island"], correct: 0 },
    { question: "What is Servlet?", options: ["Thermometer", "Java class", "Web component"], correct: 2 },
    { question: "Which company developed Java?", options: ["Oracle", "Microsoft", "Google"], correct: 0 }
];