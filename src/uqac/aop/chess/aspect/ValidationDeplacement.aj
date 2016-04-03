package uqac.aop.chess.aspect;

import java.io.File;
import java.io.FileWriter;

import uqac.aop.chess.agent.Move;

public aspect ValidationDeplacement {
	pointcut checkMove(Move mv): 
		target(mv) && (
			call(boolean uqac.aop.chess.piece.Piece.isMoveLegal(Move))
	);
<<<<<<< HEAD
	pointcut logDeplacement():
	(
		execution (Move uqac.aop.chess.agent.HumanPlayer.makeMove()) ||
		execution (Move uqac.aop.chess.agent.AiPlayer.makeMove())
	);
	
	//ADVICE
	after() : checkMove() {
=======
 
	before(Move mv) : checkMove(mv) {
>>>>>>> origin/master
		System.out.println("POINTCUT");
	}
	
	after() returning (Move mv): logDeplacement() {
		System.out.println("LOG");
		String coup = mv.xI + mv.yI + " vers " + mv.xF + mv.yF + " \n ";
		try{
			File fichier = new File("C:\\Users\\Lucas\\Documents\\GitHub\\uqac_POA_TP3\\log.txt"); // d�finir l'arborescence
			fichier.createNewFile();
			FileWriter ffw = new FileWriter(fichier);
			ffw.write(coup);  // �crire une ligne dans le fichier resultat.txt
			ffw.write("\n"); // forcer le passage � la ligne
			ffw.close(); // fermer le fichier � la fin des traitements
		} catch (Exception e) {
			System.out.println("ERREUR");
		}
		
	}
}