import Foundation

struct QuizBrain {
    /* Atributos */
    
    let quiz = [ Question(q: "A slug's blood is green.", a: "True"),
                 Question(q: "Approximately one quarter of human bones are in the feet.", a: "True"),
                 Question(q: "The total surface area of two human lungs is approximately 70 square metres.", a: "True"),
                 Question(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: "True"),
                 Question(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: "False"),
                 Question(q: "It is illegal to pee in the Ocean in Portugal.", a: "True"),
                 Question(q: "You can lead a cow down stairs but not up stairs.", a: "False"),
                 Question(q: "Google was originally called 'Backrub'.", a: "True"),
                 Question(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: "True"),
                 Question(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: "False"),
                 Question(q: "No piece of square dry paper can be folded in half more than 7 times.", a: "False"),
                 Question(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", a: "True")
    ]
    var questionNumber = 0
    var score = 0
    var flag = false
    
    /* Métodos */
    
    // Función mutable para modificar el número de pregunta en la que vamos y regresar el valor boolean de si el usuario tuvo la respuesta correcta o no.
    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        // Comparamos la respuesta con el array de objetos de tipo Question, específicamente el atributo "answer" del objeto en el índice "questionNumber".
        if(userAnswer == quiz[questionNumber].answer) {
            // El usuario eligió la respuesta correcta
            score += 1
            return true
        }
        else {
            // El usuario eligió la respuesta incorrecta
            return false
        }
    }
    
    // Función para actualizar el número de la pregunta en la que vamos.
    mutating func nextQuestion() {
        // Si el número de pregunta todavía no llega al número de preguntas totales menos 1...
        if(questionNumber < quiz.count-1) {
            questionNumber += 1
        }
        else {
            questionNumber += 1
            // Cambiamos la bandera a verdadero
            flag = true
        }
    }
    
    /* Getters y setters */
    
    // Función que regresa el texto que debe ir en la etiqueta de la interfaz.
    func getQuestionText() -> String {
        // Esto es consulta de datos del modelo.
        return quiz[questionNumber].text
    }
    
    // Función que regresa el porcentaje de progreso para la barra de progreso de la interfaz.
    func getProgress() -> Float {
        // Esto es lógica de programación para conseguir un valor.
        return Float(questionNumber+1)/Float(quiz.count)
    }
    
    func getScore() -> Int {
        return score
    }
    
    mutating func setScore(_ score: Int) {
        self.score = score
    }
    
    func getQuestionNumber() -> Int {
        return questionNumber
    }
    
    mutating func setQuestionNumber(_ questionNumber: Int) {
        self.questionNumber = questionNumber
    }
    
    func getFlag() -> Bool {
        return flag
    }
    
    mutating func setFlag(_ flag: Bool) {
        self.flag = flag
    }
}
