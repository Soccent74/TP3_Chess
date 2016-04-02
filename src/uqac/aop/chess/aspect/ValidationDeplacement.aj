package uqac.aop.chess.aspect;

import uqac.aop.chess.agent.Move;

public aspect ValidationDeplacement {
	//POINTCUT
	pointcut checkMove(): 
	(
		call(boolean uqac.aop.chess.piece.Piece.isMoveLegal(Move))
	);
	
	after() : checkMove() {
		System.out.println("POINTCUT");
	}
}