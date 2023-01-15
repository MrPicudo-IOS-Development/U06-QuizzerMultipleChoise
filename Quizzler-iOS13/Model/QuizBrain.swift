import Foundation

struct QuizBrain {
    
    /* Atributos */
    
    // Arreglo de objetos tipo Question para la aplicación.
    let quiz = [ Question(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], correctAnswer: "Skin"),
                 Question(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], correctAnswer: "100"),
                 Question(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
                 Question(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
                 Question(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], correctAnswer: "Watch"),
                 Question(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
                 Question(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], correctAnswer: "Orange"),
                 Question(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], correctAnswer: "Rum"),
                 Question(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], correctAnswer: "Gorilla"),
                 Question(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia")

    ]
    // Variables primitivas para la aplicación
    var questionNumber = 0
    var score = 0
    var flag = false
    
    
    /* Métodos */
    
    /* Esta función puede ser llamada aún cuando se ha TERMINADO EL CUESTIONARIO, mientras se están mostrando los resultados. Por eso se necesita cambiar de vista o bloquear los botones. */
    // Función mutable para modificar el número de pregunta en la que vamos y regresar el valor boolean de si el usuario tuvo la respuesta correcta o no.
    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        // Comparamos la respuesta con el array de objetos de tipo Question, específicamente el atributo "answer" del objeto en el índice "questionNumber".
        if(userAnswer == quiz[questionNumber].correctAnswer) {
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
        return quiz[questionNumber].question
    }
    
    // Función que regresa el porcentaje de progreso para la barra de progreso de la interfaz.
    func getProgress() -> Float {
        // Esto es lógica de programación para conseguir un valor.
        return Float(questionNumber+1)/Float(quiz.count)
    }
    
    // Getter del score
    func getScore() -> Int {
        return score
    }
    
    // Setter del score, para modificar el valor a cero desde el controlador.
    mutating func setScore(_ score: Int) {
        self.score = score
    }
    
    // Getter del questionNumber
    func getQuestionNumber() -> Int {
        return questionNumber
    }
    
    // Setter del questionNumber, se usa igual que el de la score.
    mutating func setQuestionNumber(_ questionNumber: Int) {
        self.questionNumber = questionNumber
    }
    
    // Getter de la bandera que nos indica si ya se terminó el cuestionario o no.
    func getFlag() -> Bool {
        return flag
    }
    
    // Setter de la bandera, para reiniciar su valor desde el controlador.
    mutating func setFlag(_ flag: Bool) {
        self.flag = flag
    }
    
    // Getter de las opciones, para mostrarlas en el texto de los botones.
    func getOpcions(_ pos: Int) -> String {
        return quiz[questionNumber].answers[pos]
    }
    
}
