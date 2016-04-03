package uqac.aop.chess.aspect;

import uqac.aop.chess.Board;
import uqac.aop.chess.agent.Move;
import uqac.aop.chess.piece.*;

public aspect ValidationDeplacement {	
	public Board playground;
	public int pl;		// Symbolise le player. 
	public Piece piI, piF;
	pointcut checkMove(Move mv, Board bd):  
	(
		call(boolean uqac.aop.chess.agent.Player.makeMove(Move, Board)) && args(mv, bd)
	);
	//ADVICE
	before(Move mv, Board bd) : checkMove(mv, bd) {
		if(mv == null){
			mv.setLegal(false);
		}else{
			playground = bd;
			try{
				if(playground.getGrid()[mv.xI][mv.yI].isOccupied()){
					piI = playground.getGrid()[mv.xI][mv.yI].getPiece();
					
					if(playground.getGrid()[mv.xF][mv.yF].isOccupied()){
						piF = playground.getGrid()[mv.xI][mv.yI].getPiece();
						
						if(piF.getPlayer() != piI.getPlayer()){
							System.out.println("Le coup est possible.");
							mv.setLegal(true);
						} else {
							System.out.println("Pi�ce de d�part et pi�ce � l'arriv� appartenant au m�me joueur.");
							mv.setLegal(false);
						}
						
					} else {
						mv.setLegal(piI.isMoveLegal(mv));
					}
					
				} else {
					System.out.println("ERREUR lors de l'indication de la pi�ce � bouger.");
					mv.setLegal(false);
				}
				
				
				
			} catch (Exception e){
				System.out.println("Il n'y a aucune pi�ce � ces coordonn�es.");
			}
		}
	}
}