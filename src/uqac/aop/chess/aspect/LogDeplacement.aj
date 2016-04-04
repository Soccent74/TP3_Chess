package uqac.aop.chess.aspect;

import java.io.File;
import java.io.FileWriter;

import uqac.aop.chess.Board;
import uqac.aop.chess.Spot;
import uqac.aop.chess.agent.Move;
import uqac.aop.chess.agent.Player;
import uqac.aop.chess.piece.Piece;

public aspect LogDeplacement {
	//POINCUT
	pointcut logDeplacement(Move mv, Board bd):
	(
		execution (boolean uqac.aop.chess.agent.Player.makeMove(Move, Board)) && args(mv, bd)
	);
	pointcut resetFichier():
	(
		execution (void uqac.aop.chess.Chess.play())		
	);
	
	//ADVICE
	after(Move mv, Board bd): logDeplacement(mv, bd) {
		String POSXI = "";
		String POSXF = "";
		int POSYI;
		int POSYF;
		String coup = "";
		Board playground = bd;
		
		if (mv.getLegal() == true){
			try{
				File fichier = new File("C:\\Users\\Lucas\\Documents\\GitHub\\TP3_Chess\\log.txt"); //Chemin du fichier
				FileWriter ffw = new FileWriter(fichier, true);
				Piece piece = playground.getGrid()[mv.xF][mv.yF].getPiece();
				for (int i = 0; i<9;i++){
					POSXI = String.valueOf(mv.xI);
					POSXF = String.valueOf(mv.xF);
				}
				switch (POSXI){
				case "0" : POSXI = "a"; break;
				case "1" : POSXI = "b"; break;
				case "2" : POSXI = "c"; break;
				case "3" : POSXI = "d"; break;
				case "4" : POSXI = "e"; break;
				case "5" : POSXI = "f"; break;
				case "6" : POSXI = "g"; break;
				case "7" : POSXI = "h"; break;
				default : POSXI = "X";
				}
				switch (POSXF){
				case "0" : POSXF = "a"; break;
				case "1" : POSXF = "b"; break;
				case "2" : POSXF = "c"; break;
				case "3" : POSXF = "d"; break;
				case "4" : POSXF = "e"; break;
				case "5" : POSXF = "f"; break;
				case "6" : POSXF = "g"; break;
				case "7" : POSXF = "h"; break;
				default : POSXF = "X";
				}

				POSYI = mv.yI+1;
				POSYF = mv.yF+1;
				if (piece.getPlayer() == 1){
					coup = "Joueur Humain " + POSXI + POSYI + " vers " + POSXF + POSYF + " \n ";
				}else{
					coup = "Joueur IA     " + POSXI + POSYI + " vers " + POSXF + POSYF + " \n ";
				}
				System.out.println(coup);
				try {
					ffw.write(coup);  //Ecrit une ligne dans le fichier log.txt
					ffw.write("\r\n"); //Force le passage à la ligne
				} finally {
					ffw.close();//Ferme le fichier à la fin des traitements
				}
			} catch (Exception e) {
				System.out.println("ERREUR ECRITURE");
			}
		}else{
			System.out.println("Le coup n'est pas enregistré");
		}
	}
	
	before() : resetFichier(){
		try{
			File fichier = new File("C:\\Users\\Lucas\\Documents\\GitHub\\TP3_Chess\\log.txt"); //Chemin du fichier
			fichier.createNewFile();
			FileWriter fichierw = new FileWriter(fichier, false);
			System.out.println("CREATION FICHIER");
			try{
			} finally{
			fichierw.close();
			}
		} catch(Exception e){
			System.out.println("ERREUR CREATION FICHIER");
		}
	}
}
