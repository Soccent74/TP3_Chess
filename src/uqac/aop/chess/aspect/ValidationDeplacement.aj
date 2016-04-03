package uqac.aop.chess.aspect;

import uqac.aop.chess.agent.Move;

public aspect ValidationDeplacement {
	//POINTCUT
	pointcut checkMove(): 
	(

	);
	
	//ADVICE
	before() : checkMove() {
		System.out.println("POINTCUT");
				
	}
	
 
}