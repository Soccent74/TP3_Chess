package uqac.aop.chess.aspect;

import uqac.aop.chess.Board;
import uqac.aop.chess.agent.Move;
import uqac.aop.chess.piece.*;

public aspect ValidationDeplacement {	
	public Board playground;
	public int pl;		// Symbolise le player. 
	public Piece piI, piF;
	
	// METHODE
	public boolean obstableDiagonale(Move mv, Board playground){
		int x = mv.xF-mv.xI;
		int y = mv.yF-mv.yI;
		int direction, i;
		
		if(x>0 && y>0){direction=0;}
		else if(x<0 && y>0){direction=1;}
		else if(x<0 && y<0){direction=2;}
		else if(x>0 && y<0){direction=3;}
		
		switch (direction) {
		case 0: // x>0 && y>0
			for(i=1; i<x; i++){
				if(playground.getGrid()[mv.xI+i][mv.yI+i].isOccupied()){return false;}
			}
			break;
		case 1: // x< && y>0
			for(i=1; i>mv.xF; i--){
				if(playground.getGrid()[mv.xI+i][mv.yI+Math.abs(i)].isOccupied()){	return false;}
				
			}
			break;
		case 2: // x<0 && y<0
			for(i=1; i>mv.xF; i--){
				if(playground.getGrid()[mv.xI+i][mv.yI+i].isOccupied()){return false;}
			}
			break;
		case 3: // x>0 && y<0
			for(i=1; i<mv.xF; i++){
				if(playground.getGrid()[mv.xI+i][mv.yI-i].isOccupied()){return false;}
			}
			break;

		default:
			System.out.println("Erreur sur la vérification de la diagonale.");
			break;
		}
		return true; 
	}
	
	public boolean obstableDroite(Move mv, Board playground){
		int x = mv.xF-mv.xI;
		int y = mv.yF-mv.yI;
		int direction, i;
		
		if(x>0 && y==0){direction=0;}
		else if(x==0 && y>0){direction=1;}
		else if(x==0 && y<0){direction=2;}
		else if(x<0 && y==0){direction=3;}
		
		switch (direction) {
		case 0: //x>0 && y==0
			for(i=1; i<x; i++){
				if(playground.getGrid()[mv.xI+i][mv.yI].isOccupied()){return false;}
			}
			break;
		case 1: // x==0 && y>0
			for(i=1; i<mv.yF; i++){
				if(playground.getGrid()[mv.xI][mv.yI+i].isOccupied()){	return false;}
				
			}
			break;
		case 2: // x==0 && y<0
			for(i=1; i>mv.yF; i--){
				if(playground.getGrid()[mv.xI][mv.yI+i].isOccupied()){return false;}
			}
			break;
		case 3: // x<0 && y==0
			for(i=1; i>mv.xF; i--){
				if(playground.getGrid()[mv.xI+i][mv.yI].isOccupied()){return false;}
			}
			break;

		default:
			System.out.println("Erreur sur la vérification de la diagonale.");
			break;
		}
		return true; 
	}
	
	public boolean obstacle(Move mv, Board playground, Piece piece){
		boolean flag = false;
		String name = piece.getClass().getName();
		switch (name) {
		case "uqac.aop.chess.piece.rook":
			flag = obstableDiagonale(mv, playground);
			break;
		case "uqac.aop.chess.piece.Pawn":
			flag = obstableDroite(mv, playground);
			break;
		case "uqac.aop.chess.piece.King":
			flag = true;
			break;
		case "uqac.aop.chess.piece.Bishop":
			flag = true;
			break;
		case "uqac.aop.chess.piece.Knight":
			flag = true;
			break;
		case "uqac.aop.chess.piece.Queen":
			int x = mv.xF-mv.xI;
			int y = mv.yF-mv.yI;
			if(x==0 || y==0){
				flag = obstableDroite(mv, playground);
			}else{
				flag = obstableDiagonale(mv, playground);
			}
			break;
		default:
			System.out.println("ERREUR dans le choix de la piece pour le contrôle d'obstacle.");
			break;
		}
		return flag;
	}
	// POINTCUT
	pointcut checkMove(Move mv, Board bd):  
	(
		call(boolean uqac.aop.chess.agent.Player.makeMove(Move, Board)) && args(mv, bd)
	);
	
	// ADVICE
	before(Move mv, Board bd) : checkMove(mv, bd) {
		if(mv == null){
			mv.setLegal(false);
		}else{
			playground = bd;
			try{
				if(playground.getGrid()[mv.xI][mv.yI].isOccupied()){
					piI = playground.getGrid()[mv.xI][mv.yI].getPiece();
					
					if(playground.getGrid()[mv.xF][mv.yF].isOccupied()){
						piF = playground.getGrid()[mv.xF][mv.yF].getPiece();
						
						if(piF.getPlayer() != piI.getPlayer()){
							System.out.println("Le coup est possible.");
							if(obstacle(mv, bd, piI)){
								mv.setLegal(true);
							} else {
								mv.setLegal(false);
							}
							
						} else {
							System.out.println("Pièce de départ et pièce à l'arrivé appartenant au même joueur.");
							mv.setLegal(false);
						}
						
					} else {
						boolean isLegal = piI.isMoveLegal(mv);
						if(isLegal){
							mv.setLegal(isLegal);
						} else {
							System.out.println("Move illegal, try again. :)");
						}
					}
				} else {
					System.out.println("ERREUR lors de l'indication de la pièce à bouger.");
					mv.setLegal(false);
				}
			} catch (Exception e){
				System.out.println("Il n'y a aucune pièce à ces coordonnées.");
			}
		}
	}
}