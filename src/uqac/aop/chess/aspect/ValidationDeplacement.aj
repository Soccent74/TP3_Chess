package uqac.aop.chess.aspect;

import uqac.aop.chess.Board;
import uqac.aop.chess.agent.*;

public aspect ValidationDeplacement {	
	public Board playgroundBoard;
	public Player p;
	pointcut checkMove(Move mv, Board bd):  
	(
		call(boolean uqac.aop.chess.agent.Player.makeMove(Move, Board)) && args(mv, bd)
	);
	
	//ADVICE
	before(Move mv, Board bd) : checkMove(mv, bd) {
		System.out.println(mv.xI);
		System.out.println(mv.yI);
		//System.out.println(bd.getGrid()[mv.xI-1][mv.yI].getPiece().getPlayer());
		this.
	}
}