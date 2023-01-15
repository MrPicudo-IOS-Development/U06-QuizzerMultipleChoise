import Foundation

struct Question {
    // Atributos necesarios para un cuestionario de opción múltiple.
    let question: String
    let answers: [String]
    let correctAnswer: String
    
    // Constructor para poder crear los objetos con la sintaxis que propuso Angela en el ReadMe
    init(q: String, a: [String], correctAnswer: String) {
        self.question = q
        self.answers = a
        self.correctAnswer = correctAnswer
    }
}
