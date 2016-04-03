package uqac.aop.chess.aspect;

import uqac.aop.chess.agent.Move;

public aspect ValidationDeplacement {
	pointcut checkMove(Move mv): 
		target(mv) && (
			call(boolean uqac.aop.chess.piece.Piece.isMoveLegal(Move))
	);
 
	before(Move mv) : checkMove(mv) {
		System.out.println("POINTCUT");
	}
}