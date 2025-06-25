//
//  ViewController.swift
//  Trivia
//
//  Created by J Walcott on 6/23/25.
//
import UIKit

// MARK: - Question Model
struct Question {
    let category: String
    let question: String
    let answers: [String]
    let correctIndex: Int
}

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var answerButton0: UIButton!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    
    @IBOutlet weak var restartButton: UIButton!

    // MARK: - Properties
    var questions: [Question] = []
    var currentQuestionIndex: Int = 0
    var score: Int = 0

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        questions = [
            Question(
                category: "Science",
                question: "Symbol for oxygen?",
                answers: ["H", "C", "O", "N"],
                correctIndex: 2
            ),
            Question(
                category: "History",
                question: "1st U.S President?",
                answers: ["Abraham Lincoln", "George Washington", "John Adams", "Thomas Jefferson"],
                correctIndex: 1
            ),
            Question(
                category: "Math",
                question: "What is 8 × 7?",
                answers: ["54", "56", "64", "49"],
                correctIndex: 1
            )
        ]

        restartButton.isHidden = true
        showQuestion()
    }

    // MARK: - Display a Question
    func showQuestion() {
        guard currentQuestionIndex < questions.count else {
            print("❗️No more questions to show.")
            return
        }

        let question = questions[currentQuestionIndex]

        questionLabel.text = question.question
        categoryLabel.text = "Category: \(question.category)"
        progressLabel.text = "Question \(currentQuestionIndex + 1) of \(questions.count)"

        
        questionLabel.adjustsFontSizeToFitWidth = true
            questionLabel.minimumScaleFactor = 0.5
            questionLabel.numberOfLines = 0
        
        
        answerButton0.setTitle(question.answers[0], for: .normal)
        answerButton1.setTitle(question.answers[1], for: .normal)
        answerButton2.setTitle(question.answers[2], for: .normal)
        answerButton3.setTitle(question.answers[3], for: .normal)
    }

    // MARK: - Handle Answer Taps
    @IBAction func answerTapped(_ sender: UIButton) {
        guard currentQuestionIndex < questions.count else { return }

        let question = questions[currentQuestionIndex]

        if sender.tag == question.correctIndex {
            print("✅ Correct!")
            score += 1
        } else {
            print("❌ Wrong.")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.goToNextQuestion()
        }
    }

    // MARK: - Move to Next Question
    func goToNextQuestion() {
        currentQuestionIndex += 1

           if currentQuestionIndex < questions.count {
               showQuestion()
           } else {
               // End of quiz
               questionLabel.text = "🎉 Quiz Complete!"
               categoryLabel.text = ""
               progressLabel.text = ""

               // Hide answer buttons
               answerButton0.isHidden = true
               answerButton1.isHidden = true
               answerButton2.isHidden = true
               answerButton3.isHidden = true

               // Show restart button with score
               restartButton.setTitle("Restart Quiz (\(score)/\(questions.count))", for: .normal)
               restartButton.isHidden = false
           }
       }

    // MARK: - Restart the Quiz
    @IBAction func restartQuizTapped(_ sender: UIButton) {
        currentQuestionIndex = 0
        score = 0

        answerButton0.isHidden = false
        answerButton1.isHidden = false
        answerButton2.isHidden = false
        answerButton3.isHidden = false

        restartButton.isHidden = true
        showQuestion()
    }
}
