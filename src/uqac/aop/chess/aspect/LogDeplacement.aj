package uqac.aop.chess.aspect;

import java.io.File;
import java.io.FileWriter;

import uqac.aop.chess.agent.Move;

public aspect LogDeplacement {
	//POINCUT
	pointcut logDeplacement():
	(
		execution (Move uqac.aop.chess.agent.HumanPlayer.makeMove()) ||
		execution (Move uqac.aop.chess.agent.AiPlayer.makeMove())
	);
	pointcut resetFichier():
	(
		execution (void uqac.aop.chess.Chess.play())		
	);
	
	//ADVICE
	after() returning (Move mv): logDeplacement() {
		String POSXI = "";
		String POSXF = "";
		String coup = "";
		boolean joueur;
		for (int i = 0; i<9;i++){
			POSXI = String.valueOf(mv.xI);
			POSXF = String.valueOf(mv.xF);
		}
		switch (mv.yI){
			case 0 : mv.yI = 1; break;
			case 1 : mv.yI = 2; break;
			case 2 : mv.yI = 3; break;
			case 3 : mv.yI = 4; break;
			case 4 : mv.yI = 5; break;
			case 5 : mv.yI = 6; break;
			case 6 : mv.yI = 7; break;
			case 7 : mv.yI = 8; break;
			default : mv.yI = mv.yI;
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
		switch (mv.yF){
			case 0 : mv.yF = 1; break;
			case 1 : mv.yF = 2; break;
			case 2 : mv.yF = 3; break;
			case 3 : mv.yF = 4; break;
			case 4 : mv.yF = 5; break;
			case 5 : mv.yF = 6; break;
			case 6 : mv.yF = 7; break;
			case 7 : mv.yF = 8; break;
			default : mv.yF = mv.yF;
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
		try{
			File fichier = new File("C:\\Users\\Lucas\\Documents\\GitHub\\TP3_Chess\\log.txt"); //Chemin du fichier
			FileWriter ffw = new FileWriter(fichier, true);
			joueur = true;
			if (joueur == true){
				coup = "Joueur Humain " + POSXI + mv.yI + " vers " + POSXF + mv.yF + " \n ";
				joueur = false;
				//System.out.println(joueur);
			}else{
				coup = "Joueur IA " + POSXI + mv.yI + " vers " + POSXF + mv.yF + " \n ";
				joueur = true;
				//System.out.println(joueur);
			}
			//System.out.println(coup);
			try {
				ffw.write(coup);  //Ecrit une ligne dans le fichier log.txt
				ffw.write("\r\n"); //Force le passage à la ligne
            } finally {
                ffw.close();//Ferme le fichier à la fin des traitements
            }
		} catch (Exception e) {
			System.out.println("ERREUR ECRITURE");
		}
	}
	
	before() : resetFichier(){
		try{
			File fichier = new File("C:\\Users\\Lucas\\Documents\\GitHub\\uqac_POA_TP3\\log.txt"); //Chemin du fichier
			fichier.createNewFile();
			FileWriter fichierw = new FileWriter(fichier, false);
			System.out.println("CREATION FICHIER");
			try{
			} finally{
			fichierw.close();
			}
		} catch(Exception e){
			System.out.println("ERREUR CREATION");
		}
	}
}
