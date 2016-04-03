package uqac.aop.chess.aspect;

import uqac.aop.chess.Board;
import uqac.aop.chess.agent.Move;
import uqac.aop.chess.piece.*;

public aspect ValidationDeplacement {	
	public Board playground;
	public int pl;		// Symbolise le player. 
	public Piece piI, piF;
	
	// POINTCUT
	pointcut checkMove(Move mv, Board bd):  
	(
		call(boolean uqac.aop.chess.agent.Player.makeMove(Move, Board)) && args(mv, bd)
	);
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
							mv.setLegal(true);
							//System.out.println(piF.getClass().getName());
							//System.out.println(piI.getClass().getName());
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