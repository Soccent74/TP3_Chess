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
		int direction =4, i;
		
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
		case 4: //x>0 && y==0
			System.out.println("Erreur dans obstacleDiagonale, cas numéro 4.");
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
		int direction=4, i;
		
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
			for(i=1; i<mv.yF; i++){
				if(playground.getGrid()[mv.xI][mv.yI-i].isOccupied()){return false;}
			}
			break;
		case 3: // x<0 && y==0
			for(i=1; i<mv.xF; i++){
				if(playground.getGrid()[mv.xI+i][mv.yI].isOccupied()){return false;}
			}
			break;
		case 4: //x>0 && y==0
			System.out.println("Erreur dans obstacleDroite, cas numéro 4.");
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
		System.out.println(name);
		switch (name) {
			case "uqac.aop.chess.piece.Bishop":
				flag = obstableDiagonale(mv, playground);
				break;
				
			case "uqac.aop.chess.piece.Rook":
				flag = obstableDroite(mv, playground);
				break;
				
			case "uqac.aop.chess.piece.King":
				flag = true;
				break;
				
			case "uqac.aop.chess.piece.Pawn":
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
			System.out.println("Aucun move existant.");
		}else{
			playground = bd;
			try{
				if(playground.getGrid()[mv.xI][mv.yI].isOccupied()){
					piI = playground.getGrid()[mv.xI][mv.yI].getPiece();
					
					if(playground.getGrid()[mv.xF][mv.yF].isOccupied()){
						piF = playground.getGrid()[mv.xF][mv.yF].getPiece();
						
						if(piF.getPlayer() != piI.getPlayer()){
							if(obstacle(mv, bd, piI)){
								mv.setLegal(true);
							} else {
								mv.setLegal(false);
							}
		
						} else {
							System.out.println("ERREUR Pièce de départ et pièce à l'arrivée appartenant au même joueur.");
							mv.setLegal(false);
						}
						
					} else {
						boolean isLegal = piI.isMoveLegal(mv);
						if(isLegal){
							if(obstacle(mv, bd, piI)){
								mv.setLegal(true);
							} else {
								mv.setLegal(false);
							}
						} else {
							System.out.println("Mouvement illégal, recommencez !");
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