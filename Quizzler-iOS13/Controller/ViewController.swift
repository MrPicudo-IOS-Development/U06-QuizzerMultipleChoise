import UIKit

// Necesitamos hacer un import para las clases que controlan el audio y el video
import AVFoundation

class ViewController: UIViewController {
    
    // Variables conectadas a la interfaz
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!

    // Con este objeto accedemos a todos los métodos del modelo para conseguir información desde el controlador y acceder a la lógica de programación.
    var quizBrain = QuizBrain()
    
    // Creamos el objeto para poder acceder a los métodos de la biblioteca de audio y video.
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // questionLabel.text = quiz[Int.random(in: 0...5)]
        updateUI()
    }

    // Función para los botones de true y false
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        // Hacemos ligeramente transparente el botón presionado y modificamos la fuente del botón presionado.
        sender.alpha = 0.5
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27.0)
        
        // Mandamos a llamar a la función para revisar la respuesta del usuario en una estructura condicional para retroalimentar sobre la respuesta seleccionada.
        if (quizBrain.checkAnswer(sender.currentTitle!)) { // La respuesta que ha seleccionado el usuario está en "sender.currentTitle!"
            questionLabel.text = "Correct! 😎" // Actualizamos el texto de la etiqueta con el resultado de la respuesta elegida.
            playSound(name: "Correct")
            sender.backgroundColor = UIColor.init(red: 84.0, green: 227.0, blue: 70.0, alpha: 0.5) // Al ingresar rangos incorrectos, manda un color blanco por default.
        }
        else {
            questionLabel.text = "Wrong! ☹️"
            playSound(name: "Wrong")
            // El rango de valores que admite el init del color es de 0.0 a 1.0
            sender.backgroundColor = UIColor.init(red: 0.9804, green: 0.6706, blue: 0.4706, alpha: 0.8)
        }
        
        // Esta función modifica el número de pregunta desde la primera vez que es presionado un botón.
        quizBrain.nextQuestion()
        
        // Deshabilitamos los botones en el momento en que terminan el quiz para que no se pueda presionar mientras muestra resultados y se exceda el tamaño de los arrays.
        if(quizBrain.getQuestionNumber() == quizBrain.quiz.count) {
            topButton.isEnabled = false
            middleButton.isEnabled = false
            bottomButton.isEnabled = false
            // Eliminamos el texto de los botones un poco después de que fueron presionados.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [self] in
                topButton.setTitle(" ", for: .normal)
                middleButton.setTitle(" ", for: .normal)
                bottomButton.setTitle(" ", for: .normal)
            }
        }
        
        // El siguiente método hace que el programa espere 0.4 segundos para realizar lo que tenga en su bloque de código.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.updateUI() // Actualizamos la etiqueta a la siguiente pregunta.
        }
    }
    
    // Función para cambiar la pregunta mostrada en la interfaz, reiniciar las características de los botones y actualizar la barra de progreso
    func updateUI() {
        // Reiniciamos las características visuales de los botones de respuesta
        topButton.backgroundColor = UIColor.clear
        topButton.titleLabel?.font = UIFont.systemFont(ofSize: 25.0)
        topButton.alpha = 1.0
        middleButton.backgroundColor = UIColor.clear
        middleButton.titleLabel?.font = UIFont.systemFont(ofSize: 25.0)
        middleButton.alpha = 1.0
        bottomButton.backgroundColor = UIColor.clear
        bottomButton.titleLabel?.font = UIFont.systemFont(ofSize: 25.0)
        bottomButton.alpha = 1.0
        if(quizBrain.getFlag()) {
            // Mostramos los resultados finales
            scoreLabel.text = "🥳 🥳 🥳 🥳 🥳 🥳 🥳 🥳 🥳 🥳"
            questionLabel.text = "Score: \(quizBrain.getScore()) / \(quizBrain.getQuestionNumber())"
            quizBrain.setFlag(false)
            // Reiniciamos los valores justo después de utilizarlos para los resultados finales en la interfaz.
            quizBrain.setQuestionNumber(0)
            quizBrain.setScore(0)
            // Reiniciamos la interfaz
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in // DUDA ***
                questionLabel.text = quizBrain.getQuestionText()
                scoreLabel.text = "Score: \(quizBrain.getScore()) / \(quizBrain.getQuestionNumber())"
                progressBar.progress = quizBrain.getProgress()
                // Opciones de los botones de respuesta.
                topButton.setTitle(quizBrain.getOpcions(0), for: .normal)
                middleButton.setTitle(quizBrain.getOpcions(1), for: .normal)
                bottomButton.setTitle(quizBrain.getOpcions(2), for: .normal)
                // Volvemos a activar los botones:
                topButton.isEnabled = true
                middleButton.isEnabled = true
                bottomButton.isEnabled = true
            }
        }
        else {
            questionLabel.text = quizBrain.getQuestionText()
            scoreLabel.text = "Score: \(quizBrain.getScore()) / \(quizBrain.getQuestionNumber())"
            progressBar.progress = quizBrain.getProgress()
            // Opciones de los botones de respuesta.
            topButton.setTitle(quizBrain.getOpcions(0), for: .normal)
            middleButton.setTitle(quizBrain.getOpcions(1), for: .normal)
            bottomButton.setTitle(quizBrain.getOpcions(2), for: .normal)
        }
    }
    
    // Función necesaria para reproducir sonidos:
    func playSound(name: String) {
        let url = Bundle.main.url(forResource: name, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
